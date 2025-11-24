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
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // (1.0, 0.0) = Right to Left
      // (0.0, 1.0) = Bottom to Top
      final begin = slideFromBottom
          ? const Offset(0.0, 1.0)
          : const Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
