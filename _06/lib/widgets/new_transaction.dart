import 'dart:io';

import 'package:_06/models/transaction.dart';
import 'package:_06/widgets/adaptive_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function? onAdd;

  NewTransaction({Key? key, this.onAdd}) : super(key: key) {
    print('NewTransaction: constructor');
  }

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction>
    with WidgetsBindingObserver {
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  DateTime? _selectedDate;

  _NewTransactionState() {
    print('_NewTransactionState: constructor');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    print('_NewTransactionState: initState');
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('_NewTransactionState: didUpdateWidget');
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    print('_NewTransactionState: dispose');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(
        '_NewTransactionState: didChangeAppLifecycleState ' + state.toString());
  }

  void _add() {
    var title = _titleController.text;
    var amount = _amountController.text.isEmpty
        ? 0.0
        : double.parse(_amountController.text);

    if (title.isNotEmpty && amount > 0 && _selectedDate != null) {
      var transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: _selectedDate as DateTime,
      );
      widget.onAdd!(transaction);
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) => setState(() => _selectedDate = value));
  }

  String get _selectedDateToShow {
    return _selectedDate == null
        ? 'No date chosen'
        : 'Picked date: ${DateFormat.yMd().format(_selectedDate as DateTime)}';
  }

  @override
  Widget build(BuildContext context) {
    print('build: new_transaction');
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                onSubmitted: (_) => _add(),
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _add(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(child: Text(_selectedDateToShow)),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              AdaptiveElevatedButton(
                text: 'Add Transaction',
                onPressed: _add,
              )
            ],
          ),
        ),
      ),
    );
  }
}
