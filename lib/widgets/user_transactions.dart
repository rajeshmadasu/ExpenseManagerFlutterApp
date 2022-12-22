import 'package:flutter/material.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(children: const [
      //   NewTransaction(_addNewTransaction),
      //  TransactionList(_userTransactions),
    ]));
  }
}
