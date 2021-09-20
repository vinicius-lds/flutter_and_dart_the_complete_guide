import 'package:_05/models/transaction.dart';
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
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        var tx = transactions[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(
                  child: Text('\$${tx.amount.toStringAsFixed(2)}'),
                ),
              ),
            ),
            title: Text(
              tx.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(tx.date),
            ),
            trailing: MediaQuery.of(context).size.width > 460
                ? TextButton.icon(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () => onDelete!(tx),
                    label: Text(
                      'Delete',
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  )
                : IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => onDelete!(tx),
                  ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? _buildEmptyState(context)
        : _buildListView(context);
  }
}
