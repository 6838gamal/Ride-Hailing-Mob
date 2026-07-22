---
name: Flutter Ride Hailing App
description: Architecture, setup, and key decisions for the RideGo Flutter ride-hailing app project.
---

# RideGo Flutter App — Key Decisions

## Why flutter_map (not google_maps_flutter)
OpenStreetMap via `flutter_map` requires no API key — runs immediately. When a Google Maps key is available, swap to `google_maps_flutter` package.

## Flutter not available on Replit
No Flutter Replit module exists (`listAvailableModules({ language: "flutter" })` returns 0 results). Code runs locally or via CI. Dart 3.10 module is available but alone isn't enough to run Flutter.

## Font setup
`google_fonts` (Inter) is used for all typography — no bundled font files needed. The `AppFont` family and `assets/fonts/` were removed to avoid invalid TTF errors.

## State management: Provider
Lightweight, no code generation. 3 providers: `AppProvider` (theme/locale), `LocationProvider` (GPS/pickup/dropoff), `TripProvider` (trip state machine).

## Design system files
All tokens in `lib/core/theme/` — import `app_spacing.dart` to get `AppSpacing`, `AppRadius`, AND `AppShadows` (all defined in same file).

**How to apply:** Import `app_spacing.dart` when any of the three classes are needed.
