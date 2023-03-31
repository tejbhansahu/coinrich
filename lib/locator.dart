import 'package:coinrich/core/data_sources/currencies/currencies_local_data_source.dart';
import 'package:coinrich/core/data_sources/currencies/currencies_remote_data_source.dart';
import 'package:coinrich/core/services/http/http_service.dart';
import 'package:coinrich/core/services/http/http_service_impl.dart';
import 'package:coinrich/core/utils/file_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'core/repositories/currency_repository/currency_repository.dart';
import 'core/repositories/currency_repository/currency_repository_impl.dart';
import 'core/services/connectivity/connectivity_service.dart';
import 'core/services/connectivity/connectivity_service_impl.dart';
import 'core/services/snackbar/snack_bar_service.dart';
import 'core/services/snackbar/snack_bar_service_impl.dart';

GetIt locator = GetIt.instance;

/// Setup function that is run before the App is run.
///   - Sets up singletons that can be called from anywhere
/// in the app by using locator<Service>() call.
///   - Also sets up factor methods for view models.
Future<void> setupLocator() async {
  // Services
  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
  locator.registerLazySingleton<SnackBarService>(() => SnackBarServiceImpl());
  locator.registerLazySingleton<HttpService>(() => HttpServiceImpl());

  // Data sources
  locator.registerLazySingleton<CurrencyLocalDataSource>(
    () => CurrenciesLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<CurrencyRemoteDataSource>(
    () => CurrencyRemoteDataSourceImpl(),
  );

  // Repositories
  locator.registerLazySingleton<CurrencyRepository>(
      () => CurrencyRepositoryImpl());

  // Utils
  locator.registerLazySingleton<FileHelper>(() => FileHelperImpl());

  // External
  locator.registerLazySingleton<HiveInterface>(() => Hive);
}
