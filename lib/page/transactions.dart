import 'package:app/app.dart';
import 'package:app/logic/app.dart';
import 'package:app/main.dart';
import 'package:app/model/category.dart';
import 'package:app/model/transaction.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TransactionsPage extends StatefulWidget {
  final Category category;

  TransactionsPage({this.category});
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

enum SortParameter {
  price,
  date,
}

class _TransactionsPageState extends State<TransactionsPage> {
  int get catId => widget.category.id;
  AppLogic get logic => $get<AppLogic>();

  Category get cat => catId == 0
      ? (Category(name: 'Transactions', id: 0)
        ..transactions = logic.transactions)
      : logic.categories.firstWhere((element) => element.id == catId);

  bool sortDescending = true;

  SortParameter sortParameter = SortParameter.price;

  List<Transaction> transactions = [];

  @override
  void initState() {
    if (catId != 0) logic.currentCategory = widget.category;
    super.initState();
  }

  @override
  void dispose() {
    logic.currentCategory = null;
    super.dispose();
  }

  _filterAndSort() {
    transactions = cat.transactions.toList();

    Function sortFunction;

    switch (sortParameter) {
      case SortParameter.price:
        sortFunction = (Transaction a, Transaction b) =>
            a.amount.abs().compareTo(b.amount.abs());
        break;
      case SortParameter.date:
        sortFunction =
            (Transaction a, Transaction b) => a.date.compareTo(b.date);
        break;
    }
    transactions.sort((a, b) => (sortDescending ? -1 : 1) * sortFunction(a, b));

    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WatchLogic<AppLogic>(
      (l) {
        _filterAndSort();
        //final cat = l.categories.firstWhere((element) => element.id == catId);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            backgroundColor: cat.color,
            title: Text(
              cat.name,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  sortParameter == SortParameter.date
                      ? MdiIcons.calendarRange
                      : MdiIcons.currencyUsd,
                ),
                onPressed: () {
                  sortParameter = (sortParameter == SortParameter.date)
                      ? SortParameter.price
                      : SortParameter.date;

                  _filterAndSort();
                },
              ),
              IconButton(
                icon: Icon(
                  sortDescending
                      ? MdiIcons.sortDescending
                      : MdiIcons.sortAscending,
                ),
                onPressed: () {
                  sortDescending = !sortDescending;
                  _filterAndSort();
                },
              ),
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl:
                    'https://unsplash.com/photos/cssvEZacHvQ/download?force=true',

                fit: BoxFit.cover,
                //fadeInDuration: Duration(milliseconds: 1000),
              ),
              ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  for (var tx in transactions) ...[
                    wrapCardWithPadding(
                      WidgetCard(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    tx.payee,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '${FormattingUtil.formatTransactionDate(tx.date)}' +
                                        ((tx.notes ?? '').isNotEmpty
                                            ? ' • ${tx.notes}'
                                            : ''),
                                  ),
                                ],
                              ),
                            ),
                            /*   */
                            Text(
                              FormattingUtil.formatMoney(
                                tx.amount,
                                currency: tx.currency,
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        /*   child: ListTile(
                          title: Text(
                            tx.payee,
                          ),
                          subtitle: 
                          trailing:
                        ), */
                      ),
                    ),
                    /*   Divider(
                        height: 1,
                        thickness: 1,
                      ), */
                  ],
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
