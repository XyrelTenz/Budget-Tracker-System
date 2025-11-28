import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import "package:smart_budget_ph/features/onboarding/presentation/screens/onboarding_screen.dart";
import "package:smart_budget_ph/features/onboarding/presentation/screens/splash_screen.dart";
//Authentiaction
import "package:smart_budget_ph/features/auth/presentation/screens/login_screen.dart";
import "package:smart_budget_ph/features/auth/presentation/screens/signup_screen.dart";
import "package:smart_budget_ph/features/auth/presentation/screens/forgot_password_screen.dart";
import "package:smart_budget_ph/features/auth/presentation/screens/pin_code_screen.dart";
import "package:smart_budget_ph/features/auth/presentation/screens/set_pin_screen.dart";

//Home Screens
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
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),

    GoRoute(
      path: Routes.onboarding,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          CustomTransitionPage<dynamic>(
            key: state.pageKey,
            child: const OnboardingScreen(),
            transitionsBuilder:
                (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child,
                ) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
    ),

    GoRoute(
      path: Routes.login,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          buildPageWithDefaultTransition<dynamic>(
            context: context,
            state: state,
            child: const LoginScreen(),
          ),
    ),

    GoRoute(
      path: Routes.register,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          buildPageWithDefaultTransition<dynamic>(
            context: context,
            state: state,
            child: const SignupScreen(),
          ),
    ),

    GoRoute(
      path: Routes.forgotpassword,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          buildPageWithDefaultTransition<dynamic>(
            context: context,
            state: state,
            child: const ForgotPasswordScreen(),
          ),
    ),

    GoRoute(
      path: Routes.pincode,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          buildPageWithDefaultTransition<dynamic>(
            context: context,
            state: state,
            child: const PinCodeScreen(),
          ),
    ),

    GoRoute(
      path: Routes.setpin,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          buildPageWithDefaultTransition<dynamic>(
            context: context,
            state: state,
            child: const SetPinScreen(),
          ),
    ),

    StatefulShellRoute.indexedStack(
      builder:
          (
            BuildContext context,
            GoRouterState state,
            StatefulNavigationShell navigationShell,
          ) {
            return NavigationWidget(navigationShell: navigationShell);
          },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: Routes.home,
              builder: (BuildContext context, GoRouterState state) =>
                  const HomeScreen(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: Routes.transaction,
              builder: (BuildContext context, GoRouterState state) =>
                  const TransactionScreen(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: Routes.report,
              builder: (BuildContext context, GoRouterState state) =>
                  const ReportScreen(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: Routes.reminder,
              builder: (BuildContext context, GoRouterState state) =>
                  const RemindersScreen(),
              routes: <RouteBase>[
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
          routes: <RouteBase>[
            GoRoute(
              path: Routes.account,
              builder: (BuildContext context, GoRouterState state) =>
                  const AccountScreen(),
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.editprofile,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      buildPageWithDefaultTransition<dynamic>(
                        context: context,
                        state: state,
                        child: const EditProfileScreen(),
                      ),
                ),
                // Export Data
                GoRoute(
                  path: Routes.exportdata,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      buildPageWithDefaultTransition<dynamic>(
                        context: context,
                        state: state,
                        child: const ExportDataScreen(),
                      ),
                ),
                // Notifications
                GoRoute(
                  path: Routes.notificationsettings,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      buildPageWithDefaultTransition<dynamic>(
                        context: context,
                        state: state,
                        child: const NotificationsSettingsScreen(),
                      ),
                ),
                // Categories
                GoRoute(
                  path: Routes.categories,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      buildPageWithDefaultTransition<dynamic>(
                        context: context,
                        state: state,
                        child: const CategoriesScreen(),
                      ),
                ),
                GoRoute(
                  path: Routes.securityprivacy,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      buildPageWithDefaultTransition<dynamic>(
                        context: context,
                        state: state,
                        child: const SecurityPrivacyScreen(),
                      ),
                  routes: <RouteBase>[
                    GoRoute(
                      path: Routes.changepassword,
                      pageBuilder:
                          (BuildContext context, GoRouterState state) =>
                              buildPageWithDefaultTransition<dynamic>(
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
