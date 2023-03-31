import 'package:coinrich/core/models/currency_list/currency_response.dart';
import 'package:coinrich/ui/views/home/view.dart';
import 'package:flutter/material.dart';
import 'package:coinrich/ui/shared/fade_page_route.dart';

class Navigate {
  static openDetailPage(
      {required BuildContext context, required CryptoCurrencyResponse data}) {
    Navigator.push(context,
        FadePageRoute(fullscreenDialog: true, builder: (_) => const HomePage()));
  }
}
