import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_manager/di.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/domain/transaction.dart';
import 'package:portfolio_manager/router/router.gr.dart';
import 'package:portfolio_manager/screens/project_detail/project_detail_bloc.dart';
import 'package:portfolio_manager/screens/project_detail/transaction_item.dart';
import 'package:portfolio_manager/utils/custom_text_styles.dart';
import 'package:portfolio_manager/widgets/default_padding.dart';
import 'package:portfolio_manager/widgets/menu.dart';
import 'package:portfolio_manager/widgets/money_usd.dart';
import 'package:portfolio_manager/widgets/title_bar/title_bar.dart';

class ProjectDetailPage extends StatefulWidget implements AutoRouteWrapper {
  final Project project;

  const ProjectDetailPage(this.project, {Key? key}) : super(key: key);

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();

  @override
  Widget wrappedRoute(BuildContext context  ) {
    return BlocProvider(
      create: (context) => getIt<ProjectDetailBlocFactory>().create(project)..add(ProjectDetailTransactionsLoaded(project)),
      child: this,
    );
  }
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late final ProjectDetailBloc _projectDetailBloc;

  @override
  void initState() {
    super.initState();
    _projectDetailBloc = BlocProvider.of<ProjectDetailBloc>(context);
  }


  @override
  void dispose() {
    _projectDetailBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TitleBar(
            title: widget.project.name,
            isBackButtonVisible: true
          ),
          Menu(
            children: [
              TextButton(
                child: const Text("Add transaction"),
                onPressed: () {
                  AutoRouter.of(context).push(
                    TransactionRoute(
                      project: widget.project,
                      onTransactionSaved: (Transaction tx) {
                        _projectDetailBloc.add(ProjectDetailTransactionsLoaded(tx.project));
                      }
                    )
                  );
                },
              )
            ]
          ),
          Expanded(
            child: DefaultPadding(
              child: Column(
                children: [
                  BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
                    builder: (context, state) {
                      if (state is ProjectDetailLoadInProgress) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text('Current holdings', style: CustomTextStyles.rowHeader),
                                Text('${state.project.amount} ${widget.project.coin}'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text('Current holdings cost', style: CustomTextStyles.rowHeader),
                                MoneyUsd(state.project.currentCosts)
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text('Gross realized P/L', style: CustomTextStyles.rowHeader),
                                MoneyUsd(state.project.realizedPnl, isColored: true,)
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 50.0,),
                  const Text('Transactions'),
                  const SizedBox(height: 25.0,),
                  Expanded(
                    child: BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
                      builder: (context, state) {
                        if (state is ProjectDetailLoadInProgress) {
                          return Column(
                            children: const [
                              Text("Loading data..."),
                              CircularProgressIndicator()
                            ],
                          );
                        }

                        final txs = (state as ProjectDetailTransactionsLoadedSuccessfully).transactions;
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(thickness: 1.0, color: Colors.black45,);
                          },
                          itemCount: txs.length,
                          itemBuilder: (context, index) {
                            final tx = txs[index];
                            return Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: TransactionItem(transaction: tx),
                                    onTap: () async{
                                      AutoRouter.of(context).push(
                                        TransactionRoute(
                                          project: widget.project,
                                          transaction: tx
                                        )
                                      );
                                    },
                                  ),
                                ),
                                TextButton(
                                  child: const Icon(Icons.delete),
                                  onPressed: () async{
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SimpleDialog(
                                          contentPadding: const EdgeInsets.all(20.0),
                                          children: [
                                            Text('Do you really wish to delete this record?'),
                                            const SizedBox(height: 35.0,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 150.0,
                                                  child: TextButton(
                                                      child: const Text('No'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      }
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 75.0,
                                                  child: TextButton(
                                                    child: const Text('Yes'),
                                                      onPressed: () {
                                                        _projectDetailBloc.add(ProjectDetailTransactionDeleted(tx));
                                                        Navigator.of(context).pop();
                                                      }
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        );
                                      }
                                    );
                                  },
                                )
                              ],
                            );
                          }
                        );
                      },
                    )
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}