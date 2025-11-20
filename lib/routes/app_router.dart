import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import 'package:smart_budget_ph/splash_screen/splash.dart';
import 'package:smart_budget_ph/onboarding_screen/onboarding_screen.dart';
import 'package:smart_budget_ph/auth/screen/login_screen.dart';
import 'package:smart_budget_ph/auth/screen/signup_screen.dart';
import 'package:smart_budget_ph/screen/home_screen.dart';
import 'package:smart_budget_ph/screen/transaction_screen.dart';
import 'package:smart_budget_ph/screen/report_screen.dart';
import 'package:smart_budget_ph/screen/reminder_screen.dart';
import 'package:smart_budget_ph/screen/account_screen.dart';

// Helpers
import 'package:smart_budget_ph/routes/helper/routes.dart';

//Navigation Widget
import 'package:smart_budget_ph/widget/navigation_widget.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.splash,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const CustomSplashScreen(),
    ),
    GoRoute(
      path: Routes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) => const SignupScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavigationWidget(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.transaction,
              builder: (context, state) => const TransactionScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.report,
              builder: (context, state) => const ReportScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.reminder,
              builder: (context, state) => const RemindersScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.account,
              builder: (context, state) => const AccountScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
