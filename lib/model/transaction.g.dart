// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    payee: json['payee'] as String,
    $amount: json['amount'] as String,
    notes: json['notes'] as String,
    categoryId: json['category_id'] as int,
    recurringId: json['recurring_id'] as int,
    assetId: json['asset_id'] as int,
    plaidAccountId: json['plaid_account_id'] as int,
    status: json['status'] as String,
    isGroup: json['is_group'] as bool,
    groupId: json['group_id'] as int,
    parentId: json['parent_id'] as int,
    tags: (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    externalId: json['external_id'] as String,
  )
    ..id = json['id'] as int
    ..$currency = json['currency'] as String;
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('external_id', instance.externalId);
  writeNotNull('date', instance.date?.toIso8601String());
  writeNotNull('payee', instance.payee);
  writeNotNull('amount', instance.$amount);
  writeNotNull('currency', instance.$currency);
  writeNotNull('notes', instance.notes);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('recurring_id', instance.recurringId);
  writeNotNull('asset_id', instance.assetId);
  writeNotNull('plaid_account_id', instance.plaidAccountId);
  writeNotNull('status', instance.status);
  writeNotNull('is_group', instance.isGroup);
  writeNotNull('group_id', instance.groupId);
  writeNotNull('parent_id', instance.parentId);
  writeNotNull('tags', instance.tags);
  return val;
}
