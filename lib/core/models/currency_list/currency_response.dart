// To parse this JSON data, do
//
//     final cryptoCurrencyResponse = cryptoCurrencyResponseFromJson(jsonString);

import 'dart:convert';

CryptoCurrencyResponse cryptoCurrencyResponseFromJson(String str) => CryptoCurrencyResponse.fromJson(json.decode(str));

String cryptoCurrencyResponseToJson(CryptoCurrencyResponse data) => json.encode(data.toJson());

class CryptoCurrencyResponse {
  CryptoCurrencyResponse({
    this.id,
    this.name,
    this.symbol,
    this.cmcRank,
    this.price,
    this.volume24H,
    this.volumeChange24H,
  });

  String? id;
  String? name;
  String? symbol;
  int? cmcRank;
  double? price;
  double? volume24H;
  double? volumeChange24H;

  factory CryptoCurrencyResponse.fromJson(Map<String, dynamic> json) => CryptoCurrencyResponse(
    id: json["id"],
    name: json["name"],
    symbol: json["symbol"],
    cmcRank: json["cmc_rank"],
    price: json["price"].toDouble(),
    volume24H: json["volume_24h"].toDouble(),
    volumeChange24H: json["volume_change_24h"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "symbol": symbol,
    "cmc_rank": cmcRank,
    "price": price,
    "volume_24h": volume24H,
    "volume_change_24h": volumeChange24H,
  };
}
