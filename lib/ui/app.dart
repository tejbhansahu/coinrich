import 'package:coinrich/core/data_sources/currencies/currencies_local_data_source.dart';
import 'package:coinrich/core/managers/core_manager.dart';
import 'package:coinrich/locator.dart';
import 'package:coinrich/provider_setup.dart';
import 'package:coinrich/ui/views/landingPage/landingPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coinrich/ui/shared/themes.dart' as themes;

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final CurrencyLocalDataSource? currenciesLocalDataSource =
      locator<CurrencyLocalDataSource>();

  @override
  void initState() {
    super.initState();
    handleStartUpLogic();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: CoreManager(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themes.primaryMaterialTheme,
          home: const LandingPage(),
        ),
      ),
    );
  }

  Future handleStartUpLogic() async {
    await Future.wait([
      currenciesLocalDataSource!.init(),
    ]);
  }
}
