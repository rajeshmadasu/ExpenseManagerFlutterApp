import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(id: 'id1', title: 'Shoes', amount: 54.5, date: DateTime.now()),
    Transaction(id: 'id2', title: 'Shirts', amount: 77.5, date: DateTime.now()),
    Transaction(id: 'id3', title: 'Cake', amount: 44.5, date: DateTime.now()),
    Transaction(
        id: 'id1', title: 'Groceries', amount: 200.5, date: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(children: [
      NewTransaction(_addNewTransaction),
      TransactionList(_userTransactions),
    ]));
  }
}
