import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';


import '../../.,/../../core/api/errors/custom_error.dart';

import '../core_models/base_response_model.dart';
import '../core_models/base_result_model.dart';
import '../errors/bad_request_error.dart';
import '../errors/base_error.dart';
import '../errors/cancel_error.dart';
import '../errors/conflict_error.dart';
import '../errors/forbidden_error.dart';
import '../errors/http_error.dart';
import '../errors/internal_server_error.dart';
import '../errors/net_error.dart';
import '../errors/not_found_error.dart';
import '../errors/socket_error.dart';
import '../errors/timeout_error.dart';
import '../errors/unauthorized_error.dart';
import '../errors/unknown_error.dart';

class ApiProvider {
  static Future<BaseResponseModel>
      sendObjectRequest<T extends BaseResultModel>({
    required T Function(Map<String, dynamic>) converter,
    required String method,
    required String url,
    Map<String, dynamic>? data,
    required Map<String, String> headers,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? files,
    CancelToken? cancelToken,
    bool isLongTime = false,
    bool uploadNotification = false,
    bool downloadNotification = false,
    bool isLaravel = false,
    int retries = 0,
  }) async {
    if (uploadNotification) downloadNotification = false;
    if (downloadNotification) uploadNotification = false;
    var baseOptions = BaseOptions(
      connectTimeout: Duration( seconds: isLongTime ? 60  : 15 ),
    );
    var dio = Dio();

    dio.options = baseOptions;

    Options options = Options(
      headers: headers,
      method: method,
      contentType: Headers.jsonContentType,
      sendTimeout: Duration( seconds: files == null ? 4 : 600),
    );

    if (files != null) {

      data ??= {};

      await Future.forEach(files.entries, (MapEntry entry) async {
        if (entry.value != null) {
          data!.addAll({
            entry.key: await MultipartFile.fromFile(entry.value,
                filename: entry.value, contentType: MediaType("image", "jpeg"))
          });
        }
      });
    }
    try {
      Response response;
      response = await dio.request(url,
          queryParameters: queryParameters,
          options: options,

          data: files != null ? FormData.fromMap(data!) : data);

      // Get the decoded json
      dynamic decodedJson;

      if (response.data is String) {
        if (response.data.length == 0) {
          decodedJson = {"": ""};
        } else {
          decodedJson = json.decode(response.data);
        }
      } else {
        decodedJson = response.data;
      }

      return BaseResponseModel.fromJson(
          json: decodedJson, fromJson: converter, isLaravel: isLaravel);
    }

    // Handling errors
    on DioError catch (e) {
      var error = _handleDioError(e);
      dynamic json;
      if (e.response != null) {
        if (e.response!.data != null) {
          if (e.response!.data is! String) {
            json = e.response!.data;
          }
        }
      }

      return BaseResponseModel.fromJson(
          json: json, error: error, isLaravel: isLaravel);
    }

    // Couldn't reach out the server
    on SocketException catch (e) {
      return BaseResponseModel.fromJson(
          error: SocketError(), isLaravel: isLaravel);
    } catch (e, s) {
      print(e);
      print(s);
      return BaseResponseModel.fromJson(
          error: CustomError(message: 'parse error'),
          isLaravel: isLaravel);
    }
  }

  static BaseError _handleDioError(DioError error) {
    if (error.type == DioErrorType.cancel ||
        error.type == DioErrorType.badResponse) {
      if (error is SocketException) return SocketError();
      if (error.type == DioErrorType.badResponse) {
        switch (error.response?.statusCode ?? 400) {
          case 400:
            return BadRequestError();
          case 401:
            return UnauthorizedError();
          case 403:
            return ForbiddenError();
          case 404:
            return NotFoundError();
          case 409:
            return ConflictError();
          case 500:
            return InternalServerError();

          default:
            return HttpError();
        }
      }
      return NetError();
    } else if (error.type == DioErrorType.connectionTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      return TimeoutError();
    } else if (error.type == DioErrorType.cancel) {
      return CancelError();
    } else {
      return UnknownError();
    }
  }
}
