import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import "package:smart_budget_ph/features/onboarding/presentation/screens/onboarding_screen.dart";
import "package:smart_budget_ph/features/onboarding/presentation/screens/splash_screen.dart";
import "package:smart_budget_ph/features/auth/presentation/screens/login_screen.dart";
import "package:smart_budget_ph/features/auth/presentation/screens/signup_screen.dart";
import "package:smart_budget_ph/features/home/presentation/screens/home_screen.dart";
import "package:smart_budget_ph/features/transaction/presentation/screens/transaction_screen.dart";
import "package:smart_budget_ph/features/reports/presentation/screens/report_screen.dart";
//Reminders
import "package:smart_budget_ph/features/reminders/presentation/screens/reminder_screen.dart";
import "package:smart_budget_ph/features/reminders/widgets/reminder_picker.dart";

//Accounts
import "package:smart_budget_ph/features/accounts/presentation/screens/account_screen.dart";
import "package:smart_budget_ph/features/accounts/presentation/screens/categories_screen.dart";
import "package:smart_budget_ph/features/accounts/presentation/screens/edit_profile_screen.dart";
import "package:smart_budget_ph/features/accounts/presentation/screens/export_data_screen.dart";
import "package:smart_budget_ph/features/accounts/presentation/screens/notification_settings_screen.dart";
import "package:smart_budget_ph/features/accounts/presentation/screens/security_privacy_screen.dart";

// Helpers
import 'package:smart_budget_ph/core/routes/app_routes.dart';

//Navigation Widget
import 'package:smart_budget_ph/core/widgets/main_wrapper.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.splash,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
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
              routes: [
                GoRoute(
                  path: Routes.set,
                  builder: (context, state) => const SetReminderWidget(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.account,
              builder: (context, state) => const AccountScreen(),
              routes: [
                GoRoute(
                  path: Routes.editprofile,
                  builder: (BuildContext context, state) =>
                      const EditProfileScreen(),
                ),
                GoRoute(
                  path: Routes.exportdata,
                  builder: (BuildContext context, GoRouterState state) =>
                      const ExportDataScreen(),
                ),
                GoRoute(
                  path: Routes.notificationsettings,
                  builder: (BuildContext context, GoRouterState state) =>
                      const NotificationsSettingsScreen(),
                ),
                GoRoute(
                  path: Routes.securityprivacy,
                  builder: (BuildContext context, GoRouterState state) =>
                      const SecurityPrivacyScreen(),
                ),
                GoRoute(
                  path: Routes.categories,
                  builder: (BuildContext context, GoRouterState state) =>
                      const CategoriesScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
