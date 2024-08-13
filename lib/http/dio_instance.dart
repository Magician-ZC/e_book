import 'package:dio/dio.dart';
import 'package:e_book/http/http_methods.dart';
import 'package:e_book/http/print_log_interceptor.dart';
import 'package:e_book/http/response_interceptor.dart';

class DioInstance {
  static DioInstance? _instance;

  DioInstance._();

  static DioInstance instance() {
    return _instance ??= DioInstance._();
  }

  final Dio _dio = Dio();
  final _defaultTimeout = const Duration(seconds: 30);

  void initDio(
      {String? httpMethod = HttpMethods.get,
      Duration? connectTimeout,
      Duration? receiveTimeout,
      Duration? sendTimeout,
      ResponseType? responseType = ResponseType.json,
      String? contentTYpe}) {
    _dio.options = BaseOptions(
      method: httpMethod,
      connectTimeout: connectTimeout ?? _defaultTimeout,
      receiveTimeout: receiveTimeout ?? _defaultTimeout,
      sendTimeout: sendTimeout ?? _defaultTimeout,
      responseType: responseType ?? ResponseType.json,
      contentType: contentTYpe ?? 'application/json; charset=utf-8',
    );
    _dio.interceptors.add(ResponseInterceptor());
    _dio.interceptors.add(PrintLogInterceptor());
  }

  /// get方法，获取JSON数据
  Future<Response> get({
    required String path,
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.get(path,
        queryParameters: params,
        data: data,
        cancelToken: cancelToken,
        options: options ??
            Options(
              method: HttpMethods.get,
              receiveTimeout: _defaultTimeout,
              sendTimeout: _defaultTimeout,
            ));
  }

  /// getString方法，获取HTML数据
  Future<String> getString({
    required String path,
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Response res = await _dio.get(path,
        queryParameters: params,
        data: data,
        cancelToken: cancelToken,
        options: options ??
            Options(
              method: HttpMethods.get,
              receiveTimeout: _defaultTimeout,
              sendTimeout: _defaultTimeout,
            ));
    return res.data.toString();
  }

  ///post请求
  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.get(path,
        queryParameters: params,
        data: data,
        cancelToken: cancelToken,
        options: options ??
            Options(
              method: HttpMethods.post,
              receiveTimeout: _defaultTimeout,
              sendTimeout: _defaultTimeout,
            ));
  }
}
