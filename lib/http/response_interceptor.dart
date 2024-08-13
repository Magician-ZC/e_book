import 'package:dio/dio.dart';
import 'package:e_book/utils/toast_utils.dart';
import 'package:flutter/material.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = "请检查网络";
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      errorMessage = "网络连接超时，请检查网络连接";
    } else if (err.type == DioExceptionType.badResponse) {
      errorMessage = "服务器异常";
    } else if (err.type == DioExceptionType.cancel) {
      errorMessage = "网络请求取消";
    } else if (err.type == DioExceptionType.badCertificate) {
      errorMessage = "证书错误";
    } else if (err.response?.statusCode == 404) {
      errorMessage = "请求的资源不存在";
    } else if (err.type == DioExceptionType.unknown) {
      errorMessage = "未知错误，请重试";
    }

    debugPrint(errorMessage);
    ToastUtils.showErrorMsg(errorMessage);
    return handler.next(err);
  }
}
