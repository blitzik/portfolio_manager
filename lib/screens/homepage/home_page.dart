import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_manager/di.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/router/router.gr.dart';
import 'package:portfolio_manager/screens/homepage/home_page_bloc.dart';
import 'package:portfolio_manager/screens/homepage/project_item.dart';
import 'package:portfolio_manager/widgets/default_padding.dart';

class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<HomePageBloc>(
      create: (context) => getIt<HomePageBloc>()..add(HomePageLoaded()),
      child: this,
    );
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Portfolio manager"),
      ),
      body: DefaultPadding(
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is HomePageLoadInProgress) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const[
                    Text("Loading data..."),
                    SizedBox(height: 15.0,),
                    CircularProgressIndicator()
                  ],
                ),
              );
            }

            if (state is HomePageLoadFailure) {
              return Center(
                child: Column(
                  children: [
                    Text(state.error),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {

                      },
                      child: const Text("Try again")
                    )
                  ],
                ),
              );
            }

            List<Project> projects = (state as HomePageLoadSuccess).projects;
            if (projects.isEmpty) {
              return const Center(
                child: Text("Your portfolio is empty")
              );
            }

            return Column(
              children: [
                Text("Total cost basis"),
                Text("P/L"),
                Text("maybe a pie chart or something here"),
                Expanded(
                  child: ListView.builder(
                  itemCount: projects.length,
                    itemBuilder: (context, index) {
                      return ProjectItem(projects[index]);
                    }
                  ),
                ),
              ],
            );
          },
        )
      ),
      floatingActionButton: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state is! HomePageLoadSuccess) {
            return const SizedBox(width: 0, height: 0);
          }

          return FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                AutoRouter.of(context).push(
                  ProjectRoute(
                    project: null,
                    onSuccessfullySaved: (Project project) {
                      HomePageBloc bloc = BlocProvider.of<HomePageBloc>(context);
                      bloc.add(HomePageProjectCreated(project));
                    }
                  )
                );
              },
            );
        },
      ),
    );
  }
}