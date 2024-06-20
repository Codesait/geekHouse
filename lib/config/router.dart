import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/main.dart';
import 'package:projects/src/screens.dart';
import 'package:projects/src/utils.dart';

CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

//final _shellKey = GlobalKey<NavigatorState>();

class AppRouterConfig {
  static final GoRouter router = GoRouter(
    navigatorKey: appNavigatorKey,
    initialLocation: '/login',
    errorBuilder: (context, state) => const SizedBox(
      child: Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      ),
    ),
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: appNavigatorKey,
        path: '/home',
        name: Constants.homePath,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const Home(),
          );
        },
      ),

      GoRoute(
        path: '/login',
        name: Constants.loginPath,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const SizedBox(),
          );
        },
      ),
      GoRoute(
        path: '/sign-up',
        name: Constants.signUpPath,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const SizedBox(),
          );
        },
      ),
      // GoRoute(
      //   path: 'org-onboard',
      //   name: Constants.orgOnboardPath,
      //   pageBuilder: (context, state) {
      //     return buildPageWithDefaultTransition(
      //       context: context,
      //       state: state,
      //       child: const OrgOnboardScreen(),
      //     );
      //   },
      // ),
      // ShellRoute(
      //   navigatorKey: _shellKey,
      //   pageBuilder: (context, state, child) {
      //     return NoTransitionPage(
      //       child: child,
      //     );
      //   },
      //   routes: [
      //     GoRoute(
      //       path: '/auth',
      //       name: Constants.authPath,
      //       pageBuilder: (context, state) {
      //         return const NoTransitionPage(
      //           child: SizedBox(),
      //         );
      //       },
      //       routes: [
              
      //       ],
      //     ),
      //   ],
      // ),
    ],
    debugLogDiagnostics: true,
  );
}
