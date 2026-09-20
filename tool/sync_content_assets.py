#!/usr/bin/env python3
"""Sync Portico quote gzip assets for the Flutter app.

Canonical essay bodies/analyses come from Postgres via:
  cd ../virtue-forge-backend && npm run db:export-assets

This script only compresses quote JSON for the APK. Optional:
  python tool/sync_content_assets.py --from-archive
    copies archive MD (legacy; can overwrite DB export — avoid after export).

Usage (from virtue_forge/):
  python tool/sync_content_assets.py
"""

from __future__ import annotations

import gzip
import shutil
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARCHIVE = ROOT.parent / "virtue-forge-backend" / "archive" / "content-files" / "library"
QUOTES = ROOT / "assets" / "quotes"
LIBRARY = ROOT / "assets" / "library"


def gzip_quotes() -> None:
    for name in ("en.json", "ru.json"):
        src = QUOTES / name
        if not src.exists():
            print(f"skip missing {src}", file=sys.stderr)
            continue
        dst = QUOTES / f"{name}.gz"
        data = src.read_bytes()
        with gzip.open(dst, "wb", compresslevel=9) as f:
            f.write(data)
        print(f"{name}: {len(data)} -> {dst.stat().st_size} bytes")


def copy_essays_from_archive() -> None:
    if not ARCHIVE.is_dir():
        raise SystemExit(f"Archive not found: {ARCHIVE}")
    count = 0
    total = 0
    for md in ARCHIVE.rglob("*.md"):
        rel = md.relative_to(ARCHIVE)
        out = LIBRARY / rel
        out.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(md, out)
        count += 1
        total += out.stat().st_size
    print(f"copied {count} markdown files ({total} bytes) -> {LIBRARY}")


def main() -> None:
    gzip_quotes()
    if "--from-archive" in sys.argv:
        print("WARNING: --from-archive overwrites library MD; prefer db:export-assets", file=sys.stderr)
        copy_essays_from_archive()


if __name__ == "__main__":
    main()
