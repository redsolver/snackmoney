import 'package:app/api.dart';
import 'package:app/app.dart';
import 'package:app/model/asset.dart';
import 'package:app/model/category.dart';
import 'package:app/model/transaction.dart';
import 'package:app/util/currency.dart';

List<Color> colors = [
  Colors.red,
  Colors.blue,
  Colors.orange,
  Colors.purple,
  Colors.cyan,
  Colors.amber,
];

class AppLogic extends Logic {
  bool isLoading = false;

  List<Asset> assetsRaw;

  List<Category> categoriesRaw;

  List<Asset> assets;

  List<Category> categories;

  List<Transaction> transactions;

  Category currentCategory;

  int shownMonths = 1;

  var currentMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  );
  double totalExpenses;
  double totalIncome;

  double total;

  bool expensesOverIncome;

  Future loadData() async {
    print(categoriesRaw?.length);

    assetsRaw = await Api.getAssets();

    assetsRaw.sort((a, b) =>
        -CurrencyUtil.exchangeToPrimaryCurrency(a.balance, a.currency)
            .compareTo(
                CurrencyUtil.exchangeToPrimaryCurrency(b.balance, b.currency)));

    $set();

    categoriesRaw = await Api.getCategories();

    print(categoriesRaw?.length);
    await loadTransactions();
  }

  Future loadTransactions() async {
    isLoading = true;
    $set();

    var month = currentMonth;

    var txs = await Api.getTransactions(
      month,
      DateTimeUtil.addMonths(month, shownMonths),
    );

    if (month != currentMonth) {
      print('DISMISSING UPDATE');
      return;
    }
    transactions = txs;
/*     print(transactions);

    for (var t in transactions) {
      print(t.toJson());
    } */

    assets = assetsRaw.toList();
    categories = categoriesRaw.toList();

    totalExpenses = 0;
    totalIncome = 0;
    total = 0;

    var cols = colors.toList();

    categories.add(
      Category(
        name: 'No Category',
        id: null,
        excludeFromBudget: false,
        excludeFromTotals: false,
        isIncome: false,
        description: 'Transactions without a category',
      ),
    );

    for (var cat in categories) {
      cat.transactions = transactions
          .where((element) => element.categoryId == cat.id)
          .toList();

      cat.transactions.sort((a, b) =>
          -CurrencyUtil.exchangeToPrimaryCurrency(a.amount, a.currency)
              .abs()
              .compareTo(
                  CurrencyUtil.exchangeToPrimaryCurrency(b.amount, b.currency)
                      .abs()));

      double value = 0;

      cat.transactions.forEach((t) {
        value += CurrencyUtil.exchangeToPrimaryCurrency(t.amount, t.currency);
      });

      cat.totalAmount = value;
    }
    categories.removeWhere((cat) => cat.excludeFromTotals);

    categories
        .sort((a, b) => -a.totalAmount.abs().compareTo(b.totalAmount.abs()));

    for (var cat in categories) {
      if (cat.totalAmount >= 0) {
        cat.color = cols.isNotEmpty ? cols.removeAt(0) : Colors.black;
      } else {
        cat.color = Colors.green;
      }

      if (cat.isIncome) {
        totalIncome += cat.totalAmount;
      } else {
        totalExpenses += cat.totalAmount;
      }
    }
    expensesOverIncome = totalIncome.abs() < totalExpenses.abs();

    total = expensesOverIncome ? totalExpenses.abs() : totalIncome.abs();
    isLoading = false;

    $set();
  }
}
