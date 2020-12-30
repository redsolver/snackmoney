import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(includeIfNull: false)
class Transaction {
  int id;

  @JsonKey(name: 'external_id')
  String externalId;

  DateTime date;
  String payee;

  @JsonKey(name: 'amount')
  String $amount;

  @JsonKey(ignore: true)
  double get amount => double.parse($amount);

  @JsonKey(name: 'currency')
  String $currency;

  @JsonKey(ignore: true)
  String get currency => $currency.toUpperCase();

  String notes;
  @JsonKey(name: 'category_id')
  int categoryId;
  @JsonKey(name: 'recurring_id')
  int recurringId;
  @JsonKey(name: 'asset_id')
  int assetId;
  @JsonKey(name: 'plaid_account_id')
  int plaidAccountId;
  String status;
  @JsonKey(name: 'is_group')
  bool isGroup;
  @JsonKey(name: 'group_id')
  int groupId;
  @JsonKey(name: 'parent_id')
  int parentId;
  List<Tag> tags;

  Transaction(
      {this.date,
      this.payee,
      this.$amount,
      this.notes,
      this.categoryId,
      this.recurringId,
      this.assetId,
      this.plaidAccountId,
      this.status,
      this.isGroup,
      this.groupId,
      this.parentId,
      this.tags,
      this.externalId});

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

class Tag {
  String name;
  int id;

  Tag({this.name, this.id});

  Tag.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
