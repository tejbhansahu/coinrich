import 'package:coinrich/core/enums/connectivity_status.dart';
import 'package:coinrich/core/utils/custom_snackbar.dart';
import 'package:coinrich/ui/views/home/view.dart';
import 'package:coinrich/ui/widgets/noInternet.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityStatus>(
      builder: (BuildContext context, value, Widget? child) {
        if (value == ConnectivityResult.none) {
          return const NoInternet();
        } else {
          return const HomePage();
        }
      },
    );
  }
}
