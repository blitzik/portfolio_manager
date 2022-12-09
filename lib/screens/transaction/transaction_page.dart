import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:portfolio_manager/di.dart';
import 'package:portfolio_manager/domain/transaction.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/screens/transaction/transaction_bloc.dart';
import 'package:portfolio_manager/utils/text_input_formatters/decimals_formatter.dart';
import 'package:portfolio_manager/widgets/title_bar/title_bar.dart';

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
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();


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


  FormBuilderDropdown _buildDropDown() {
    return FormBuilderDropdown(
        name: 'type',
        initialValue: TransactionType.buy.index,
        decoration: const InputDecoration(
            labelText: 'Transaction type'
        ),
        items: [
          DropdownMenuItem(
              value: TransactionType.deposit.index,
              child: const Text('Deposit')
          ),
          DropdownMenuItem(
              value: TransactionType.withdrawal.index,
              child: const Text('Withdrawal')
          ),
          DropdownMenuItem(
              value: TransactionType.buy.index,
              child: const Text('Purchase')
          ),
          DropdownMenuItem(
              value: TransactionType.sell.index,
              child: const Text('Sale')
          ),
          DropdownMenuItem(
              value: TransactionType.transfer.index,
              child: const Text('Transfer')
          ),
        ]
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TitleBar(
            title: '${widget.project.name} transaction',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildDropDown(),
                        const SizedBox(height: 5.0),
                        FormBuilderDateTimePicker(
                          name: 'date_time',
                          initialValue: DateTime.now(),
                          decoration: const InputDecoration(
                            labelText: 'Date and Time'
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        FormBuilderTextField(
                          name: 'amount',
                          decoration: const InputDecoration(
                            labelText: 'Amount of coins'
                          ),
                          inputFormatters: <TextInputFormatter>[
                            DecimalsFormatter(allowNegative: false)
                          ],
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Please enter the amount'),
                            FormBuilderValidators.numeric(errorText: 'Please enter a number')
                          ])
                        ),
                        const SizedBox(height: 5.0),
                        FormBuilderTextField(
                          name: 'value',
                          decoration: const InputDecoration(
                            labelText: 'Total value'
                          ),
                          inputFormatters: <TextInputFormatter>[
                            DecimalsFormatter(allowNegative: false)
                          ],
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Please enter the value'),
                            FormBuilderValidators.numeric(errorText: 'Please enter a number')
                          ])
                        ),
                        const SizedBox(height: 5.0),
                        FormBuilderTextField(
                          name: 'fee',
                          decoration: InputDecoration(
                            labelText: 'Fee [${widget.project.coin}]'
                          ),
                          initialValue: '0.0',
                          inputFormatters: <TextInputFormatter>[
                            DecimalsFormatter(allowNegative: false)
                          ],
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Please enter the fee'),
                            FormBuilderValidators.numeric(errorText: 'Please enter a number')
                          ])
                        ),
                        FormBuilderTextField(
                          name: 'fiat_fee',
                          decoration: const InputDecoration(
                              labelText: 'Fiat Fee [USD]'
                          ),
                          initialValue: '0.0',
                          inputFormatters: <TextInputFormatter>[
                            DecimalsFormatter(allowNegative: false)
                          ],
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Please enter the fiat fee'),
                            FormBuilderValidators.numeric(errorText: 'Please enter a number')
                          ])
                        ),
                        const SizedBox(height: 5.0),
                        FormBuilderTextField(
                          name: 'note',
                          decoration: const InputDecoration(
                            labelText: 'Note'
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        ElevatedButton(
                          child: const Text('Save transaction', style: TextStyle(fontSize: 18.0),),
                          onPressed: () {
                            if (!_formKey.currentState!.saveAndValidate()) return;
                            Map<String, dynamic> result = _formKey.currentState!.value;
                            _bloc.add(
                              TransactionSaved(
                                project: widget.project,
                                date: result['date_time'],
                                type: TransactionType.values[result['type']],
                                amount: Decimal.parse(result['amount']),
                                totalValue: Decimal.parse(result['value']),
                                fee: Decimal.parse(result['fee']),
                                fiatFee: Decimal.parse(result['fiat_fee']),
                                note: result['note']
                              )
                            );
                          },
                        )
                      ],
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