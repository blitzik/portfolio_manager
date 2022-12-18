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
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../domain/project.dart' as _i7;
import '../domain/transaction.dart' as _i8;
import '../screens/homepage/home_page.dart' as _i1;
import '../screens/project/project_page.dart' as _i2;
import '../screens/project_detail/project_detail_page.dart' as _i3;
import '../screens/transaction/transaction_page.dart' as _i4;

class Router extends _i5.RootStackRouter {
  Router([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.WrappedRoute(child: const _i1.HomePage()),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 100,
        reverseDurationInMilliseconds: 100,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProjectRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectRouteArgs>();
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.WrappedRoute(
            child: _i2.ProjectPage(
          project: args.project,
          key: args.key,
          onSuccessfullySaved: args.onSuccessfullySaved,
        )),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 100,
        reverseDurationInMilliseconds: 100,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProjectDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectDetailRouteArgs>();
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.WrappedRoute(
            child: _i3.ProjectDetailPage(
          args.project,
          key: args.key,
        )),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 100,
        reverseDurationInMilliseconds: 100,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TransactionRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionRouteArgs>();
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.WrappedRoute(
            child: _i4.TransactionPage(
          args.project,
          key: args.key,
          transaction: args.transaction,
          onTransactionSaved: args.onTransactionSaved,
        )),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 100,
        reverseDurationInMilliseconds: 100,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i5.RouteConfig(
          ProjectRoute.name,
          path: '/project-page',
        ),
        _i5.RouteConfig(
          ProjectDetailRoute.name,
          path: '/project-detail-page',
        ),
        _i5.RouteConfig(
          TransactionRoute.name,
          path: '/transaction-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.ProjectPage]
class ProjectRoute extends _i5.PageRouteInfo<ProjectRouteArgs> {
  ProjectRoute({
    _i7.Project? project,
    _i6.Key? key,
    required dynamic Function(_i7.Project) onSuccessfullySaved,
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

  final _i7.Project? project;

  final _i6.Key? key;

  final dynamic Function(_i7.Project) onSuccessfullySaved;

  @override
  String toString() {
    return 'ProjectRouteArgs{project: $project, key: $key, onSuccessfullySaved: $onSuccessfullySaved}';
  }
}

/// generated route for
/// [_i3.ProjectDetailPage]
class ProjectDetailRoute extends _i5.PageRouteInfo<ProjectDetailRouteArgs> {
  ProjectDetailRoute({
    required _i7.Project project,
    _i6.Key? key,
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

  final _i7.Project project;

  final _i6.Key? key;

  @override
  String toString() {
    return 'ProjectDetailRouteArgs{project: $project, key: $key}';
  }
}

/// generated route for
/// [_i4.TransactionPage]
class TransactionRoute extends _i5.PageRouteInfo<TransactionRouteArgs> {
  TransactionRoute({
    required _i7.Project project,
    _i6.Key? key,
    _i8.Transaction? transaction,
    dynamic Function(_i8.Transaction)? onTransactionSaved,
  }) : super(
          TransactionRoute.name,
          path: '/transaction-page',
          args: TransactionRouteArgs(
            project: project,
            key: key,
            transaction: transaction,
            onTransactionSaved: onTransactionSaved,
          ),
        );

  static const String name = 'TransactionRoute';
}

class TransactionRouteArgs {
  const TransactionRouteArgs({
    required this.project,
    this.key,
    this.transaction,
    this.onTransactionSaved,
  });

  final _i7.Project project;

  final _i6.Key? key;

  final _i8.Transaction? transaction;

  final dynamic Function(_i8.Transaction)? onTransactionSaved;

  @override
  String toString() {
    return 'TransactionRouteArgs{project: $project, key: $key, transaction: $transaction, onTransactionSaved: $onTransactionSaved}';
  }
}
