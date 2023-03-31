import 'package:hive/hive.dart';

import 'currency_response.dart';

part 'currency_response_hive.g.dart';

/// A Hive Database compatible Currencies List Model
///   - @HiveType(typeId: unique) is necessary for each HiveObject
///   - @HiveField(unique) is necessary if you need the object to persist
@HiveType(typeId: 1)
class CurrencyListHive extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? symbol;

  @HiveField(3)
  final int? cmcRank;

  @HiveField(4)
  final num? price;

  @HiveField(5)
  final double? volume24H;

  @HiveField(6)
  final double? volumeChange24H;

  CurrencyListHive(
      {this.id,
      this.name,
      this.symbol,
      this.cmcRank,
      this.price,
      this.volume24H,
      this.volumeChange24H});

  factory CurrencyListHive.fromModel(CryptoCurrencyResponse currency) {
    return CurrencyListHive(
        symbol: currency.symbol,
        price: currency.price,
        cmcRank: currency.cmcRank,
        id: currency.id,
        name: currency.name,
        volume24H: currency.volume24H,
        volumeChange24H: currency.volumeChange24H);
  }

  factory CurrencyListHive.fromMap(Map<String, dynamic> map) {
    return CurrencyListHive(
        volumeChange24H: map['volume_change_24h'],
        volume24H: map['volume_24h'],
        name: map['name'],
        id: map['id'],
        cmcRank: map['cmc_rank'],
        price: map['price'],
        symbol: map['symbol']);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['volume_change_24h'] = volumeChange24H;
    map['volume_24h'] = volume24H;
    map['name'] = name;
    map['id'] = id;
    map['cmc_rank'] = cmcRank;
    map['price'] = price;
    map['symbol'] = symbol;
    return map;
  }

  @override
  int get hashCode =>
      volumeChange24H.hashCode ^
      volume24H.hashCode ^
      name.hashCode ^
      id.hashCode ^
      cmcRank.hashCode ^
      price.hashCode ^
      symbol.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyListHive &&
          name == other.name &&
          id == other.id &&
          volume24H == other.volume24H &&
          volumeChange24H == other.volumeChange24H &&
          cmcRank == other.cmcRank &&
          price == other.price &&
          symbol == other.symbol;
}
