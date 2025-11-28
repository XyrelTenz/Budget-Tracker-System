import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  bool slideFromBottom = false,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          final Offset begin = slideFromBottom
              ? const Offset(0.0, 1.0)
              : const Offset(1.0, 0.0);
          const Offset end = Offset.zero;
          const Cubic curve = Curves.easeInOut;

          Animatable<Offset> tween = Tween<Offset>(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive<Offset>(tween),
            child: child,
          );
        },
  );
}
