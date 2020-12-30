import 'package:app/api.dart';
import 'package:app/app.dart';
import 'package:app/logic/app.dart';
import 'package:app/model/transaction.dart';

class AddTransactionPage extends StatefulWidget {
  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final newTransaction = Transaction(
    $amount: '',
    payee: '',
  );
  @override
  void initState() {
    final cat = $get<AppLogic>().currentCategory;

    if (cat != null) {
      newTransaction.categoryId = cat.id;
    }

    super.initState();
  }

  String _error;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add transaction'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Payee',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  newTransaction.payee = value;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Amount (in $primaryCurrency)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a value';
                  }
                  if (double.tryParse(value.replaceAll(',', '.')) == null) {
                    return 'This is not valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  newTransaction.$amount = value.replaceAll(',', '.');
                },
              ),
              SizedBox(
                height: 16,
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final cat in $get<AppLogic>().categoriesRaw)
                    DropdownMenuItem<int>(
                      child: Text(cat.name),
                      value: cat.id,
                    )
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Please choose a category';
                  }
                  return null;
                },
                onChanged: (value) {
                  newTransaction.categoryId = value;
                },
              ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                  child: Text(
                    'Error: $_error',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: [
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: _loading
                            ? null
                            : () async {
                                // Validate returns true if the form is valid, or false
                                // otherwise.

                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  setState(() {
                                    _error = null;
                                    _loading = true;
                                  });
                                  try {
                                    newTransaction.date = DateTime.now();
                                    print(newTransaction.toJson());
                                    final res = await Api.insertTransactions(
                                        [newTransaction]);

                                    if (res.isNotEmpty) {
                                      Navigator.of(context).pop();
                                    } else {
                                      throw 'Something went wrong';
                                    }
                                  } catch (e, st) {
                                    print(e);
                                    print(st);
                                    setState(() {
                                      _error = e.toString();
                                      _loading = false;
                                    });
                                  }
                                }
                              },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (_loading) ...[
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Creating...'),
                      ]
                    ],
                  )),
            ],
          ),
        ),
      ),
      // TODO Add transaction
      // required date and amount

      // payee and category

      // notes
    );
  }
}
