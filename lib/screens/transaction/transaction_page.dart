import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_manager/di.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/screens/transaction/transaction_bloc.dart';

class TransactionPage extends StatefulWidget implements AutoRouteWrapper {
  final Project project;

  const TransactionPage(this.project, {Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TransactionBlocFactory>().create(project),
      child: this,
    );
  }
}

class _TransactionPageState extends State<TransactionPage> {
  late final TransactionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<TransactionBloc>(context);
  }


  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
      ),
      body: const Center(
        child: Text("Transaction page"),
      ),
    );
  }
}
