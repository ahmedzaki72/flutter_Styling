import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:using_wiget_styling/widget/chart.dart';
import 'package:using_wiget_styling/widget/new_transaction.dart';
import './widget/transaction_list.dart';
import './models/transaction.dart';

void main() {
  /// using this code when i want to disable rotation to landscape when user want to rotation to landscape.
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'SourceCodePro',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(fontFamily: 'SourceCodePro', fontSize: 20.0),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(fontFamily: 'SourceCodePro', fontSize: 20.0),
              ),
        ),
      ),
      title: "Personal Expenses",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: '1',
    //   title: 'new shoes',
    //   amount: 96.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'weekly Groceries',
    //   amount: 16.99,
    //   date: DateTime.now(),
    // )
  ];

  bool _showCharts = false;

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  // void _addNewTransaction(String title, double amount) {
  //   final newTx = Transaction(
  //     id: DateTime.now().toString(),
  //     title: title,
  //     amount: amount,
  //     date: DateTime.now(),
  //   );
  //   setState(() {
  //     _userTransaction.add(newTx);
  //   });
  // }

  // String titleInput;
  // String amountInput;
  // TextEditingController titleController = TextEditingController();
  // TextEditingController amountController = TextEditingController();

  void _addNewTransactions(String title, double amount, DateTime dating) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: dating,
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(
            addingTransaction: _addNewTransactions,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('show Charts'),
                Switch(
                  value: _showCharts,
                  onChanged: (val) {
                    setState(() {
                      _showCharts = val;
                    });
                  },
                ),
              ],
            ),
            if(!isLandscape)
               Container(
                height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                    0.27,
                child: Chart(
                  recentTransactions: _recentTransaction,
                ),
              ),
            if(!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                    0.73,
                child: TransactionList(
                  transaction: _userTransaction,
                  deleteTransaction: _deleteTransaction,
                ),
              ),
            if(isLandscape)
            _showCharts
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.6,
                    child: Chart(
                      recentTransactions: _recentTransaction,
                    ),
                  )
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.9,
                    child: TransactionList(
                      transaction: _userTransaction,
                      deleteTransaction: _deleteTransaction,
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
