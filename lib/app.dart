import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'features/search/screens/search_destination_screen.dart';
import 'features/booking/screens/vehicle_selection_screen.dart';
import 'features/trip/screens/searching_driver_screen.dart';
import 'features/trip/screens/driver_accepted_screen.dart';
import 'features/trip/screens/trip_progress_screen.dart';
import 'features/trip/screens/trip_finished_screen.dart';
import 'features/trip/screens/rating_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/wallet/screens/wallet_screen.dart';
import 'features/history/screens/trip_history_screen.dart';

class RideHailingApp extends StatelessWidget {
  const RideHailingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RideGo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (_, __) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (_, __) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.searchDestination,
      builder: (_, __) => const SearchDestinationScreen(),
    ),
    GoRoute(
      path: AppRoutes.vehicleSelection,
      builder: (_, __) => const VehicleSelectionScreen(),
    ),
    GoRoute(
      path: AppRoutes.searchingDriver,
      builder: (_, __) => const SearchingDriverScreen(),
    ),
    GoRoute(
      path: AppRoutes.driverAccepted,
      builder: (_, __) => const DriverAcceptedScreen(),
    ),
    GoRoute(
      path: AppRoutes.tripProgress,
      builder: (_, __) => const TripProgressScreen(),
    ),
    GoRoute(
      path: AppRoutes.tripFinished,
      builder: (_, __) => const TripFinishedScreen(),
    ),
    GoRoute(
      path: AppRoutes.rating,
      builder: (_, __) => const RatingScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (_, __) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.wallet,
      builder: (_, __) => const WalletScreen(),
    ),
    GoRoute(
      path: AppRoutes.tripHistory,
      builder: (_, __) => const TripHistoryScreen(),
    ),
  ],
);

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const searchDestination = '/search';
  static const vehicleSelection = '/vehicle-selection';
  static const searchingDriver = '/searching-driver';
  static const driverAccepted = '/driver-accepted';
  static const tripProgress = '/trip-progress';
  static const tripFinished = '/trip-finished';
  static const rating = '/rating';
  static const profile = '/profile';
  static const wallet = '/wallet';
  static const tripHistory = '/trip-history';
}
