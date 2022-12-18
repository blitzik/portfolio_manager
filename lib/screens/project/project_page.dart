import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:portfolio_manager/di.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/screens/project/project_bloc.dart';
import 'package:portfolio_manager/widgets/default_padding.dart';
import 'package:portfolio_manager/widgets/progress_dialog.dart';
import 'package:portfolio_manager/widgets/title_bar/title_bar.dart';

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
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  final GlobalKey<TitleBarState> _titleBarKey = GlobalKey();

  _ProjectPageFormState _projectPageFormState = _ProjectPageFormState(name: "", coin: "", scale: 2);

  @override
  void initState() {
    super.initState();
    _projectBloc = BlocProvider.of(context);
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
            key: _titleBarKey,
            title: widget.project == null ? "Create project" : "Edit project",
          ),
          Expanded(
            child: DefaultPadding(
              child: BlocConsumer<ProjectBloc, ProjectState>(
                listener: (context, state) {
                  if (state is ProjectSaveSuccess) {
                    _titleBarKey.currentState!.activateBackButton();
                    widget.onSuccessfullySaved(state.project);
                    AutoRouter.of(context).pop();
                  }

                  if (state is ProjectSaveFailure) {
                    _titleBarKey.currentState!.activateBackButton();
                  }

                  if (state is ProjectSaveInProgress) {
                    _titleBarKey.currentState!.deactivateBackButton();
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

                  return FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'project_name',
                          decoration: const InputDecoration(
                              labelText: "Project name"
                          ),
                          validator: FormBuilderValidators.required(errorText: 'Please enter project name'),
                          onSaved: (value) {
                            _projectPageFormState = _projectPageFormState.copyWith(name: value);
                          },
                        ),
                        const SizedBox(height: 10.0),
                        FormBuilderTextField(
                          name: 'coin_name',
                          decoration: const InputDecoration(
                            labelText: "Coin name"
                          ),
                          validator: FormBuilderValidators.required(errorText: 'Please enter coin name'),
                          onSaved: (value) {
                            _projectPageFormState = _projectPageFormState.copyWith(coin: value);
                          },
                        ),
                        const SizedBox(height: 10.0),
                        FormBuilderTextField(
                          name: 'scale',
                          decoration: const InputDecoration(
                            labelText: "Number of decimal places"
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Please enter the number of decimals')
                          ]),
                          onSaved: (val) {
                            _projectPageFormState = _projectPageFormState.copyWith(scale: int.parse(val!));
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
                                  scale: _projectPageFormState.scale,
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
  final int scale;

  _ProjectPageFormState({
    required this.name,
    required this.coin,
    required this.scale
  });

  _ProjectPageFormState copyWith({
    String? name,
    String? coin,
    int? scale
  }) {
    return _ProjectPageFormState(
      name: name ?? this.name,
      coin: coin ?? this.coin,
      scale: scale ?? this.scale
    );
  }

  @override
  String toString() {
    return "$name - $coin";
  }
}