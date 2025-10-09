import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:natie_portfolio/data/model/project.dart';
import 'package:natie_portfolio/widget/common/helper/snackbar.dart';
import 'package:natie_portfolio/widget/page/about_page.dart';
import 'package:natie_portfolio/widget/page/debug_page.dart';
import 'package:natie_portfolio/widget/page/home_page.dart';
import 'package:natie_portfolio/widget/page/project_page.dart';
import 'package:natie_portfolio/widget/page/projects_page.dart';

import '../l10n/app_localizations.dart';
import 'debug.dart';
import 'vars.dart';

class Routes {
  static const home = '/';
  static const about = '/about';
  static const debug = '/debug';
  static const project = '/project';
  static const projects = '/projects';

  static const list = [home, about, debug, project, projects];

  static final router = GoRouter(
    initialLocation: Debug.isProduction ? home : debug,
    routes: [
      GoRoute(path: home, builder: (context, state) => const HomePage()),
      GoRoute(
        path: about,
        builder: (context, state) => AboutPage(disableAnimation: state.extra as bool? ?? false),
      ),
      GoRoute(
        path: project,
        builder: (context, state) {
          if (state.extra is! Project && state.extra is! Map<String, dynamic>) {
            throw 'Type ${state.extra.runtimeType} is not valid';
          }
          if (state.extra is Project) {
            return ProjectPage(project: state.extra as Project);
          } else {
            final args = state.extra as Map<String, dynamic>;
            return ProjectPage(project: args['project'], disableAnimation: args['disableAnimation']);
          }
        },
      ),
      GoRoute(path: projects, builder: (context, state) => const ProjectsPage()),
      GoRoute(
        path: debug,
        builder: (context, state) {
          if (Debug.isProduction) {
            debugPrint('Debug page is not available in production');
            return const HomePage();
          }
          // return const HomePage();
          return const DebugPage();
        },
      ),
    ],
  );
}

class Router {
  static BuildContext? _context;

  static void init(BuildContext context) => _context = context;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.home:
          return AnimatedPageRoute(builder: (_) => Builder(builder: (context) => const HomePage()));
        case Routes.about:
          return AnimatedPageRoute(
            builder: (_) => Builder(
              builder: (context) {
                if (settings.arguments != null) {
                  return AboutPage(disableAnimation: settings.arguments as bool);
                }
                return const AboutPage();
              },
            ),
          );
        case Routes.project:
          if (settings.arguments is! Project && settings.arguments is! Map<String, dynamic>) {
            throw 'Type ${settings.arguments.runtimeType} is not valid';
          }
          return AnimatedPageRoute(
            builder: (_) => Builder(
              builder: (context) {
                if (settings.arguments is Project) {
                  return ProjectPage(project: settings.arguments as Project);
                } else {
                  final args = settings.arguments as Map<String, dynamic>;
                  return ProjectPage(project: args['project'], disableAnimation: args['disableAnimation']);
                }
              },
            ),
          );
        case Routes.projects:
          return AnimatedPageRoute(builder: (_) => Builder(builder: (context) => const ProjectsPage()));

        case Routes.debug:
          if (Debug.isProduction) {
            debugPrint('Debug page is not available in production');
            return generateRoute(RouteSettings(name: Routes.home, arguments: settings.arguments));
          }
          return AnimatedPageRoute(
            builder: (_) => Builder(
              builder: (context) {
                return const HomePage();
                // return const DebugPage();
              },
            ),
          );
        default:
          if (_context == null) {
            debugPrint('Context is null');
            return generateRoute(RouteSettings(name: Routes.home, arguments: settings.arguments));
          }
          Snackbars.showSnackbar(
            _context!,
            SnackbarType.negative,
            AppLocalizations.of(_context!)!.route_unknown(settings.name ?? ''),
          );
          return null;
      }
    } catch (e) {
      Debug.log('Error navigating to ${settings.name}: $e', useDebugPrint: true);
      return null;
    }
  }
}

class AnimatedPageRoute extends MaterialPageRoute {
  final Duration duration;

  AnimatedPageRoute({required super.builder, this.duration = Vars.animationSluggish});

  @override
  Duration get transitionDuration => duration;
}
