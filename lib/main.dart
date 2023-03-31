import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:coinrich/ui/app.dart';
import 'core/constant/colors.dart';
import 'firebase_options.dart';
import 'locator.dart';
import 'logger.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    setupLogger();
    await setupLocator();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: AppColors.transparentColor,
        statusBarIconBrightness: Brightness.dark));
    runZoned(() => runApp(const App()));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
