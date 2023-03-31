import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:retry/retry.dart';
import 'package:coinrich/core/constant/api_timeouts.dart';
import 'package:coinrich/core/constant/env.dart';
import 'package:coinrich/core/exceptions/network_exception.dart';
import 'package:coinrich/core/services/http/http_service.dart';
import 'package:coinrich/core/utils/file_helper.dart';
import 'package:coinrich/locator.dart';
import 'package:coinrich/core/utils/network_utils.dart' as network_utils;

/// Helper service that abstracts away common HTTP Requests
class HttpServiceImpl implements HttpService {
  final FileHelper _fileHelper = locator<FileHelper>();

  final _log = Logger('HttpServiceImpl');
  final Dio _dio = Dio(dioOptions);

  static final BaseOptions dioOptions = BaseOptions(
    connectTimeout: Timeouts.CONNECT_TIMEOUT,
    receiveTimeout: Timeouts.RECEIVE_TIMEOUT,
    baseUrl: Env.baseURL,
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
    headers: {
      'Accept': Headers.jsonContentType,
      'X-CMC_PRO_API_KEY': Env.key
    },
    // queryParameters: {
    //   'api_key': Env.apiKey
    // }
  );

  void clearInterceptors() {
    _dio.interceptors.clear();

    _dio.interceptors.addAll([
      LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        logPrint: _printLog,
      ),
    ]);
  }

  _printLog(Object object) => _log.fine(object.toString());

  @override
  Future<dynamic> getHttp(
      {required String route, Map<String, dynamic>? query}) async {
    clearInterceptors();
    Response response;

    _log.fine('Sending GET to $route');

    try {
      final fullRoute = route;
      const r = RetryOptions(maxAttempts: 8);
      response = await r.retry(
        // Make a GET request
        () => _dio
            .get(fullRoute, queryParameters: query)
            .timeout(const Duration(seconds: 5)),
        // Retry on SocketException or TimeoutException
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } on DioError catch (e) {
      _log.severe('HttpService: Failed to GET ${e.message}');
      throw NetworkException(e.message);
    }

    network_utils.checkForNetworkExceptions(response);

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  Future<dynamic> postHttp(String route, dynamic body) async {
    clearInterceptors();
    Response response;

    _log.fine('Sending $body to $route');

    try {
      final fullRoute = route;
      const r = RetryOptions(maxAttempts: 8);
      response = await r.retry(
        // Make a GET request
        () => _dio
            .post(
              fullRoute,
              data: body,
              onSendProgress: network_utils.showLoadingProgress,
              onReceiveProgress: network_utils.showLoadingProgress,
              options: Options(
                contentType: 'application/json',
              ),
            )
            .timeout(const Duration(seconds: 5)),
        // Retry on SocketException or TimeoutException
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } on DioError catch (e) {
      _log.severe('HttpService: Failed to POST ${e.message}');
      throw NetworkException(e.message);
    }

    network_utils.checkForNetworkExceptions(response);

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  Future<dynamic> postHttpForm(
    String route,
    Map<String, dynamic> body,
    List<File> files,
  ) async {
    clearInterceptors();
    var index = 0;

    final formData = FormData.fromMap(body);
    for (var file in files) {
      final mFile = await _fileHelper.convertFileToMultipartFile(file);
      formData.files.add(MapEntry('file$index', mFile));
      index++;
    }

    final data = await postHttp(route, formData);

    return data;
  }

  @override
  Future<File> downloadFile(String fileUrl) async {
    clearInterceptors();
    Response response;

    final file = await _fileHelper.getFileFromUrl(fileUrl);

    try {
      const r = RetryOptions(maxAttempts: 8);
      response = await r.retry(
        // Make a GET request
        () => _dio
            .download(
              fileUrl,
              file.path,
              onReceiveProgress: network_utils.showLoadingProgress,
            )
            .timeout(const Duration(seconds: 5)),
        // Retry on SocketException or TimeoutException
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } on DioError catch (e) {
      _log.severe('HttpService: Failed to download file ${e.message}');
      throw NetworkException(e.message);
    }

    network_utils.checkForNetworkExceptions(response);

    return file;
  }

  @override
  void dispose() {
    _dio.clear();
    _dio.close(force: true);
  }
}
