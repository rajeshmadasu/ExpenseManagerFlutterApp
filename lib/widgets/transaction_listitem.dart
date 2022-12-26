import 'dart:math';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? _bgColor;
  @override
  void initState() {
    super.initState();
    const availableColors = [
      Colors.red,
      Colors.amber,
      Colors.blue,
      Colors.purple
    ];

    _bgColor = availableColors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(child: Text('\$${widget.transaction.amount}')),
            ),
          ),
          title: Text(
            widget.transaction.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(DateFormat.yMMMEd().format(widget.transaction.date)),
          trailing: MediaQuery.of(context).size.width > 460
              ? TextButton.icon(
                  label: const Text('Delete'),
                  icon: const Icon(Icons.delete),
                  onPressed: () => widget.deleteTx(widget.transaction.id),
                )
              : IconButton(
                  onPressed: () => widget.deleteTx(widget.transaction.id),
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                ),
        ));
  }
}
