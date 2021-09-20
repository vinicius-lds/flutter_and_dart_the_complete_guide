import 'dart:io';

import 'package:_06/models/transaction.dart';
import 'package:_06/widgets/chart.dart';
import 'package:_06/widgets/new_transaction.dart';
import 'package:_06/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: Colors.purple,
              secondary: Colors.amber,
            ),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              button: const TextStyle(
                color: Colors.white,
              ),
              headline6: const TextStyle(
                fontFamily: 'OpenSands',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSands',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  PreferredSizeWidget? _appBar;
  bool _showChart = false;

  List<Transaction> get recentTransactions {
    final aWeekAgo = DateTime.now().subtract(const Duration(days: 7));
    return _userTransactions.where((tx) => tx.date.isAfter(aWeekAgo)).toList();
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bContext) {
        return NewTransaction(
          onAdd: (transaction) =>
              setState(() => _userTransactions.add(transaction)),
        );
      },
    );
  }

  Widget _buildChart(BuildContext context, double percentageOnScreen,
      MediaQueryData mediaQuery) {
    return SizedBox(
      width: double.infinity,
      height: (mediaQuery.size.height -
              _appBar!.preferredSize.height -
              mediaQuery.padding.top) *
          percentageOnScreen,
      child: Card(
        elevation: 5,
        child: Chart(
          recentTransactions: recentTransactions,
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, MediaQueryData mediaQuery) {
    return SizedBox(
      height: (mediaQuery.size.height -
              _appBar!.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        transactions: _userTransactions,
        onDelete: (transaction) =>
            setState(() => _userTransactions.remove(transaction)),
      ),
    );
  }

  Widget _buildLandscape(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (isLandscape)
          SizedBox(
            height: (mediaQuery.size.height -
                    _appBar!.preferredSize.height -
                    mediaQuery.padding.top) *
                0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Chart',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch.adaptive(
                  value: _showChart,
                  onChanged: (value) => setState(() => _showChart = value),
                ),
              ],
            ),
          ),
        if (_showChart && isLandscape) _buildChart(context, 0.7, mediaQuery),
        if (!_showChart && isLandscape) _buildList(context, mediaQuery),
      ],
    );
  }

  Widget _buildPortrait(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (isLandscape)
          SizedBox(
            height: (mediaQuery.size.height -
                    _appBar!.preferredSize.height -
                    mediaQuery.padding.top) *
                0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Chart',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch.adaptive(
                  value: _showChart,
                  onChanged: (value) => setState(() => _showChart = value),
                ),
              ],
            ),
          ),
        if (!isLandscape) _buildChart(context, 0.3, mediaQuery),
        if (!isLandscape) _buildList(context, mediaQuery),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoNavigationBar(
        middle: const Text('Personal Expenses'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: const Icon(CupertinoIcons.add),
              onTap: () => _startAddNewTransaction(context),
            ),
          ],
        ),
      );
    } else {
      return AppBar(
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build: main');
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    _appBar = _buildAppBar(context) as PreferredSizeWidget;
    final body = SafeArea(
      child: SingleChildScrollView(
        child: isLandscape ? _buildLandscape(context) : _buildPortrait(context),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(child: body)
        : Scaffold(
            appBar: _appBar,
            body: body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
