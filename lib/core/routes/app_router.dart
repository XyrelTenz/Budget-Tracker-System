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
// Reminders
import "package:smart_budget_ph/features/reminders/presentation/screens/reminder_screen.dart";
import "package:smart_budget_ph/features/reminders/presentation/screens/set_reminder_screen.dart";

// Accounts
import "package:smart_budget_ph/features/accounts/presentation/screens/account_screen.dart";
import "package:smart_budget_ph/features/accounts/presentation/screens/categories_screen.dart";
import "package:smart_budget_ph/features/accounts/presentation/screens/edit_profile_screen.dart";
import "package:smart_budget_ph/features/accounts/presentation/screens/export_data_screen.dart";
import "package:smart_budget_ph/features/accounts/presentation/screens/notification_settings_screen.dart";
// SecurityPrivacyScreen
import "package:smart_budget_ph/features/accounts/presentation/screens/security_privacy_screen.dart";
import "package:smart_budget_ph/features/accounts/presentation/screens/security_privacy/change_password_screen.dart";
import "package:smart_budget_ph/features/accounts/presentation/screens/security_privacy/manage_devices_screen.dart";

// Helpers
import 'package:smart_budget_ph/core/routes/app_routes.dart';
import "../utils/animation/transiation_page_animation.dart";

// Navigation Widget
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
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),

    // Login: Slide from Right
    GoRoute(
      path: Routes.login,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const LoginScreen(),
      ),
    ),

    GoRoute(
      path: Routes.register,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const SignupScreen(),
      ),
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
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const SetReminderScreen(),
                        slideFromBottom: true,
                      ),
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
                // Edit Profile
                GoRoute(
                  path: Routes.editprofile,
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const EditProfileScreen(),
                      ),
                ),
                // Export Data
                GoRoute(
                  path: Routes.exportdata,
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const ExportDataScreen(),
                      ),
                ),
                // Notifications
                GoRoute(
                  path: Routes.notificationsettings,
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const NotificationsSettingsScreen(),
                      ),
                ),
                // Categories
                GoRoute(
                  path: Routes.categories,
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const CategoriesScreen(),
                      ),
                ),
                GoRoute(
                  path: Routes.securityprivacy,
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const SecurityPrivacyScreen(),
                      ),
                  routes: [
                    // Change Password (Nested)
                    GoRoute(
                      path: Routes.changepassword,
                      pageBuilder: (context, state) =>
                          buildPageWithDefaultTransition(
                            context: context,
                            state: state,
                            child: const ChangePasswordScreen(),
                          ),
                    ),
                    GoRoute(
                      path: Routes.managdevices,
                      pageBuilder: (context, state) =>
                          buildPageWithDefaultTransition(
                            context: context,
                            state: state,
                            child: const ManageDevicesScreen(),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
