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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../domain/project.dart' as _i6;
import '../screens/homepage/home_page.dart' as _i1;
import '../screens/project/project_page.dart' as _i2;
import '../screens/project_detail/project_detail_page.dart' as _i3;

class Router extends _i4.RootStackRouter {
  Router([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i4.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.WrappedRoute(child: const _i1.HomePage()),
        transitionsBuilder: _i4.TransitionsBuilders.slideLeft,
        durationInMilliseconds: 125,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProjectRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectRouteArgs>();
      return _i4.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.WrappedRoute(
            child: _i2.ProjectPage(
          project: args.project,
          key: args.key,
          onSuccessfullySaved: args.onSuccessfullySaved,
        )),
        transitionsBuilder: _i4.TransitionsBuilders.slideLeft,
        durationInMilliseconds: 125,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProjectDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectDetailRouteArgs>();
      return _i4.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.WrappedRoute(
            child: _i3.ProjectDetailPage(
          args.project,
          key: args.key,
        )),
        transitionsBuilder: _i4.TransitionsBuilders.slideLeft,
        durationInMilliseconds: 125,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i4.RouteConfig(
          ProjectRoute.name,
          path: '/project-page',
        ),
        _i4.RouteConfig(
          ProjectDetailRoute.name,
          path: '/project-detail-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.ProjectPage]
class ProjectRoute extends _i4.PageRouteInfo<ProjectRouteArgs> {
  ProjectRoute({
    _i6.Project? project,
    _i5.Key? key,
    required dynamic Function(_i6.Project) onSuccessfullySaved,
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

  final _i6.Project? project;

  final _i5.Key? key;

  final dynamic Function(_i6.Project) onSuccessfullySaved;

  @override
  String toString() {
    return 'ProjectRouteArgs{project: $project, key: $key, onSuccessfullySaved: $onSuccessfullySaved}';
  }
}

/// generated route for
/// [_i3.ProjectDetailPage]
class ProjectDetailRoute extends _i4.PageRouteInfo<ProjectDetailRouteArgs> {
  ProjectDetailRoute({
    required _i6.Project project,
    _i5.Key? key,
  }) : super(
          ProjectDetailRoute.name,
          path: '/project-detail-page',
          args: ProjectDetailRouteArgs(
            project: project,
            key: key,
          ),
        );

  static const String name = 'ProjectDetailRoute';
}

class ProjectDetailRouteArgs {
  const ProjectDetailRouteArgs({
    required this.project,
    this.key,
  });

  final _i6.Project project;

  final _i5.Key? key;

  @override
  String toString() {
    return 'ProjectDetailRouteArgs{project: $project, key: $key}';
  }
}
