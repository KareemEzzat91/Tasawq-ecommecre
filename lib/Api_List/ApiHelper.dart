import 'package:dio/dio.dart';
import 'package:ecommerce/Api_List/KAPI.dart';
class Apihelper {
  static Dio? _dio;

  Apihelper._();

  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Kapi.BaseURL,
        receiveTimeout: const Duration(
          seconds: 60,
        ),
        headers: {
          "lang": "en",
          "Content-Type": "application/json",
        },
      ),
    );
  }

  //Get
  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = _dio!.get(path, queryParameters: queryParameters);
    return response;
  }

  //Post
  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = _dio!.post(
      path,
      queryParameters: queryParameters,
      data: body,
    );
    return response;
  }

  //Put
  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = _dio!.put(
      path,
      queryParameters: queryParameters,
      data: body,
    );
    return response;
  }

  //Delete
  static Future<Response> deleteData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = _dio!.delete(
      path,
      queryParameters: queryParameters,
      data: body,
    );
    return response;
  }
}