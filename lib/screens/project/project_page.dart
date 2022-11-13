import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_manager/di.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/screens/project/project_bloc.dart';
import 'package:portfolio_manager/widgets/default_padding.dart';
import 'package:portfolio_manager/widgets/progress_dialog.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef OnSuccessfullySaved = Function(Project project);

class ProjectPage extends StatefulWidget implements AutoRouteWrapper{
  final Project? project;
  final OnSuccessfullySaved onSuccessfullySaved;

  const ProjectPage({this.project, Key? key, required this.onSuccessfullySaved}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProjectBloc>(),
      child: this,
    );
  }
}

class _ProjectPageState extends State<ProjectPage> {
  late final ProjectBloc _projectBloc;
  late final FormGroup _formGroup;

  @override
  void initState() {
    super.initState();
    _projectBloc = BlocProvider.of(context);

    _formGroup = FormGroup({
      'name': FormControl<String>(validators: [Validators.required]),
      'coin': FormControl<String>(validators: [Validators.required]),
    });
  }

  @override
  void dispose() {
    _projectBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project == null ? "Create project" : "Edit project"),
      ),
      body: DefaultPadding(
        child: BlocConsumer<ProjectBloc, ProjectState>(
          listener: (context, state) {
            if (state is ProjectSaveSuccess) {
              widget.onSuccessfullySaved(state.project);
              Navigator.pop(context); // dismiss progress indicator
              AutoRouter.of(context).pop();
            }

            if (state is ProjectSaveFailure) {
              Navigator.pop(context); // dismiss progress indicator
            }

            if (state is ProjectSaveInProgress) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const ProgressDialog(text: "Saving data...");
                  }
              );
            }
          },
          builder: (context, state) {
            if (state is ProjectSaveFailure) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(state.error),
                ],
              );
            }

            return ReactiveForm(
              formGroup: _formGroup,
              child: Column(
                children: [
                  ReactiveTextField(
                    formControlName: 'name',
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: "Project name"
                    ),
                  ),
                  const SizedBox(height: 15.0,),
                  ReactiveTextField(
                    formControlName: 'coin',
                    decoration: const InputDecoration(
                      labelText: "Coin name"
                    ),
                  )
                ],
              )
            );
          },
        ),
      ),
      floatingActionButton: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state is ProjectSaveFailure) {
            return FloatingActionButton.extended(
              label: const Text("Ok, I understand"),
              onPressed: () {
                _projectBloc.add(ProjectBackToInitialClicked());
              },
            );
          }
          return FloatingActionButton.extended(
            label: const Text("Save"),
            onPressed: () {
              if (!_formGroup.valid) {
                return;
              }
              _projectBloc.add(
                ProjectSaveClicked(
                  name: _formGroup.control('name').value,
                  coin: _formGroup.control('coin').value,
                  project: widget.project
                )
              );
            },
          );
        },
      )
    );
  }
}