import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:coinrich/core/models/snack_bar_request/snack_bar_request.dart';
import 'package:coinrich/core/models/snack_bar_response/snack_bar_response.dart';

abstract class SnackBarService {
  Future<SnackBarResponse> showSnackBar(
      BuildContext context, SnackBarRequest alertRequest);

  void completeSnackBar(BuildContext context, SnackBarResponse response);
}
