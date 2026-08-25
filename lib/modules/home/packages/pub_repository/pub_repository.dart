import 'package:dio/dio.dart';

class PackagePubRepository {
  final Dio _dio;

  PackagePubRepository({
    Dio? dio,
  }) : _dio = dio ??
      Dio(
        BaseOptions(
          baseUrl: 'https://pub.dev/api',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

  Future<Map<String, dynamic>> getPackageInfo(
      String packageName,
      ) async {
    final response = await _dio.get(
      '/packages/$packageName',
    );

    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> getPackageScore(
      String packageName,
      ) async {
    final response = await _dio.get(
      '/packages/$packageName/score',
    );

    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> getPublisher(
      String packageName,
      ) async {
    final response = await _dio.get(
      '/packages/$packageName/publisher',
    );

    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> getCompletePackage(
      String packageName,
      ) async {
    final results = await Future.wait([
      getPackageInfo(packageName),
      getPackageScore(packageName),
      getPublisher(packageName),
    ]);

    return {
      'info': results[0],
      'score': results[1],
      'publisher': results[2],
    };
  }
}