import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: ListView(
          children: transactions.map((tx) {
            return Container(
                width: double.infinity,
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.purple,
                                width: 2,
                                style: BorderStyle.solid)),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '\$${tx.amount}',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tx.title,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start),
                          Text(DateFormat.yMMMEd().format(tx.date),
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                ));
          }).toList(),
        ));
  }
}