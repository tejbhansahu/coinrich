import 'package:coinrich/core/constant/api_routes.dart';
import 'package:coinrich/core/models/currency_list/currency_response.dart';
import 'package:coinrich/core/services/http/http_service.dart';
import 'package:coinrich/locator.dart';

abstract class CurrencyRemoteDataSource {
  Future<List<CryptoCurrencyResponse>> fetchCurrencies();
}

class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  final HttpService? httpService = locator<HttpService>();
  final currencies = ['ADA', 'ATOM', 'BCH', 'BNB', 'BTC', 'ETH', 'LTC'];

  @override
  Future<List<CryptoCurrencyResponse>> fetchCurrencies() async {
    final currencyJsonData = await httpService!.getHttp(
        route: ApiRoutes.getCurrenciesList,
        query: {'symbol': 'ADA,ATOM,BCH,BNB,BTC,ETH,LTC'});
    List<CryptoCurrencyResponse> currencyList = [];
    final json = currencyJsonData['data'];
    for (var currency in currencies) {
      currencyList.add(CryptoCurrencyResponse(
        name: json[currency]['name'],
        id: json[currency]['id'].toString(),
        cmcRank: json[currency]['cmc_rank'],
        price: json[currency]['quote']['USD']['price'],
        symbol: json[currency]['symbol'],
        volume24H: json[currency]['quote']['USD']['volume_24h'],
        volumeChange24H: json[currency]['quote']['USD']['volume_change_24h'],
      ));
    }
    return currencyList;
  }
}
