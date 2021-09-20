import 'package:_05/models/grouped_transaction.dart';
import 'package:_05/models/transaction.dart';
import 'package:_05/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  List<GroupedTransaction> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      return GroupedTransaction(
        day: DateFormat.E().format(weekDay),
        amount: recentTransactions
            .where((tx) => tx.date.day == weekDay.day)
            .where((tx) => tx.date.month == weekDay.month)
            .where((tx) => tx.date.year == weekDay.year)
            .map((tx) => tx.amount)
            .fold(0, (acc, curr) => acc + curr),
      );
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactions.fold(0, (acc, curr) => acc + curr.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map(
                (tx) => Flexible(
                  // flex: 1, colspan
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: tx.day,
                    spendingAmount: tx.amount,
                    spendingPercentageOfTotal:
                        totalSpending == 0 ? 0 : tx.amount / totalSpending,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
