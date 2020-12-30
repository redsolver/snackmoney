import 'package:animations/animations.dart';
import 'package:app/app.dart';
import 'package:app/logic/app.dart';
import 'package:app/main.dart';
import 'package:app/model/category.dart';
import 'package:app/page/preferences.dart';
import 'package:app/page/transactions.dart';
import 'package:app/util/currency.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WatchLogic<AppLogic>(
      (l) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CachedNetworkImage(
            //'https://unsplash.com/photos/VQ41v-gnd1M/download?force=true',
            imageUrl:
                'https://unsplash.com/photos/cssvEZacHvQ/download?force=true',

            fit: BoxFit.cover,
            //fadeInDuration: Duration(milliseconds: 1000),
          ),
          Scrollbar(
            child: RefreshIndicator(
              onRefresh: l.loadData,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  /*   AppBar(
                        title: Text('Snack Money'),
                      ), */
                  if (l.assetsRaw != null) ...[
                    l.assetsRaw.isEmpty
                        ? wrapCardWithPadding(
                            WidgetCard(child: Text('No Assets found')))
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: wrapCardWithPadding(
                                  WidgetCard(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      for (var asset in l.assetsRaw)
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  asset.name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                if (asset.institutionName !=
                                                    null)
                                                  Text(
                                                    asset.institutionName,
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            Text(
                                              FormattingUtil.formatMoney(
                                                asset.balance,
                                                currency: asset.currency,
                                              ),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  )),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    wrapCardWithPadding(
                                      WidgetCard(
                                        tapPageBuilder: (context, action) =>
                                            PreferencesPage(),
                                        /*     onTap: () async {
                                          var oldPrimaryCurrency =
                                              primaryCurrency;
                                          await Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (_) => PreferencesPage(),
                                          ));
                                          if (primaryCurrency !=
                                              oldPrimaryCurrency) {
                                            l.transactions = null;
                                            l.loadTransactions();
                                          } else {
                                            setState(() {});
                                          }
                                        }, */
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text('Welcome!'),
                                            ),
                                            Icon(
                                              Icons.settings,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    wrapCardWithPadding(
                                      WidgetCard(
                                          child: Flex(
                                        direction: Axis.horizontal,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text('Total Net Worth'),
                                              Text(
                                                FormattingUtil.formatMoney(
                                                  l.assetsRaw.fold(
                                                    0,
                                                    (previousValue, element) =>
                                                        previousValue +
                                                        CurrencyUtil
                                                            .exchangeToPrimaryCurrency(
                                                                element.balance,
                                                                element
                                                                    .currency),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ],
                  if ((l.total ?? 0) > 0)
                    Hero(
                      tag: 0,
                      child: wrapCardWithPadding(
                        WidgetCard(
                          /*         onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => TransactionsPage(
                                category: Category(name: 'Transactions', id: 0)
                                  ..transactions = l.transactions,
                              ),
                            ));
                          }, */
                          tapPageBuilder: (context, action) => TransactionsPage(
                              category: Category(name: 'Transactions', id: 0)
                                ..transactions = l.transactions),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('Total Expenses'),
                                  Spacer(),
                                  Text(
                                    FormattingUtil.formatMoney(l.totalExpenses),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: <Widget>[
                                  for (var cat in l.categories
                                      .where((element) => !element.isIncome))
                                    if (cat.totalAmount.abs() > 0)
                                      Flexible(
                                        flex: ((cat.totalAmount.abs() /
                                                    l.total.abs()) *
                                                1000)
                                            .round(),
                                        child: Container(
                                          height: 16,
                                          color: cat.color,
                                        ),
                                      ),
                                  if (!l.expensesOverIncome)
                                    Flexible(
                                      flex: (((l.totalIncome.abs() -
                                                      l.totalExpenses.abs()) /
                                                  l.total.abs()) *
                                              1000)
                                          .round(),
                                      child: Container(
                                        height: 16,
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              l.totalIncome == 0
                                  ? Container(
                                      height: 16,
                                      color: Colors.grey.shade300,
                                    )
                                  : l.expensesOverIncome
                                      ? Row(
                                          children: <Widget>[
                                            Flexible(
                                              flex: 1000,
                                              child: Container(
                                                height: 16,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Flexible(
                                              flex: ((l.totalExpenses.abs() /
                                                              l.totalIncome
                                                                  .abs() -
                                                          1) *
                                                      1000)
                                                  .round(),
                                              child: Container(
                                                height: 16,
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(
                                          height: 16,
                                          color: Colors.green,
                                        ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Total Income'),
                                  Spacer(),
                                  Text(
                                    FormattingUtil.formatMoney(l.totalIncome),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (l.categories != null)
                    for (int i = 0; i < l.categories.length; i++)
                      /*     Row(
                                      children: <Widget>[ */
                      _buildCategoryCard(l.categories[i]),
                  /*  if (i + 1 < categories.length)
                                          _buildCategoryCard(categories[i + 1]),
                                      ],
                                    ), */

                  /*     WidgetCard(
                                    child: Column(
                                      children: <Widget>[
                                        Text(cat.name),
                                      ],
                                    ),
                                  ), */
                  /*       for (var asset in assets)
                      WidgetCard(
                        child: ListTile(
                          title: Text(asset.name),
                          subtitle: asset.institutionName == null
                              ? null
                              : Text(asset.institutionName),
                          trailing:
                              /*         Text(double.tryParse(asset.balance).toString()) */
                              Text(
                            Money.from(
                              asset.balance,
                              currencies[asset.currency],
                            ).toString(),
                          ),
                        ),
                      ) */
                  SizedBox(
                    height: 64,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Category cat) {
    return wrapCardWithPadding(
      WidgetCard(
        color: cat.color,
        tapPageBuilder: (context, action) => TransactionsPage(category: cat),
        /*       onTap: () {
            action();
            /*     Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TransactionsPage(category: cat),
              ),
            ); */
            //Get.to();
          }, */
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  cat.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  FormattingUtil.formatMoney(cat.totalAmount),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            for (var t in cat.transactions.take(maxTransactionsShownPerCat))
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        t.payee /* .substring(0, 23.clamp(0, t.payee.length)) */,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      FormattingUtil.formatMoney(t.amount,
                          currency: t.currency),
                    ),
                  ],
                ),
              ),
            if (cat.transactions.length > maxTransactionsShownPerCat)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Other transactions',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    Text(
                      FormattingUtil.formatMoney(
                        cat.transactions
                            .sublist(maxTransactionsShownPerCat)
                            .fold(
                              0,
                              (previousValue, element) =>
                                  previousValue +
                                  CurrencyUtil.exchangeToPrimaryCurrency(
                                    element.amount,
                                    element.currency,
                                  ),
                            ),
                        currency: primaryCurrency,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
