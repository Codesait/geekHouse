import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/commons/src/screens.dart';
import 'package:projects/main.dart';

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

final _authShellKey = GlobalKey<NavigatorState>();
final _profileShellKey = GlobalKey<NavigatorState>();

class AppRouterConfig {
  static final GoRouter router = GoRouter(
    navigatorKey: appNavigatorKey,
    initialLocation: '/',
    observers: [BotToastNavigatorObserver()],
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
        path: '/',
        name: SplashScreen.splashPath,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const SplashScreen(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: appNavigatorKey,
        path: '/home',
        name: MainScreen.homePath,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const MainScreen(),
          );
        },
      ),
      ShellRoute(
        navigatorKey: _profileShellKey,
        builder: (context, state, child) {
          return  child;


        },
        routes: [
          GoRoute(
            path: '/profile',
            name: UserProfile.profilePath,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const UserProfile(),
              );
            },
            routes: [
              GoRoute(
                path: 'edit',
                name: EditProfileScreen.editProfilePath,
                pageBuilder: (context, state) {
                  return buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const EditProfileScreen(),
                  );
                },
              ),
            ],
          ),
        ],
      ),

      ShellRoute(
        navigatorKey: _authShellKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/welcome',
            name: WelcomeScreen.welcomePath,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const WelcomeScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'login',
                name: LoginScreen.loginPath,
                pageBuilder: (context, state) {
                  return buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const LoginScreen(),
                  );
                },
              ),
              GoRoute(
                path: 'registration',
                name: RegistrationScreen.regPath,
                pageBuilder: (context, state) {
                  return buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const RegistrationScreen(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
    debugLogDiagnostics: true,
  );
}
