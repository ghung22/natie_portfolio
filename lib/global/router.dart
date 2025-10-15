import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:natie_portfolio/data/model/project.dart';
import 'package:natie_portfolio/widget/page/about_page.dart';
import 'package:natie_portfolio/widget/page/debug_page.dart';
import 'package:natie_portfolio/widget/page/home_page.dart';
import 'package:natie_portfolio/widget/page/project_page.dart';
import 'package:natie_portfolio/widget/page/projects_page.dart';

import 'debug.dart';

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
            debugPrint('Type ${state.extra.runtimeType} is not valid');
            return const ProjectsPage();
          }
          if (state.extra is Project) {
            return ProjectPage(project: state.extra as Project);
          } else {
            final args = state.extra as Map<String, dynamic>;
            return ProjectPage(project: args['project'], disableAnimation: args['disableAnimation']);
          }
        },
      ),
      GoRoute(
        path: projects,
        builder: (context, state) => ProjectsPage(tags: state.extra as List<ProjectTag>?),
      ),
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
