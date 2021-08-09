import 'dart:async';

import 'package:cruise/src/common/auth.dart';
import 'package:cruise/src/common/utils/navigation_service.dart';
import 'package:cruise/src/models/api/login_type.dart';
import 'package:cruise/src/models/api/response_status.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wheel/wheel.dart' show AppLogHandler, RestClient;

import '../../config/cruise_global_config.dart';
import 'http_result.dart';

class AppInterceptors extends InterceptorsWrapper {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!options.headers.containsKey("accessToken")) {
      String? accessToken = await storage.read(key: "accessToken");
      options.headers["accessToken"] = accessToken;
    }
    handler.next(options);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    Response handleResponse = await autoLogin(response);
    Response handleAccessToken = await handleResponseByCode(handleResponse);
    return super.onResponse(handleAccessToken, handler);
  }

  Future<Response> handleRefreshTokenExpired(Response response) async {
    String accessExpiredCode = ResponseStatus.ACCESS_TOKEN_EXPIRED.statusCode;
    String statusCode = response.data["statusCode"];
    if (accessExpiredCode == statusCode) {
      String? phone = await storage.read(key: "username");
      String? password = await storage.read(key: "password");
      if (phone == null || password == null) {
        return response;
      }
      AuthResult result = await Auth.refreshRefreshToken(phone: phone, password: password);
      if (result.result == Result.ok) {
        Dio dio = RestClient.createDio();
        return _retryResponse(response, dio);
      } else {
        AppLogHandler.logErrorException("refresh refresh token failed", result);
      }
    }
    return response;
  }

  Future<Response> handleResponseByCode(Response response) async {
    String statusCode = response.data["resultCode"];
    if (statusCode == ResponseStatus.ACCESS_TOKEN_EXPIRED.statusCode) {
      return handleAccessTokenExpired(response);
    }
    if (statusCode == ResponseStatus.ACCESS_TOKEN_INVALID.statusCode) {
      NavigationService.instance.navigationKey.currentState!
          .pushNamedAndRemoveUntil("login", ModalRoute.withName("/"));
    }
    return response;
  }

  Future<Response> handleAccessTokenExpired(Response response) async {
    String? refreshToken = await storage.read(key: "refreshToken");
    if (refreshToken == null) {
      return response;
    }
    AuthResult result = await Auth.refreshAccessToken(refreshToken: refreshToken);
    if (result.result == Result.ok) {
      Dio dio = RestClient.createDio();
      return _retryResponse(response, dio);
    } else {
      AppLogHandler.logErrorException("refresh access token failed", result);
    }
    return response;
  }

  Future<Response> autoLogin(Response response) async {
    String loginInvalidCode = ResponseStatus.LOGIN_INVALID.statusCode;
    String notLoginCode = ResponseStatus.NOT_LOGIN.statusCode;
    String statusCode = response.data["statusCode"];
    if (statusCode == loginInvalidCode || statusCode == notLoginCode) {
      String? userName = await storage.read(key: "username");
      String? password = await storage.read(key: "password");
      /**
       * the refresh time record the refresh request count
       * to avoid a dead loop of refresh token
       */
      String? tokenRefreshTimes = await storage.read(key: "refreshTimes");
      if (userName != null && password != null && tokenRefreshTimes != null && int.parse(tokenRefreshTimes) < 3) {
        String newRefreshTimes = (int.parse(tokenRefreshTimes) + 1).toString();
        storage.write(key: "refreshTimes", value: newRefreshTimes);
        Future<Response> res = refreshAuthToken(userName, password, response);
        res.whenComplete(() => {}).then((value) => {
              if (RestClient.respSuccess(response)) {storage.write(key: "refreshTimes", value: "0")}
            });
        return res;
      } else {
        //NavigationService.instance.navigateToReplacement("login");
        /**
         * if login invalid
         * jump to the login page
         * it will clear all page except / page
         */
        NavigationService.instance.navigationKey.currentState!
            .pushNamedAndRemoveUntil("login", ModalRoute.withName("/"));
        return response;
      }
    } else {
      return response;
    }
  }

  Future<Response> _retryResponse(Response response, Dio dio) async {
    // replace the new token
    String? accessToken = await storage.read(key: "accessToken");
    response.requestOptions.headers["accessToken"] = accessToken;
    final options = new Options(
      method: response.requestOptions.method,
      headers: response.requestOptions.headers,
    );
    return dio.request<dynamic>(response.requestOptions.path,
        data: response.requestOptions.data, queryParameters: response.requestOptions.queryParameters, options: options);
  }

  Future<Response> refreshAuthToken(String userName, String password, Response response) async {
    Dio dio = RestClient.createDio();
    dio.lock();
    try {
      AuthResult result = await Auth.login(username: userName, password: password, loginType: LoginType.PHONE);
      if (result.result == Result.ok) {
        // resend a request to fetch data
        return _retryResponse(response, dio);
      } else {
        return response;
      }
    } on Exception catch (e) {
      AppLogHandler.logErrorException("登录失败", e);
      return response;
    } finally {
      dio.unlock();
    }
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }
}
