import 'package:app/app.dart';
import 'package:app/data/currencies.dart';
import 'package:app/data/currency_formats.dart';
import 'package:app/logic/app.dart';
import 'package:app/main.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:url_launcher/url_launcher.dart';


class PreferencesPage extends StatefulWidget {
  final bool isSetup;
  PreferencesPage({this.isSetup = false});
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final accessTokenCtrl =
      TextEditingController(text: PrefService.getString('accessToken') ?? '');

  bool get isValid => (accessTokenCtrl.text.length == 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSetup ? 'Initial setup' : 'Preferences'),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          //TitleWidget('Primary Currency'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Primary Currency',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                SearchableDropdown.single(
                  searchHint: 'Choose your primary currency',
                  value: primaryCurrency,
                  displayClearIcon: false,
                  items: [
                    for (var currency in fullCurrencies.values)
                      DropdownMenuItem(
                        child: Text('${currency.name} (${currency.code})'),
                        value: '${currency.code}',
                      )
                  ],
                  searchFn:
                      (String keyword, List<DropdownMenuItem<String>> items) {
                    keyword = keyword.toLowerCase();

                    var list = <int>[];

                    for (int i = 0; i < items.length; i++) {
                      var currency = fullCurrencies[items[i].value];
                      if (currency.code.toLowerCase().contains(keyword) ||
                          currency.name.toLowerCase().contains(keyword)) {
                        list.add(i);
                      }
                    }

                    return list;

                    // List<int>
                  },
                  onChanged: (val) {
                    var oldPrimaryCurrency = primaryCurrency;
                    setState(() {
                      primaryCurrency = val;
                    });
                    if (primaryCurrency != oldPrimaryCurrency) {
                      $get<AppLogic>().transactions = null;
                      $get<AppLogic>().loadTransactions();
                    }
                  },
                  underline: Container(
                    color: Theme.of(context).dividerColor,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text(
                        'Currency Formatting',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SwitchListTile(
                      title: Text('Invert Seperators'),
                      value: invertSeperators,
                      onChanged: (val) {
                        setState(() {
                          invertSeperators = val;
                        });
                        $get<AppLogic>().$set();
                      },
                    ),
                    ListTile(
                      title: Text('Custom Seperator'),
                      trailing: DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              '<none>',
                            ),
                            value: null,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Space: " "',
                            ),
                            value: ' ',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Apostrophe: ’',
                            ),
                            value: '’',
                          ),
                        ],
                        value: customSeperator,
                        onChanged: (val) {
                          setState(() {
                            customSeperator = val;
                          });
                          $get<AppLogic>().$set();
                        },
                        underline: Container(
                          color: Theme.of(context).dividerColor,
                          height: 1,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Pattern'),
                      trailing: DropdownButton(
                        items: [
                          for (var pattern in formattingPatterns)
                            DropdownMenuItem(
                              child: Text(
                                FormattingUtil.formatMoney(
                                  123456789,
                                  customPattern: pattern,
                                ),
                              ),
                              value: pattern,
                            ),
                        ],
                        value: formattingPattern,
                        onChanged: (val) {
                          setState(() {
                            formattingPattern = val;
                          });
                          $get<AppLogic>().$set();
                        },
                        underline: Container(
                          color: Theme.of(context).dividerColor,
                          height: 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text(
                        'Preview',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ListTile(
                      title: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('US Dollar (USD):'),
                              Text(FormattingUtil.formatMoney(
                                123456789,
                                currency: 'USD',
                              )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Euro (EUR):'),
                              Text(FormattingUtil.formatMoney(
                                123456789,
                                currency: 'EUR',
                              )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Bitcoin (BTC):'),
                              Text(FormattingUtil.formatMoney(
                                123456789,
                                currency: 'BTC',
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Lunch Money Access Token'),
              controller: accessTokenCtrl,
              onChanged: (s) {
                PrefService.setString('accessToken', s);
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
                'You need a Lunch Money account to use this app. You can create an access token on the Developers page on the Lunch Money website when logged in.'),
          ),

          FlatButton(
            onPressed: () {
              launch('https://my.lunchmoney.app/developers');
            },
            child: Text('Click to open the Lunch Money website'),
          ),
          if (widget.isSetup)
            SizedBox(
              height: 70,
            ),
        ],
      ),
      floatingActionButton: (widget.isSetup && isValid)
          ? FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => Home(),
                ));
              },
            )
          : null,
    );
  }
}
