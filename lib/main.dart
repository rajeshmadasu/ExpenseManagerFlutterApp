import 'dart:io';
import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import 'package:flutter/cupertino.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                titleMedium: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                titleSmall: const TextStyle(
                    fontFamily: 'OpenSans', fontSize: 12, color: Colors.grey),
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              const TextStyle(color: Colors.white),
            ),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              return Colors.white;
            }),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return Colors.purple;
            }),
          )),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: Colors.purple, error: Colors.red)
              .copyWith(secondary: Colors.amber)),
      title: 'Expense Manager',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: 'id1', title: 'Shoes', amount: 54.5, date: DateTime.now()),
    Transaction(id: 'id2', title: 'Shirts', amount: 77.5, date: DateTime.now()),
    Transaction(id: 'id3', title: 'Cake', amount: 44.5, date: DateTime.now()),
    Transaction(
        id: 'id1', title: 'Groceries', amount: 200.5, date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: choosenDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startModalBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expense Manager'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      _startModalBottomSheet(context);
                    },
                    icon: Icon(Icons.add))
              ],
            ),
          )
        : PreferredSize(
            preferredSize: Size(mediaQuery.size.width, 70),
            child: AppBar(
              title: const Text(
                'Expense Manager',
                style: TextStyle(fontFamily: 'Quicksand'),
              ),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      _startModalBottomSheet(context);
                    },
                    icon: Icon(Icons.add))
              ],
            ));

    final transactionListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _removeTransaction));

    final pageBody = SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Show Chart'),
                Switch.adaptive(
                  activeColor:
                      Theme.of(context).buttonTheme.colorScheme?.secondary,
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                )
              ],
            ),
          if (!isLandscape)
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.3,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ),
          if (!isLandscape) transactionListWidget,
          if (isLandscape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(
                      recentTransactions: _recentTransactions,
                    ),
                  )
                : transactionListWidget
        ]));
    Scaffold getAndroidView(
        PreferredSizeWidget appBar,
        bool isLandscape,
        MediaQueryData mediaQuery,
        Container transactionListWidget,
        SingleChildScrollView pageBody) {
      return Scaffold(
        appBar: appBar,
        body: pageBody,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Platform.isIOS
            ? Container()
            : FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => {_startModalBottomSheet(context)},
              ),
      );
    }

    return getAndroidView(
        appBar, isLandscape, mediaQuery, transactionListWidget, pageBody);
  }
}
