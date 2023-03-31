import 'package:coinrich/core/models/currency_list/currency_response.dart';
import 'package:coinrich/core/repositories/currency_repository/currency_repository.dart';
import 'package:coinrich/locator.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final CurrencyRepository? currencyRepositoryImpl =
      locator<CurrencyRepository>();

  List<CryptoCurrencyResponse> list = [];

  bool isLoading = false;

  Future<void> getCurrencies() async {
    isLoading = true;
    notifyListeners();

    try {
      isLoading = true;
      notifyListeners();
      var response = await currencyRepositoryImpl?.fetchCurrencyList();
      if (response!.isNotEmpty) {
        list.addAll(response);
        notifyListeners();
      }
    } on Exception catch (e) {
      throw e.toString();
    } finally {
      if (isLoading) {
        isLoading = false;
        notifyListeners();
      }
    }
  }
}
