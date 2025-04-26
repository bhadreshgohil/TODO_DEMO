import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class WebService {
  WebService();

  static final _instance = WebService();

  static WebService get instance => _instance;
  final _dio = Dio();

  request({required NetworkRequest request}) async {





    try {
      final response = await _dio.request(
          request.url,
          queryParameters: request.queryParameters,
          data: request.data,
          options: Options(
              method: request.method.value,
              // headers: {
              //
              //   "Authorization" : "Bearer ${SecureStorage.token}"
              //
              // }
          ));



      final responseData = response.data;




      if (kDebugMode) {
        log(request.toResponseString(responseData));
      }

      // if(responseData["status_code"] == 0) {
      //   throw responseData["message"];
      // }



      return responseData;

    } on DioException catch (e) {

      print("ERROR IS ${e.response}");
      throw decodeErrorResponse(error: e, request: request);

    }
    }

  }
class NetworkRequest {
  final String url;
  final Map<String, dynamic>? queryParameters;
  final dynamic data;

  NetworkMethod method = NetworkMethod.post;

  NetworkRequest({required this.url, this.queryParameters, this.data, NetworkMethod? method}) : method = method ?? NetworkMethod.post;

  String toErrorString(DioException error) {
    return "error is $error";
  }

  String toResponseString(dynamic response){
    var log = "{'body':$data,'url':'$url','queryParameters':'queryParameters'}";
    return "$log/response : $response";

  }

}

enum NetworkMethod {
  get(value: "GET"),
  post(value: "POST");

  const NetworkMethod({required this.value});

  final String value;
}

decodeErrorResponse({required DioException error, required NetworkRequest request}) {



  if (kDebugMode) {
    log(request.toErrorString(error));
  }
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      throw 'Connection timeOut';
    case DioExceptionType.sendTimeout:
    // TODO: Handle this case.
      break;
    case DioExceptionType.receiveTimeout:
      throw 'Connection timeOut';
    case DioExceptionType.badCertificate:
      throw 'Connection timeOut';
    case DioExceptionType.badResponse:
      throw 'Something went wrong.';
    case DioExceptionType.cancel:
      throw 'Request Canceled by user';
    case DioExceptionType.connectionError:
      throw 'Something went wrong.';
    case DioExceptionType.unknown:

      if((error.message ?? "").contains("SocketException") || (error.error) is SocketException){
        throw "Internet connection not available";
      } else {
        throw "Something went wrong.";
      }

  }
}

