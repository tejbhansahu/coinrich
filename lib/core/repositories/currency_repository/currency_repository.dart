import 'package:coinrich/core/models/currency_list/currency_response.dart';

abstract class CurrencyRepository {
  Future<List<CryptoCurrencyResponse>> fetchCurrencyList();
}
