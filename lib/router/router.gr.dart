// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../domain/project.dart' as _i5;
import '../screens/homepage/home_page.dart' as _i1;
import '../screens/project/project_page.dart' as _i2;

class Router extends _i3.RootStackRouter {
  Router([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.WrappedRoute(child: const _i1.HomePage()),
        transitionsBuilder: _i3.TransitionsBuilders.slideLeft,
        durationInMilliseconds: 125,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProjectRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectRouteArgs>();
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.WrappedRoute(
            child: _i2.ProjectPage(
          project: args.project,
          key: args.key,
          onSuccessfullySaved: args.onSuccessfullySaved,
        )),
        transitionsBuilder: _i3.TransitionsBuilders.slideLeft,
        durationInMilliseconds: 125,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          ProjectRoute.name,
          path: '/project-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.ProjectPage]
class ProjectRoute extends _i3.PageRouteInfo<ProjectRouteArgs> {
  ProjectRoute({
    _i5.Project? project,
    _i4.Key? key,
    required dynamic Function(_i5.Project) onSuccessfullySaved,
  }) : super(
          ProjectRoute.name,
          path: '/project-page',
          args: ProjectRouteArgs(
            project: project,
            key: key,
            onSuccessfullySaved: onSuccessfullySaved,
          ),
        );

  static const String name = 'ProjectRoute';
}

class ProjectRouteArgs {
  const ProjectRouteArgs({
    this.project,
    this.key,
    required this.onSuccessfullySaved,
  });

  final _i5.Project? project;

  final _i4.Key? key;

  final dynamic Function(_i5.Project) onSuccessfullySaved;

  @override
  String toString() {
    return 'ProjectRouteArgs{project: $project, key: $key, onSuccessfullySaved: $onSuccessfullySaved}';
  }
}
