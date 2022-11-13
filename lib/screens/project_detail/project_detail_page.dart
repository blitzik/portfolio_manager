import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_manager/di.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/screens/project_detail/project_detail_bloc.dart';
import 'package:portfolio_manager/widgets/default_padding.dart';

class ProjectDetailPage extends StatefulWidget implements AutoRouteWrapper {
  final Project project;

  const ProjectDetailPage(this.project, {Key? key}) : super(key: key);

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();

  @override
  Widget wrappedRoute(BuildContext context  ) {
    return BlocProvider(
      create: (context) => getIt<ProjectDetailBlocFactory>().create(project),
      child: this,
    );
  }
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name),
      ),
      body: DefaultPadding(
        child: Center(
          child: Text("hello project detail :-)"),
        ),
      ),
    );
  }
}
