import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:coinrich/core/models/snack_bar_request/confirm_snack_bar_request.dart';
import 'package:coinrich/core/models/snack_bar_request/snack_bar_request.dart';
import 'package:coinrich/core/models/snack_bar_response/confirm_snack_bar_response.dart';
import 'package:coinrich/core/models/snack_bar_response/snack_bar_response.dart';
import 'package:coinrich/core/services/snackbar/snack_bar_service.dart';

/// A service that is responsible for returning future snackbar
class SnackBarServiceImpl implements SnackBarService {
  final _log = Logger('SnackBarServiceImpl');

  Completer<SnackBarResponse>? _snackBarCompleter;

  @override
  Future<SnackBarResponse> showSnackBar(
      BuildContext context, SnackBarRequest request) {
    _snackBarCompleter = Completer<SnackBarResponse>();

    if (request is ConfirmSnackBarRequest) {
      _log.finer('showConfirmSnackBar');
      _showConfirmSnackBar(context, request);
    }

    return _snackBarCompleter!.future;
  }

  @override
  void completeSnackBar(BuildContext context, SnackBarResponse response) {
    _snackBarCompleter!.complete(response);
    _snackBarCompleter = null;
  }

  void _showConfirmSnackBar(
      BuildContext context, ConfirmSnackBarRequest request) {
    final style = TextStyle(color: Theme.of(context).colorScheme.secondary);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        request.message,
        style: style,
      ),
      dismissDirection: DismissDirection.horizontal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      margin: const EdgeInsets.all(8.0),
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: request.buttonText,
        onPressed: () {
          completeSnackBar(
              context, ConfirmSnackBarResponse((a) => a..confirmed = true));
          if (request.onPressed != null) {
            request.onPressed!();
          }
        },
      ),
    ));
  }
}
