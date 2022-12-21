import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;
  final textTitleContoller = TextEditingController();
  final textAmountContoller = TextEditingController();

  NewTransaction(this.addNewTransaction, {super.key});

  void submitData() {
    String title = textTitleContoller.text;
    double amount = double.parse(textAmountContoller.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }
    addNewTransaction(title, amount);
  }

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
                onSubmitted: (_) => submitData(),

                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextField(
                controller: textAmountContoller,
                //onChanged: (value) => {amountInput = value},
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                onSubmitted: (_) => submitData(),
              ),
              TextButton(
                  onPressed: () => {
                        //print('$titleInput' + '-' + '$amountInput')
                        submitData()
                      },
                  child: const Text(
                    'Add Transaction',
                  ))
            ],
          ),
        ));
  }
}
