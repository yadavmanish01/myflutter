import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../data/app_exceptions.dart';
import 'baseApiServices.dart';


class NetworkApiService implements BaseApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    ),
  );

  @override
  Future<dynamic> GetApi(
      String url, {
        Map<String, dynamic>? headers,
        ResponseType responseType = ResponseType.json,
      }) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: headers,
          responseType: responseType,
        ),
      );

      return returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> PostApi(String url, dynamic data) async {
    if (kDebugMode) {
      print("POST => $url");
      print(data);
    }

    try {
      final response = await _dio.post(
        url,
        data: data,
      );

      if (kDebugMode) {
        print(response.data);
      }

      return returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  dynamic returnResponse(Response response) {
    if (kDebugMode) {
      print("Status Code : ${response.statusCode}");
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;

      case 400:
        return response.data;

      case 401:
        throw BadRequestException(response.data.toString());

      case 404:
      case 500:
        throw UnauthorisedException(response.data.toString());

      default:
        throw FetchDataException(
          'Error occurred while communicating with server',
        );
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return FetchDataException('Network Request time out');

      case DioExceptionType.connectionError:
        return NoInternetException('No Internet Connection');

      case DioExceptionType.badResponse:
        if (e.response != null) {
          return FetchDataException(e.response!.data.toString());
        }
        return FetchDataException('Something went wrong');

      default:
        return FetchDataException(e.message ?? 'Something went wrong');
    }
  }
}