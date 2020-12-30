import 'package:app/app.dart';

import 'transaction.dart';

class Category {
  int id;
  String name;
  String description;
  bool isIncome;
  bool excludeFromBudget;
  bool excludeFromTotals;
  String updatedAt;
  String createdAt;

  Color color;

  List<Transaction> transactions;
  double totalAmount;

  Category(
      {this.id,
      this.name,
      this.description,
      this.isIncome,
      this.excludeFromBudget,
      this.excludeFromTotals,
      this.updatedAt,
      this.createdAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isIncome = json['is_income'];
    excludeFromBudget = json['exclude_from_budget'];
    excludeFromTotals = json['exclude_from_totals'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['is_income'] = this.isIncome;
    data['exclude_from_budget'] = this.excludeFromBudget;
    data['exclude_from_totals'] = this.excludeFromTotals;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
