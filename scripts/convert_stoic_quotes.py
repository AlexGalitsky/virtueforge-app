#!/usr/bin/env python3
"""Convert legacy stoic_quotes.json → editable assets/quotes/{en,ru}.json.

Usage (from virtue_forge/):
  py -3 scripts/convert_stoic_quotes.py
  py -3 scripts/convert_stoic_quotes.py --keep-duplicates
"""

from __future__ import annotations

import argparse
import json
import re
import unicodedata
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "stoic_quotes.json"
OUT_DIR = ROOT / "assets" / "quotes"

# Light author cleanup for stable ids only — `author` field stays as in source
# (or uses the canonical label when matched).
AUTHOR_CANONICAL = {
    "zeno": "Zeno of Citium",
    "zeno of citium": "Zeno of Citium",
    "zeno of citium, as quoted by diogenes laërtius": "Zeno of Citium",
    "zeno of citium, as quoted by diogenes laertius": "Zeno of Citium",
    "seneca": "Seneca",
    "lucius annaeus seneca": "Seneca",
    "seneca the younger": "Seneca",
    "lucius seneca": "Seneca",
    "seneca lucius annaeus": "Seneca",
    "marcus aurelius": "Marcus Aurelius",
    "epictetus": "Epictetus",
    "epicteto": "Epictetus",
}


def slugify(value: str) -> str:
    value = unicodedata.normalize("NFKD", value)
    value = value.encode("ascii", "ignore").decode("ascii")
    value = value.lower()
    value = re.sub(r"[^a-z0-9]+", "_", value)
    return value.strip("_") or "unknown"


def normalize_author(raw: str) -> str:
    key = re.sub(r"\s+", " ", raw.strip().lower())
    return AUTHOR_CANONICAL.get(key, raw.strip() or "Unknown")


def convert(keep_duplicates: bool) -> tuple[list[dict], dict]:
    with SRC.open(encoding="utf-8") as f:
        payload = json.load(f)

    raw_quotes = payload.get("quotes", payload)
    if not isinstance(raw_quotes, list):
        raise SystemExit("Expected top-level {\"quotes\": [...]} or a JSON array")

    seen_texts: set[str] = set()
    per_author_count: dict[str, int] = defaultdict(int)
    converted: list[dict] = []
    stats = {
        "source": 0,
        "skipped_empty": 0,
        "skipped_duplicate": 0,
        "written": 0,
    }

    for item in raw_quotes:
        stats["source"] += 1
        text = (item.get("text") or "").strip()
        if not text:
            stats["skipped_empty"] += 1
            continue

        text_key = re.sub(r"\s+", " ", text.casefold())
        if not keep_duplicates and text_key in seen_texts:
            stats["skipped_duplicate"] += 1
            continue
        seen_texts.add(text_key)

        author = normalize_author(item.get("author") or "")
        per_author_count[author] += 1
        n = per_author_count[author]
        quote_id = f"{slugify(author)}_{n:04d}"

        converted.append(
            {
                "id": quote_id,
                "text": text,
                "author": author,
                # Fill while curating — empty means unused in focus filters.
                "virtueWeekNumbers": [],
                "stoicCategory": None,
            }
        )

    stats["written"] = len(converted)
    return converted, stats


def write_locale(path: Path, quotes: list[dict], *, blank_text: bool) -> None:
    rows = []
    for q in quotes:
        rows.append(
            {
                "id": q["id"],
                "text": "" if blank_text else q["text"],
                "author": q["author"],
                "virtueWeekNumbers": list(q["virtueWeekNumbers"]),
                "stoicCategory": q["stoicCategory"],
            }
        )
    path.write_text(
        json.dumps(rows, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--keep-duplicates",
        action="store_true",
        help="Keep exact duplicate texts (default: dedupe)",
    )
    parser.add_argument(
        "--skip-ru-stub",
        action="store_true",
        help="Do not write assets/quotes/ru.json translation stub",
    )
    args = parser.parse_args()

    if not SRC.exists():
        raise SystemExit(f"Source not found: {SRC}")

    quotes, stats = convert(keep_duplicates=args.keep_duplicates)
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    en_path = OUT_DIR / "en.json"
    write_locale(en_path, quotes, blank_text=False)

    if not args.skip_ru_stub:
        ru_path = OUT_DIR / "ru.json"
        write_locale(ru_path, quotes, blank_text=True)
        print(f"Wrote RU stub: {ru_path} ({stats['written']} empty texts)")

    print(f"Wrote EN: {en_path}")
    print(
        "Stats: "
        f"source={stats['source']}, "
        f"empty={stats['skipped_empty']}, "
        f"duplicates={stats['skipped_duplicate']}, "
        f"written={stats['written']}"
    )
    print(
        "Next: fill virtueWeekNumbers (1–13), stoicCategory "
        "(temperance|wisdom|courage|justice), and RU translations."
    )


if __name__ == "__main__":
    main()
