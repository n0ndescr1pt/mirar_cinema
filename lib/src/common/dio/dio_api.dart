import 'dart:async';
import 'package:dio/dio.dart';
import 'package:mirar/src/common/dio/dio_exceptions.dart';
import 'package:mirar/src/resources/constants.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ApiProvider {
  //final Talker _talker;
  final Dio _dio;

  ApiProvider({required Talker talker})
      : // _talker = talker,
        _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          receiveTimeout: const Duration(seconds: 20),
          connectTimeout: const Duration(seconds: 20),
          sendTimeout: const Duration(seconds: 20),
        )) {
    //_dio.interceptors.add(
    //  TalkerDioLogger(
    //    talker: _talker,
    //    settings: const TalkerDioLoggerSettings(
    //      printRequestHeaders: false,
    //      printResponseHeaders: false,
    //      printResponseMessage: false,
    //    ),
    //  ),
    //);

    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) {
        _handleError(e);
        return handler.next(e);
      },
      onRequest: (options, handler) {
        _handleRequest(options);
        return handler.next(options);
      },
    ));
  }

  Future<Response<dynamic>> apiCall(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body,
      Options? options,
      required RequestType requestType}) async {
    late Response response;
    try {
      switch (requestType) {
        case RequestType.get:
          {
            response = await _dio.get(url,
                queryParameters: queryParameters, options: options);
            break;
          }
        case RequestType.post:
          {
            response = await _dio.post(url, data: body, options: options);
            break;
          }
        case RequestType.delete:
          {
            response = await _dio.delete(url,
                queryParameters: queryParameters, options: options);
            break;
          }
        case RequestType.put:
          {
            response = await _dio.put(url, data: body, options: options);
            break;
          }
      }
      return response;
    } catch (error) {
      if (error is Exception) {
        rethrow;
      } else {
        throw Exception("Unexpected error: $error");
      }
    }
  }

  void _handleRequest(RequestOptions options) {
    options.headers.addAll({
      'accept': 'application/json',
      'X-API-KEY': kinopoiskApiKey,
    });
  }

  static void _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException(e.requestOptions.toString());
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(e.requestOptions);
      case DioExceptionType.badCertificate:
        throw BadCertificateException(e.requestOptions);
      case DioExceptionType.connectionError:
        throw InternalServerErrorException(e.requestOptions);
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400:
            throw BadRequestException(
                e.requestOptions, e.response?.data['code']);
          case 401:
            throw UnauthorizedException(e.requestOptions);
          case 404:
            throw NotFoundException(e.requestOptions);
          case 409:
            throw ConflictException(e.requestOptions);
          case 500:
            throw InternalServerErrorException(e.requestOptions);
        }
    }
  }
}

enum RequestType { get, post, put, delete }
