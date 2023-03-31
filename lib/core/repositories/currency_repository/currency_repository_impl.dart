import 'package:coinrich/core/data_sources/currencies/currencies_local_data_source.dart';
import 'package:coinrich/core/models/currency_list/currency_response.dart';
import 'package:logging/logging.dart';
import 'package:coinrich/core/exceptions/cache_exception.dart';
import 'package:coinrich/core/exceptions/network_exception.dart';
import 'package:coinrich/core/exceptions/repository_exception.dart';
import 'package:coinrich/core/services/connectivity/connectivity_service.dart';
import 'package:coinrich/locator.dart';
import '../../data_sources/currencies/currencies_remote_data_source.dart';
import 'currency_repository.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource? remoteDataSource =
      locator<CurrencyRemoteDataSource>();
  final CurrencyLocalDataSource? localDataSource =
      locator<CurrencyLocalDataSource>();
  final ConnectivityService? connectivityService =
      locator<ConnectivityService>();

  final _log = Logger('MovieRepositoryImpl');

  @override
  Future<List<CryptoCurrencyResponse>> fetchCurrencyList() async {
    try {
      if (await connectivityService!.isConnected) {
        final currencyList = await remoteDataSource!.fetchCurrencies();
        await localDataSource!.cacheCurrencies(currencyList);
        return currencyList;
      } else {
        final currencyList = await localDataSource!.fetchCurrencies();
        return currencyList;
      }
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch currencies list remotely');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch currencies list locally');
      throw RepositoryException(e.message);
    }
  }
}
