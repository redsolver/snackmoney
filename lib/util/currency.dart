import 'package:app/api.dart';
import 'package:app/app.dart';

class CurrencyUtil {
  static double exchangeToPrimaryCurrency(double amount, String fromCurrency) {
    if (fromCurrency == primaryCurrency) {
      return amount;
    } else {
      if (!Api.exchangeRates.containsKey(fromCurrency))
        return 0; // TODO Send warning

      double amountInUsd = amount / Api.exchangeRates[fromCurrency];
      //   print('$amount $fromCurrency = $amountInUsd USD');

      if (primaryCurrency == 'USD') return amountInUsd;

      if (!Api.exchangeRates.containsKey(primaryCurrency))
        return 0; // TODO Send warning

      double amountInPrimaryCurrency =
          amountInUsd * Api.exchangeRates[primaryCurrency];

      /*   print('$amountInPrimaryCurrency $primaryCurrency = $amountInUsd USD');
      print(
          '$amountInPrimaryCurrency $primaryCurrency = $amount $fromCurrency'); */
      return amountInPrimaryCurrency;
    }
  }
}
