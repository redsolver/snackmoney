class Asset {
  int id;
  String typeName;
  String subtypeName;
  String name;
  double balance;
  String balanceAsOf;
  String currency;
  String institutionName;
  String createdAt;

  Asset(
      {this.id,
      this.typeName,
      this.subtypeName,
      this.name,
      this.balance,
      this.balanceAsOf,
      this.currency,
      this.institutionName,
      this.createdAt});

  Asset.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    subtypeName = json['subtype_name'];
    name = json['name'];
    balance = double.tryParse(json['balance']);
    balanceAsOf = json['balance_as_of'];
    currency = (json['currency'] ?? '').toUpperCase();
    institutionName = json['institution_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_name'] = this.typeName;
    data['subtype_name'] = this.subtypeName;
    data['name'] = this.name;
    data['balance'] = this.balance;
    data['balance_as_of'] = this.balanceAsOf;
    data['currency'] = this.currency;
    data['institution_name'] = this.institutionName;
    data['created_at'] = this.createdAt;
    return data;
  }
}
