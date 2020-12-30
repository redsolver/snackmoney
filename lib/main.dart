import 'package:animations/animations.dart';
import 'package:app/app.dart';
import 'package:app/logic/app.dart';
import 'package:app/page/add_transaction.dart';
import 'package:app/page/home.dart';

import 'package:app/api.dart';
import 'package:app/page/preferences.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:money2/money2.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefService.init(prefix: 'pref_');
  CommonCurrencies().registerAll();

  Api.updateExchangeRates();

  runApp(
    UseLogic(
      [
        AppLogic(),
      ],
      child: MaterialApp(
        title: 'Snack Money',
        theme: ThemeData(
          primaryColor: Color(0xff433e7c),
          accentColor: Color(0xff433e7c),
        ),
        home: (PrefService.getString('accessToken') ?? '').isNotEmpty
            ? Home()
            : PreferencesPage(isSetup: true),
      ),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Widget wrapCardWithPadding(Widget card) {
  return Padding(
      padding: const EdgeInsets.all(6.0),
      child: card); // TODO Make Padding configurable
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    $get<AppLogic>().loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (navigatorKey.currentState.canPop()) {
          navigatorKey.currentState.pop();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: '/',
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(builder: (context) => HomePage());
          },
        ),
        bottomNavigationBar: WatchLogic<AppLogic>(
          (l) => Hero(
            tag: 'bottom_app_bar',
            child: BottomAppBar(
              shape: CircularNotchedRectangle(),
              //notchMargin: 6,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // TODO PopupMenuButton(itemBuilder: null)

                      /*       SizedBox(
                        width: 48,
                      ), */
                      PopupMenuButton(
                        initialValue: l.shownMonths,
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: Text('5 Years'),
                              value: 60,
                            ),
                            PopupMenuItem(
                              child: Text('2 Years'),
                              value: 24,
                            ),
                            PopupMenuItem(
                              child: Text('1 Year'),
                              value: 12,
                            ),
                            PopupMenuItem(
                              child: Text('6 Months'),
                              value: 6,
                            ),
                            PopupMenuItem(
                              child: Text('3 Months'),
                              value: 3,
                            ),
                            PopupMenuItem(
                              child: Text('1 Month'),
                              value: 1,
                            ),
                          ];
                        },
                        onSelected: (months) {
                          l.shownMonths = months;

                          l.loadTransactions();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(MdiIcons.calendarText),
                        ),
                      ),
                      /*     InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(MdiIcons.calendarText),
                        ),
                        onTap: () {
                          l.currentMonth =
                              DateTimeUtil.removeMonths(l.currentMonth, 1);
                          l.loadTransactions();
                        },
                        onLongPress: () {
                          l.currentMonth =
                              DateTimeUtil.removeMonths(l.currentMonth, 12);
                          l.loadTransactions();
                        },
                      ), */
                      SizedBox(
                        width: 24.0,
                      ),

                      /*    SizedBox(
                        width: 48,
                      ), */
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(MdiIcons.calendarArrowLeft),
                        ),
                        onTap: () {
                          l.currentMonth =
                              DateTimeUtil.removeMonths(l.currentMonth, 1);
                          l.loadTransactions();
                        },
                        onLongPress: () {
                          l.currentMonth = DateTimeUtil.removeMonths(
                              l.currentMonth, l.shownMonths);
                          l.loadTransactions();
                        },
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // TODO Selector Popup

                            return;
                            final list = [1, 3, 6, 12, 24];

                            var index = list.indexOf(l.shownMonths);
                            index++;
                            if (index >= list.length) index = 0;
                            l.shownMonths = list[index];
                            l.loadTransactions();
                          },
                          onLongPress: () {
                            l.shownMonths = 1;
                            l.currentMonth = DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                            );
                            l.loadTransactions();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              '${FormattingUtil.formatOverviewMonth(l.currentMonth)}' +
                                  (l.shownMonths > 1
                                      ? ' - ${FormattingUtil.formatOverviewMonth(DateTimeUtil.addMonths(l.currentMonth, l.shownMonths - 1))}'
                                      : ''),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(MdiIcons.calendarArrowRight),
                        ),
                        onTap: () {
                          l.currentMonth =
                              DateTimeUtil.addMonths(l.currentMonth, 1);
                          l.loadTransactions();
                        },
                        onLongPress: () {
                          l.currentMonth = DateTimeUtil.addMonths(
                              l.currentMonth, l.shownMonths);
                          l.loadTransactions();
                        },
                      ),

                      /*    Padding(
                        padding: const EdgeInsets.all(24),
                        //  child: Icon(MdiIcons.calendarArrowRight),
                      ), */

                      /*   SizedBox(
                        width: 48,
                      ), */

                      SizedBox(
                        width: 48 + 24.0,
                      ),
                      /*    SizedBox(
                        width: 48,
                      ), */
                    ],
                  ),
                  if (l.isLoading)
                    /* Align(
                      alignment: Alignment.bottomCenter,
                      child: */
                    LinearProgressIndicator(),
                  /*       ), */
                ],
              ),
            ),
          ),
        ),
        extendBody: true,
        floatingActionButton: OpenContainer(
          transitionType: ContainerTransitionType.fade,
          openBuilder: (BuildContext context, VoidCallback _) {
            return AddTransactionPage();
          },
          closedElevation: 6.0,
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(_fabDimension / 2),
            ),
          ),
          closedColor: Theme.of(context).colorScheme.secondary,
          closedBuilder: (BuildContext context, VoidCallback openContainer) {
            return SizedBox(
              height: _fabDimension,
              width: _fabDimension,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            );
          },
        ),
        /* FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddTransactionPage()));
          },
        ), */
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }

  final navigatorKey = GlobalKey<NavigatorState>();

/*   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabNavigator(
        navigatorKey: navigatorKey,
        tabItem: currentTab,
      ),
      bottomNavigationBar: BottomNavigation(
        currentTab: currentTab,
        onSelectTab: _selectTab,
      ),
    );
  } */
}

const double _fabDimension = 56.0;

class WidgetCard extends StatelessWidget {
  final Widget child;

  final Color color;

  final Function onTap;

  final Function tapPageBuilder;

  WidgetCard({
    @required this.child,
    this.color,
    this.onTap,
    this.tapPageBuilder,
  });

  @override
  Widget build(BuildContext context) {
    /*  if (onTap != null) {
      return Material(
        color: Colors.white.withOpacity(0.8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: color ?? Colors.white,
            child: Column(
              children: <Widget>[
                if (color != null)
                  Container(
                    color: color,
                    height: 8,
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      );
    } */
    return OpenContainer(
      tappable: false,
      openBuilder: (context, action) =>
          tapPageBuilder(context, action) /* TransactionsPage(category: cat) */,
      openColor: Colors.white,
      closedColor: Colors.white.withOpacity(0.8),
      // closedColor: Colors.white,
      closedBuilder: (context, action) => InkWell(
        onTap: tapPageBuilder == null
            ? null
            : () {
                action();
              },
        splashColor: color ?? Colors.white,
        child: Column(
          children: <Widget>[
            if (color != null)
              Container(
                color: color,
                height: 8,
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
/*   @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      child: InkWell(
        onTap: onTap,
        splashColor: color ?? Colors.white,
        child: Column(
          children: <Widget>[
            if (color != null)
              Container(
                color: color,
                height: 8,
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
          ],
        ),
      ),
    );
  } */
}
