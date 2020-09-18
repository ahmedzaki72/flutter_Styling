import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widget/new_transaction.dart';
import '../widget/transaction_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: '1',
      title: 'new shoes',
      amount: 96.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'weekly Groceries',
      amount: 16.99,
      date: DateTime.now(),
    )
  ];
   void _addNewTransaction(String title , double amount){
     final newTx = Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: DateTime.now(),);
     setState(() {
       _userTransaction.add(newTx);
     });
   }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(addingTransaction: _addNewTransaction,),
        TransactionList(transaction: _userTransaction,),
      ],
    );
  }
}
