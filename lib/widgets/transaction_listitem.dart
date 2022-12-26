import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(child: Text('\$${transaction.amount}')),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(DateFormat.yMMMEd().format(transaction.date)),
          trailing: MediaQuery.of(context).size.width > 460
              ? TextButton.icon(
                  label: const Text('Delete'),
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteTx(transaction.id),
                )
              : IconButton(
                  onPressed: () => deleteTx(transaction.id),
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                ),
        ));
  }
}
