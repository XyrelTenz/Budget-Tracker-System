import 'package:budget_tracker/auth/screen/login_screen.dart';
import 'package:budget_tracker/layout/screen_layout.dart';
import 'package:budget_tracker/onboarding_screen/onboarding_screen.dart';
import "package:go_router/go_router.dart";
import 'package:flutter/material.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: "/Login",
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
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
