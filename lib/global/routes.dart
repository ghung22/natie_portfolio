import 'package:flutter/material.dart';
import 'package:natie_portfolio/data/model/project.dart';
import 'package:natie_portfolio/widget/page/about_page.dart';
import 'package:natie_portfolio/widget/page/debug_page.dart';
import 'package:natie_portfolio/widget/page/home_page.dart';
import 'package:natie_portfolio/widget/page/project_page.dart';
import 'package:natie_portfolio/widget/page/projects_page.dart';
import 'package:routemaster/routemaster.dart';

import 'debug.dart';
import 'vars.dart';

class Routes {
  static const home = '/';
  static const about = '/about';
  static const debug = '/debug';
  static const project = '/project';

  static const list = [home, about, project];

  static Routemaster get routemaster => Routemaster.of(Vars.navigatorKey.currentContext!);

  static const alwaysUseNavigationDrawer = true;

  static final routeMap = RouteMap(
    routes: {
      home: (_) => MaterialPage(child: const HomePage()),
      about: (info) => MaterialPage(
        child: AboutPage(disableAnimation: bool.parse(info.queryParameters['disableAnimation'] ?? 'false')),
      ),
      project: (info) {
        final filterStr = info.queryParameters['filter'];
        final filter = filterStr?.split('-').map((fs) => ProjectTag.values.byName(fs)).toList();
        return MaterialPage(child: ProjectsPage(tags: filter));
      },
      '$project/:id': (info) {
        final p = ProjectData.data.get(info.pathParameters['id'] ?? '');
        if (p == null) {
          debugPrint('Project ${info.pathParameters['id']} not found');
          return MaterialPage(child: const ProjectsPage());
        }
        final disableAnimation = bool.parse(info.queryParameters['disableAnimation'] ?? 'false');
        return MaterialPage(
          child: ProjectPage(project: p, disableAnimation: disableAnimation),
        );
      },
      debug: (info) {
        if (Debug.isProduction) {
          debugPrint('Debug page is not available in production');
          return MaterialPage(child: const HomePage());
        }
        return MaterialPage(child: const DebugPage());
      },
    },
    onUnknownRoute: (path) {
      // TODO: 404
      return MaterialPage(child: const HomePage());
    },
  );
}

class AnimatedPageRoute extends MaterialPageRoute {
  final Duration duration;

  AnimatedPageRoute({required super.builder, this.duration = Vars.animationSluggish});

  @override
  Duration get transitionDuration => duration;
}

class PortRouteObserver extends RoutemasterObserver {
  @override
  void didChangeRoute(RouteData routeData, Page page) {
    if (Vars.globalScaffoldKey.currentState!.isDrawerOpen) {
      Vars.globalScaffoldKey.currentState!.closeDrawer();
    }
  }
}
