import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_manager/di.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/router/router.gr.dart';
import 'package:portfolio_manager/screens/project/project_bloc.dart';
import 'package:portfolio_manager/widgets/default_padding.dart';
import 'package:portfolio_manager/widgets/progress_dialog.dart';
import 'package:portfolio_manager/widgets/title_bar/title_bar.dart';
import 'package:portfolio_manager/widgets/title_bar/title_bar_cubit.dart';

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
  late final GlobalKey<FormState> _formKey;
  late final TitleBarCubit _titleBarCubit;

  _ProjectPageFormState _projectPageFormState = _ProjectPageFormState(name: "", coin: "");

  @override
  void initState() {
    super.initState();
    _titleBarCubit = TitleBarCubit();
    _projectBloc = BlocProvider.of(context);
    _formKey = GlobalKey();
  }

  @override
  void dispose() {
    _projectBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TitleBar(
            title: widget.project == null ? "Create project" : "Edit project",
            cubit: _titleBarCubit
          ),
          Expanded(
            child: DefaultPadding(
              child: BlocConsumer<ProjectBloc, ProjectState>(
                listener: (context, state) {
                  if (state is ProjectSaveSuccess) {
                    _titleBarCubit.activate();
                    widget.onSuccessfullySaved(state.project);
                    //Navigator.pop(context); // dismiss progress indicator
                    AutoRouter.of(context).pop();
                  }

                  if (state is ProjectSaveFailure) {
                    _titleBarCubit.activate();
                    //Navigator.pop(context); // dismiss progress indicator
                  }

                  if (state is ProjectSaveInProgress) {
                    _titleBarCubit.deactivate();
                    /*showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return const ProgressDialog(text: "Saving data...");
                        }
                    );*/
                    //return ProgressDialog(text: "Saving data...");
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

                  if (state is ProjectSaveInProgress) {
                    return const ProgressDialog(text: "Saving data...");
                  }

                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Project name"
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter project name";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _projectPageFormState = _projectPageFormState.copyWith(name: value);
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Coin name"
                          ),
                          validator: (string) {
                            if (string == null || string.isEmpty) {
                              return "Please enter coin name";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _projectPageFormState = _projectPageFormState.copyWith(coin: value);
                          },
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          child: Text(widget.project == null ? "Create project" : "Edit project"),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _projectBloc.add(
                                ProjectSaveClicked(
                                  name: _projectPageFormState.name,
                                  coin: _projectPageFormState.coin,
                                  project: widget.project
                                )
                              );
                            }
                          }
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _ProjectPageFormState {
  final String name;
  final String coin;

  _ProjectPageFormState({
    required this.name,
    required this.coin
  });

  _ProjectPageFormState copyWith({
    String? name,
    String? coin
  }) {
    return _ProjectPageFormState(
      name: name ?? this.name,
      coin: coin ?? this.coin
    );
  }

  @override
  String toString() {
    return "$name - $coin";
  }
}