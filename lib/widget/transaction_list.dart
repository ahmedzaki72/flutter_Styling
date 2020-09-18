import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:using_wiget_styling/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTransaction;

  TransactionList({this.transaction, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'no Transactions add yet',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 200.0,
                child: Image.asset('assets/images/waiting.png'),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                            '\$${transaction[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    '${transaction[index].title}',
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    '${DateFormat.yMMMd().format(transaction[index].date)}',
                  ),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? FlatButton(
                          onPressed: () =>
                              deleteTransaction(transaction[index].id),
                          child: Text('Delete'),
                         textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              deleteTransaction(transaction[index].id),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: transaction.length,
          );
  }
}
