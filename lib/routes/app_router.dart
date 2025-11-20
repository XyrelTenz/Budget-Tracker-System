import 'package:smart_budget_ph/auth/screen/login_screen.dart';
import 'package:smart_budget_ph/auth/screen/signup_screen.dart';
import 'package:smart_budget_ph/layout/screen_layout.dart';
import 'package:smart_budget_ph/onboarding_screen/onboarding_screen.dart';
import "package:go_router/go_router.dart";
import 'package:flutter/material.dart';
import 'package:smart_budget_ph/splash_screen/splash.dart';

//TODO: Use ShellRoute
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const CustomSplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: "OnBoardingScreen",
          builder: (BuildContext context, GoRouterState state) {
            return const OnboardingScreen();
          },
        ),
        GoRoute(
          path: "/Login",
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: "/Register",
          builder: (BuildContext context, GoRouterState state) {
            return const SignupScreen();
          },
        ),
        GoRoute(
          path: '/HomeScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
      ],
    ),
  ],
);
