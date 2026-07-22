# RideGo — Ride Hailing App

A premium Flutter ride-hailing mobile app with rich motion design, live map tracking, and full passenger/driver/admin flows.

## Project Overview

RideGo is a production-ready Flutter codebase built from a comprehensive product design brief, covering:
- Passenger app (full trip flow: search → book → track → pay → rate)
- Design system (colors, typography, spacing, shadows, animations)
- Live map integration via `flutter_map` + OpenStreetMap (no API key required)
- Motion design: pulse animations, car animations, page transitions
- Driver and admin foundations

## Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart SDK ^3.0.0) |
| Maps | flutter_map + OpenStreetMap |
| Navigation | go_router |
| State | provider |
| Animations | flutter_animate + rive + lottie |
| Typography | google_fonts (Inter) |
| Location | geolocator + permission_handler |

## Project Structure

```
lib/
  core/
    theme/          # Design system: colors, typography, spacing, theme
    constants/      # App constants, animation specs
    providers/      # App, location, trip state
  features/
    splash/         # Animated splash screen
    onboarding/     # 3-slide onboarding
    auth/           # Login + Register screens
    home/           # Map home with nearby drivers
    search/         # Destination search
    booking/        # Vehicle selection + payment
    trip/           # Full trip flow (searching → progress → finish → rating)
    profile/        # User profile
    wallet/         # Wallet & payments
    history/        # Trip history
  shared/
    widgets/        # Reusable: AppButton, AppTextField, PulseRing, StarRating
  app.dart          # GoRouter configuration
  main.dart         # App entry point
assets/
  animations/       # Lottie JSON files
  images/           # PNGs, illustrations
  icons/            # SVG icons
docs/
  design_document.md  # Full bilingual (AR/EN) product design spec
```

## Running the App

Flutter is **not installed** in this Replit environment. To run:

### Option A — Run locally
```bash
flutter pub get
flutter run                    # Android/iOS emulator
flutter run -d chrome          # Web browser
```

### Option B — Run on Replit (Flutter Web)
```bash
# Install Flutter SDK manually or use a custom Nix derivation
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 5000
```

### Option C — Build APK
```bash
flutter pub get
flutter build apk --release
```

## Key Design Decisions

- **OpenStreetMap over Google Maps** — no API key needed; swap to `google_maps_flutter` when a Maps API key is available.
- **flutter_animate** for declarative animations — all page transitions and micro-interactions use this library.
- **4pt grid system** — all spacing values are multiples of 4 via `AppSpacing`.
- **Provider** for state — lightweight, no code generation required; easy to swap for Bloc/Riverpod.
- **Inter font** via google_fonts — clean, modern, readable at all sizes.

## Design System Quick Reference

| Token | Value |
|---|---|
| Primary | `#1B4FFF` |
| Accent (Gold) | `#FFD60A` |
| Background | `#F5F7FA` |
| Success | `#10B981` |
| Error | `#EF4444` |
| Border Radius base | 14px |
| Button height | 56px |
| Screen padding | 20px |

## User Preferences

- Build in Flutter/Dart
- Both Arabic and English outputs
- Premium, motion-rich, "alive" UI inspired by DiDi, Uber, Grab, Careem
