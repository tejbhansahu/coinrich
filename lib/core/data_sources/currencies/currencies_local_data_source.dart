import 'package:coinrich/core/models/currency_list/currency_response.dart';
import 'package:coinrich/core/models/currency_list/currency_response_hive.dart';
import 'package:hive/hive.dart';
import 'package:coinrich/core/constant/local_storage_keys.dart';
import 'package:coinrich/core/exceptions/cache_exception.dart';
import 'package:coinrich/core/utils/file_helper.dart';
import 'package:coinrich/locator.dart';

abstract class CurrencyLocalDataSource {
  Future<void> init();

  Future<List<CryptoCurrencyResponse>> fetchCurrencies();

  Future<void> cacheCurrencies(List<CryptoCurrencyResponse> currencyList);
}

class CurrenciesLocalDataSourceImpl implements CurrencyLocalDataSource {
  final FileHelper _fileHelper = locator<FileHelper>();
  final HiveInterface _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(LocalStorageKeys.currencyList);

  Box<CurrencyListHive> get _currenciesBox =>
      _hiveService.box<CurrencyListHive>(LocalStorageKeys.currencyList);

  @override
  Future<void> init() async {
    final path = await _fileHelper.getApplicationDocumentsDirectoryPath();
    _hiveService.init(path);
    _hiveService.registerAdapter<CurrencyListHive>(CurrencyListHiveAdapter());
    if (!_isBoxOpen) {
      await _hiveService
          .openBox<CurrencyListHive>(LocalStorageKeys.currencyList);
    }
  }

  @override
  Future<List<CryptoCurrencyResponse>> fetchCurrencies() async {
    if (!_isBoxOpen) {
      await _hiveService
          .openBox<CurrencyListHive>(LocalStorageKeys.currencyList);
    }
    if (_currenciesBox.isEmpty) {
      throw const CacheException('No currencies list found in cache');
    }
    return _currenciesBox.values
        .map<CryptoCurrencyResponse>((currenciesListHive) =>
            CryptoCurrencyResponse.fromJson(currenciesListHive.toMap()))
        .toList();
  }

  @override
  Future<void> cacheCurrencies(List<CryptoCurrencyResponse> currencyList) async {
    final currenciesMap = <String, CurrencyListHive>{};
    for (var currency in currencyList) {
      currenciesMap.addAll({currency.id!: CurrencyListHive.fromModel(currency)});
    }
    await _currenciesBox.putAll(currenciesMap);
  }
}
