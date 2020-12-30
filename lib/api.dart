import 'dart:convert';

import 'package:app/app.dart';
import 'package:http/http.dart' as http;
import 'package:app/model/category.dart';
import 'package:app/model/transaction.dart';

import 'package:app/model/asset.dart';

class Api {
  static String get accessToken => PrefService.getString('accessToken');

  static get _headers => {
        'Authorization': 'Bearer $accessToken',
        'User-Agent': 'Snack Money App/0.1.0 (android).',
        'Content-Type': 'application/json',
      };

  static const baseUrl = 'https://dev.lunchmoney.app/v1';

  static Future<List<Asset>> getAssets() async {
    print('HTTP GET /assets');
    var res = await http.get('$baseUrl/assets', headers: _headers);

    print(res.statusCode);

    var data = json.decode(res.body);

    return data['assets'].map<Asset>((m) => Asset.fromJson(m)).toList();
  }

  static Future<List<Category>> getCategories() async {
    print('HTTP GET /categories');
    var res = await http.get('$baseUrl/categories', headers: _headers);

    print(res.statusCode);

    var data = json.decode(res.body);

    return data['categories']
        .map<Category>((m) => Category.fromJson(m))
        .toList();
  }

  static Future<List<Transaction>> getTransactions(
    DateTime start,
    DateTime end,
  ) async {
    print('HTTP GET /transactions');
    /* 
    var res = await http.get('$baseUrl/transactions', headers: _headers); */
    var res = await http.get(
        '$baseUrl/transactions?start_date=${start.toIso8601String()}&end_date=${end.toIso8601String()}',
        headers: _headers);
/*     var res = await http.get(
        '$baseUrl/transactions?start_date=${DateTime(2019).toIso8601String()}&end_date=${DateTime(2021).toIso8601String()}',
        headers: _headers); */

    print(res.statusCode);

    var data = json.decode(res.body);

    return data['transactions']
        .map<Transaction>((m) => Transaction.fromJson(m))
        .toList();
  }

  static Map<String, double> exchangeRates = {};

  static Future updateExchangeRates() async {
    var rateCache = PrefService.getString('exchange_rates_cache');
    if (rateCache != null) {
      exchangeRates = json.decode(rateCache)['rates'].cast<String, double>();
    }

    var res = await http.get(
      'https://api.exchangeratesapi.io/latest?base=USD',
    );

    if (res.statusCode == 200) {
      PrefService.setString('exchange_rates_cache', res.body);
      var data = json.decode(res.body);

      exchangeRates = data['rates'].cast<String, double>();
    }
  }

  static Future<List<int>> insertTransactions(
    List<Transaction> list, {
    bool applyRules = true,
    bool checkForRecurring = true,
    bool debitAsNegative = true,
  }) async {
    print('HTTP POST /transactions');

    var res = await http.post(
      '$baseUrl/transactions',
      headers: _headers,
      body: json.encode(
        {
          'transactions': list,
          'apply_rules': applyRules,
          'check_for_recurring': checkForRecurring,
          'debit_as_negative': debitAsNegative,
        },
      ),
    );

    print(res.statusCode);

    var data = json.decode(res.body);

    if (data['error'] != null) throw data['error'];

    print(data);

    return data['ids'].cast<int>();
  }
}
