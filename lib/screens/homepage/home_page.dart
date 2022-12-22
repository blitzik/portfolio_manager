import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:portfolio_manager/di.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/router/router.gr.dart';
import 'package:portfolio_manager/screens/homepage/home_page_bloc.dart';
import 'package:portfolio_manager/screens/homepage/project_item.dart';
import 'package:portfolio_manager/widgets/menu.dart';
import 'package:portfolio_manager/widgets/money_usd.dart';
import 'package:portfolio_manager/widgets/title_bar/title_bar.dart';

class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomePageBloc>()..add(HomePageLoaded()),
      child: this,
    );
  }
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TitleBar(
            title: "Portfolio manager",
            isBackButtonVisible: false
          ),
          Menu(
            children: [
              TextButton(
                child: const Text("add project"),
                onPressed: () {
                  AutoRouter.of(context).push(ProjectRoute(onSuccessfullySaved: (project) {
                    BlocProvider.of<HomePageBloc>(context).add(HomePageLoaded());
                  }));
                }
              ),
              TextButton(
                child: const Text("Statistics"),
                onPressed: () {},
              )
            ]
          ),
          Expanded(
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
                            BlocProvider.of<HomePageBloc>(context).add(HomePageLoaded());
                          },
                          child: const Text("Try again")
                        )
                      ],
                    ),
                  );
                }

                List<Project> projects = (state as HomePageLoadSuccess).projects;
                if (projects.isEmpty) {
                  return Column(
                    children: const [
                      SizedBox(height: 75.0,),
                      Text("Your portfolio is empty"),
                    ],
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 25.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('Total costs: '),
                                  MoneyUsd(state.currentCosts)
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Total realized P/L: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                  MoneyUsd(state.totalRealizedPnl, isColored: true,)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 50.0,),
                      Expanded(
                        child: ListView.separated(
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            final Project project = projects[index];
                            return InkWell(
                              child: ProjectItem(project),
                              onTap: () {
                                AutoRouter.of(context).push(
                                  ProjectDetailRoute(
                                    project: project,
                                    onProjectChanged: (Project project) {
                                      BlocProvider.of<HomePageBloc>(context).add(HomePageLoaded());
                                    }
                                  )
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(height: 3, color: Colors.black45,);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}