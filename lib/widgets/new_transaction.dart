import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final textTitleContoller = TextEditingController();

  final textAmountContoller = TextEditingController();

  void submitData() {
    String title = textTitleContoller.text;
    double amount = double.parse(textAmountContoller.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }
    /**
   * Flutter establishes a connection and gives us a special property inside of our state class.
    It gives us this widget property and this refactoring step(from stateless to stateful class conversion) automatically added it.
    With Widget Dot, you can access the properties and methods of your widget class inside of your state 
    class.
   */
    widget.addNewTransaction(title, amount);

    /**
     * It's built into Flutter and it can do a lot of awesome stuff here.
    We simply use its pop method to basically close the topmost screen that is displayed, and that is that
    modal sheet if it's opened.So that closes that modal sheet by popping it off.
     */
    // special variable available here
    //Context gives you access to the context related to your widget.

    Navigator.of(context).pop();
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
