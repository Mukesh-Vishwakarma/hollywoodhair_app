import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'DioLogger.dart';
import 'api_constants.dart';

class ApiProvider {
  Dio _dio = Dio();
  DioError? _dioError;

  ApiProvider.base() {
    BaseOptions dioOptions = BaseOptions()..baseUrl = baseUrl;
    _dio = Dio(dioOptions);
    _dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      options.headers = {'Content-Type': 'application/json'};
      DioLogger.onSend(tag, options);
      return handler.next(options);
    }, onResponse: (Response response, handler) {
      DioLogger.onSuccess(tag, response);
      return handler.next(response);
    }, onError: (DioError error, handler) {
      _dioError = error;
      DioLogger.onError(tag, error);
      if (_checkSocketException(error)) {
        // failedToast('Internet connection failed');
      }
      return handler.next(error);
    }));
  }

  // for token
  ApiProvider.baseWithToken() {
    BaseOptions dioOptions = BaseOptions()..baseUrl = baseUrl;
    _dio = Dio(dioOptions);
    _dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      String accessToken = GetStorage().read(AppConstants.accessToken);
      options.headers = {'Content-Type': 'application/json'};
      options.headers = {'token': accessToken};
      DioLogger.onSend(tag, options);
      return handler.next(options);
    }, onResponse: (Response response, handler) {
      DioLogger.onSuccess(tag, response);
      return handler.next(response);
    }, onError: (DioError error, handler) {
      _dioError = error;
      DioLogger.onError(tag, error);
      return handler.next(error);
    }));
  }

// for multipart
  ApiProvider.baseWithMultipart() {
    BaseOptions dioOptions = BaseOptions()..baseUrl = baseUrl;
    _dio = Dio(dioOptions);
    _dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      String accessToken = GetStorage().read(AppConstants.accessToken);
      options.headers = {'Content-Type': 'multipart/form-data'};
      options.headers = {'x-access-token': accessToken};
      DioLogger.onSend(tag, options);
      return handler.next(options);
    }, onResponse: (Response response, handler) {
      DioLogger.onSuccess(tag, response);
      return handler.next(response);
    }, onError: (DioError error, handler) {
      _dioError = error;
      DioLogger.onError(tag, error);
      return handler.next(error);
    }));
  }

   bool _checkSocketException(DioError err) {
    return err.type == DioErrorType.unknown &&
        err.error != null &&
        err.error is SocketException;
  }


}
