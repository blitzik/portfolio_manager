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

typedef OnTransactionSaved = Function(Transaction transaction);

class TransactionPage extends StatefulWidget implements AutoRouteWrapper {
  final Project project;
  final Transaction? transaction;
  final OnTransactionSaved? onTransactionSaved;

  const TransactionPage(
    this.project,
    {
      Key? key,
      this.transaction,
      this.onTransactionSaved
    }
  ) : super(key: key);

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
  late _TransactionFormState _formState;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<TransactionBloc>(context);
    _formState = _TransactionFormState(
        type: TransactionType.buy.index,
        date: DateTime.now(),
        amount: '',
        value: '',
        fee: '0.0',
        fiatFee: '0.0',
        note: null
    );
    if (widget.transaction != null) {
      Transaction tx = widget.transaction!;
      _formState = _TransactionFormState(
        id: tx.id,
        type: tx.type.index,
        date: tx.date,
        amount: tx.amount.toString(),
        value: tx.value.toString(),
        fee: tx.fee.toString(),
        fiatFee: tx.fiatFee.toString(),
        note: tx.note
      );
    }
  }


  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }


  FormBuilderDropdown _buildDropDown() {
    return FormBuilderDropdown(
        name: 'type',
        enabled: widget.transaction == null,
        initialValue: _formState.type,
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
        ],
      onSaved: (val) {
        _formState = _formState.copyWith(type: val);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionSavedSuccessfully) {
          widget.onTransactionSaved?.call(state.transaction);
        }
        if (state is TransactionSaveFailure) {
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: const EdgeInsets.all(20.0),
                children: [
                  Text(state.error),
                  TextButton(
                    child: const Text('Ok, I understand'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
          );
        }
      },
      child: Scaffold(
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
                            initialValue: _formState.date,
                            decoration: const InputDecoration(
                              labelText: 'Date and Time'
                            ),
                            onSaved: (val) {
                              _formState = _formState.copyWith(date: val);
                            },
                          ),
                          const SizedBox(height: 5.0),
                          FormBuilderTextField(
                            name: 'amount',
                            initialValue: _formState.amount,
                            decoration: InputDecoration(
                              labelText: 'Amount of ${widget.project.coin} coins'
                            ),
                            inputFormatters: <TextInputFormatter>[
                              DecimalsFormatter(allowNegative: false)
                            ],
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'Please enter the amount'),
                              FormBuilderValidators.numeric(errorText: 'Please enter a number'),
                              FormBuilderValidators.min(0, inclusive: false, errorText: 'Value must be greater than 0')
                            ]),
                            onSaved: (val) {
                              _formState = _formState.copyWith(amount: val);
                            },
                          ),
                          const SizedBox(height: 5.0),
                          FormBuilderTextField(
                            name: 'value',
                            initialValue: _formState.value,
                            decoration: const InputDecoration(
                              labelText: 'Total USD value'
                            ),
                            inputFormatters: <TextInputFormatter>[
                              DecimalsFormatter(allowNegative: false)
                            ],
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'Please enter the value'),
                              FormBuilderValidators.numeric(errorText: 'Please enter a number')
                            ]),
                           onSaved: (val) {
                              _formState = _formState.copyWith(value: val);
                           },
                           //onChanged: _onChanged
                          ),
                          const SizedBox(height: 5.0),
                          FormBuilderTextField(
                            name: 'fee',
                            initialValue: _formState.fee,
                            decoration: InputDecoration(
                              labelText: 'Fee [${widget.project.coin}]'
                            ),
                            //onChanged: _onChanged,
                            inputFormatters: <TextInputFormatter>[
                              DecimalsFormatter(allowNegative: false)
                            ],
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'Please enter the fee'),
                              FormBuilderValidators.numeric(errorText: 'Please enter a number')
                            ]),
                            onSaved: (val) {
                              _formState = _formState.copyWith(fee: val);
                            },
                          ),
                          FormBuilderTextField(
                            name: 'fiat_fee',
                            initialValue: _formState.fiatFee,
                            decoration: const InputDecoration(
                                labelText: 'Fiat Fee [USD]'
                            ),
                            inputFormatters: <TextInputFormatter>[
                              DecimalsFormatter(allowNegative: false)
                            ],
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'Please enter the fiat fee'),
                              FormBuilderValidators.numeric(errorText: 'Please enter a number')
                            ]),
                            onSaved: (val) {
                              _formState = _formState.copyWith(fiatFee: val);
                            },
                          ),
                          const SizedBox(height: 5.0),
                          FormBuilderTextField(
                            name: 'note',
                            initialValue: _formState.note,
                            decoration: const InputDecoration(
                              labelText: 'Note'
                            ),
                            onSaved: (val) {
                              _formState = _formState.copyWith(note: val);
                            },
                          ),
                          const SizedBox(height: 5.0),
                          ElevatedButton(
                            child: const Text('Save transaction', style: TextStyle(fontSize: 18.0),),
                            onPressed: () {
                              if (!_formKey.currentState!.saveAndValidate()) return;
                              _bloc.add(
                                TransactionSaved(
                                  id: _formState.id,
                                  project: widget.project,
                                  date: _formState.date,
                                  type: TransactionType.values[_formState.type],
                                  amount: Decimal.parse(_formState.amount),
                                  totalValue: Decimal.parse(_formState.value),
                                  fee: Decimal.parse(_formState.fee),
                                  fiatFee: Decimal.parse(_formState.fiatFee),
                                  note: _formState.note
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
      ),
    );
  }
}

class _TransactionFormState {
  final int? id;
  final int type;
  final DateTime date;
  final String amount;
  final String value;
  final String fee;
  final String fiatFee;
  final String? note;

  _TransactionFormState({
    this.id,
    required this.type,
    required this.date,
    required this.amount,
    required this.value,
    required this.fee,
    required this.fiatFee,
    this.note
  });

  _TransactionFormState copyWith({
    int? type,
    DateTime? date,
    String? amount,
    String? value,
    String? fee,
    String? fiatFee,
    String? note,
  }) {
    return _TransactionFormState(
      id: id,
      type: type ?? this.type,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      value: value ?? this.value,
      fee: fee ?? this.fee,
      fiatFee: fiatFee ?? this.fiatFee,
      note: note
    );
  }
}