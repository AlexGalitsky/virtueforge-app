# VirtueForge

Cross-platform Flutter app (iOS / Android) for mental discipline: a Stoic
compass plus Benjamin Franklin’s virtue-tracking method.

> *“Waste no more time arguing about what a good man should be. Be one.”*
> — Marcus Aurelius

Journal data stays **local-first** on device (no account / cloud sync). Network
is used only to refresh Portico quotes and essays from the content API.

Companion API: [virtueforge-backend](https://github.com/alexgalitsky/virtueforge-backend).

## Features

- **Journal** — 13×7 Franklin grid, focus week, strike notes, evening reflection
- **Temple** — four Stoic pillars, XP ledger, Memento Mori
- **Portico** — quotes & essays (API + offline cache/bundle)
- **Order** — cycles, locale (EN/RU), theme, reminders, virtue editor
- Optional **on-device Mentor** (GGUF) — journal text never leaves the device for inference

## Stack

Flutter · Clean Architecture / feature-first · BLoC · Drift (SQLite) · GoRouter · GetIt · ARB l10n

## Quick start

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
flutter run
```

With a local content API:

```bash
# Android emulator
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000

# iOS simulator / desktop
flutter run --dart-define=API_BASE_URL=http://127.0.0.1:3000
```

```bash
flutter test
```

## License

Proprietary / all rights reserved unless noted otherwise in-tree.
