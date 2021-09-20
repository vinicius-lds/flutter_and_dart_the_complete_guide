import 'package:_06/models/transaction.dart';
import 'package:_06/widgets/transaction_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final Function? onDelete;
  final List<Transaction> transactions;

  const TransactionList({Key? key, this.onDelete, required this.transactions})
      : super(key: key);

  Widget _buildEmptyState(BuildContext context) {
    return LayoutBuilder(
      builder: (bContext, constraints) {
        return Column(
          children: [
            Text(
              'No transaction added yet',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView(
      children: transactions
          .map((tx) => TransactionListItem(
                key: ValueKey(tx.id),
                tx: tx,
                onDelete: onDelete,
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build: transaction_list');
    return transactions.isEmpty
        ? _buildEmptyState(context)
        : _buildListView(context);
  }
}
