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
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'No transaction added yet!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return getListChildView(context, index);
                },
                itemCount: transactions.length,
              ));
  }

  Card getListChildView(BuildContext context, int index) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(child: Text('\$${transactions[index].amount}')),
            ),
          ),
          title: Text(
            transactions[index].title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(DateFormat.yMMMEd().format(transactions[index].date)),
        ));
  }

  Card getChildViews(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                    style: BorderStyle.solid)),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '\$${transactions[index].amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transactions[index].title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start),
              Text(DateFormat.yMMMEd().format(transactions[index].date),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.merge(TextStyle(color: Colors.grey)))
            ],
          )
        ],
      ),
    );
  }
}
