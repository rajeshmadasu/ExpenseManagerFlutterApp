import 'dart:ffi';

import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;
  final textTitleContoller = TextEditingController();
  final textAmountContoller = TextEditingController();

  NewTransaction(this.addNewTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: 'Title'),
                controller: textTitleContoller,
                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextField(
                controller: textAmountContoller,
                //onChanged: (value) => {amountInput = value},
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              TextButton(
                  onPressed: () => {
                        //print('$titleInput' + '-' + '$amountInput')
                        addNewTransaction(textTitleContoller.text,
                            double.parse(textAmountContoller.text))
                      },
                  child: const Text(
                    'Add Transaction',
                  ))
            ],
          ),
        ));
  }
}
