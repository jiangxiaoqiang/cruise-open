import 'dart:async';

import 'package:cruise/src/common/auth.dart';
import 'package:cruise/src/common/log/cruise_log_handler.dart';
import 'package:cruise/src/common/net/rest/rest_clinet.dart';
import 'package:cruise/src/common/utils/navigation_service.dart';
import 'package:cruise/src/models/api/login_type.dart';
import 'package:cruise/src/models/api/response_status.dart';
import 'package:dio/dio.dart';

import '../../config/global_config.dart';
import 'http_result.dart';

class AppInterceptors extends InterceptorsWrapper {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      if (!options.headers.containsKey("token")) {
        String? token = await storage.read(key: "token");
        options.headers["token"] = token;
      }
    } on Exception catch (e) {
      CruiseLogHandler.logErrorException('interceptor error', e);
    }
    handler.next(options);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    autoLogin(response);
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }

  void autoLogin(Response response) async {
    if (ResponseStatus.NOT_LOGIN.statusCode == response.data["statusCode"]) {
      NavigationService.instance.navigateToReplacement("login");
      return;
    }
    String code = ResponseStatus.LOGIN_INVALID.statusCode;
    String statusCode = response.data["statusCode"];
    if (statusCode == code) {
      Dio dio = RestClient.createDio();
      String? userName = await storage.read(key: "username");
      String? password = await storage.read(key: "password");
      if (userName != null && password != null) {
        refreshAuthToken(dio, userName, password, response);
      }
    }
  }

  void refreshAuthToken(Dio dio, String userName, String password, Response response) async {
    AuthResult result = await Auth.login(username: userName, password: password, loginType: LoginType.PHONE);
    if (result.result == Result.ok) {
      // resend a request to fetch data
      Dio req = RestClient.createDio();
      req.request(response.requestOptions.path);
    }
  }
}
