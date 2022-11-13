import 'package:flutter/material.dart';
import 'package:portfolio_manager/domain/project.dart';

class ProjectItem extends StatelessWidget {
  final Project project;

  const ProjectItem(this.project, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(project.name),
        subtitle: Text("4.7900215"),
      ),
    );
  }
}
