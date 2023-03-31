import 'package:coinrich/core/enums/connectivity_status.dart';
import 'package:coinrich/core/services/connectivity/connectivity_service.dart';
import 'package:coinrich/ui/views/home/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'locator.dart';

/// List of providers that provider transforms into a widget tree
/// with the main app as the child of that tree, so that the entire
/// app can use these streams anywhere there is a [BuildContext]
List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [];

List<SingleChildWidget> dependentServices = [];

List<SingleChildWidget> uiConsumableProviders = [
  ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
  StreamProvider<ConnectivityStatus>(
    initialData: ConnectivityStatus.cellular,
    create: (context) => locator<ConnectivityService>().connectivity$,
  ),
];
