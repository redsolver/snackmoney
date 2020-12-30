import 'package:app/app.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

/* const symbols = {
  'eur': '€',
  'usd': '\$',
}; */

/* final currencies = {
  'eur': Currency.create('EUR', 2, symbol: '€'),
  'usd': Currency.create('USD', 2, symbol: '\$'),
  'btc': Currency.create('BTC', 4),
}; */

class FormattingUtil {
  static String formatMoney(double amount,
      {String currency, String customPattern}) {
    if (currency == null) currency = primaryCurrency;

/*     int digits = 2;

    if (currency == 'btc') {
      digits = 4;
    } */

    //String symbol = symbols[currency] ?? currency.toUpperCase();

    var curr = Currencies.find(currency.toUpperCase());

    String pattern = customPattern ?? formattingPattern;

    bool isNegative = amount < 0;

    //amount = 123456789;

    //String pattern = '###,###,###.00 S';
    if (invertSeperators) {
      pattern = pattern
          .replaceAll(',', 'X')
          .replaceAll('.', ',')
          .replaceAll('X', '.');
    }

    if (curr == null) {
      curr = Currency.create(
        currency.toUpperCase(),
        2,
        symbol: currency.toUpperCase() + (pattern.startsWith('S#') ? ' ' : ''),
      );
    }

    /*
S###,###,###.00
###,###,###.00 S
CCC ###,###,###.00
###,###,###.00 CCC
S ###,###,###.00
S##,##,##,###.00
#########.00 S
     */

    var c = Currency.create(
      curr.code,
      curr.minorDigits,
      pattern: curr.pattern,
      symbol: curr.symbol,
      invertSeparators: invertSeperators,
    );
    var money = Money.from(amount.abs(), c);

/*     print(curr.pattern);
 */
    /*
 * S outputs the currencies symbol e.g. $.
 * C outputs part of the currency code e.g. USD. You can specify 1,2 or 3 C's. Specifying CCC will output the full code regardless of its length.
     * C - U
     * CC - US
     * CCC - USD - outputs the full currency code regardless of length.
 * # denotes a digit.
 * 0 denotes a digit and and forces padding with leading and trailing zeros.
 * , (comma) a placeholder for the grouping separtor
 * . (period) a place holder for the decimal separator 
 * 
     */

    var str = money.format(
      pattern, // TODO Configure
    );
    if (customSeperator != null) {
      str = str.replaceAll(invertSeperators ? '.' : ',', customSeperator);
    }

    //var str = money.; // TODO Configurable

    //print(money.format('SCC #.00'));
    //print(money.format('SCCC 0.0'));

    if (isNegative) str = '+$str';

    return str;
  }

  static String formatTransactionDate(DateTime date) {
    return DateFormat('MMMd').format(date); // TODO Configurable
  }

  static String formatOverviewMonth(DateTime date) {
    return DateFormat('MMMM yyyy').format(date); // TODO Configurable
  }
}
