import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  const NewTransaction(this.addNewTransaction, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _textTitleContoller = TextEditingController();

  final _textAmountContoller = TextEditingController();

  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('....');
  }

  void _submitData() {
    if (_textAmountContoller.text.isEmpty) {
      return;
    }
    String title = _textTitleContoller.text;
    double amount = double.parse(_textAmountContoller.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }
    /**
   * Flutter establishes a connection and gives us a special property inside of our state class.
    It gives us this widget property and this refactoring step(from stateless to stateful class conversion) automatically added it.
    With Widget Dot, you can access the properties and methods of your widget class inside of your state 
    class.
   */
    widget.addNewTransaction(title, amount, _selectedDate);

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
    return SingleChildScrollView(
        child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _textTitleContoller,

                    // onChanged: (value) {
                    //   titleInput = value;
                    // },
                  ),
                  TextField(
                    controller: _textAmountContoller,
                    //onChanged: (value) => {amountInput = value},
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Amount'),
                    onSubmitted: (_) => _submitData(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(_selectedDate == null
                                ? 'No Date Selected!'
                                : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}')),
                        TextButton(
                          onPressed: _presentDatePicker,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            //print('$titleInput' + '-' + '$amountInput')
                            _submitData()
                          },
                      child: const Text(
                        'Add Transaction',
                      ))
                ],
              ),
            )));
  }
}
