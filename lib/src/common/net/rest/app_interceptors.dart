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
    if (!options.headers.containsKey("token")) {
      String? token = await storage.read(key: "token");
      options.headers["token"] = token;
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
    String loginInvalidCode = ResponseStatus.LOGIN_INVALID.statusCode;
    String notLoginCode = ResponseStatus.NOT_LOGIN.statusCode;
    String statusCode = response.data["statusCode"];
    if (statusCode == loginInvalidCode || statusCode == notLoginCode) {
      Dio dio = RestClient.createDio();
      String? userName = await storage.read(key: "username");
      String? password = await storage.read(key: "password");
      if (userName != null && password != null) {
        refreshAuthToken(dio, userName, password, response);
      } else {
        NavigationService.instance.navigateToReplacement("login");
      }
    }
  }

  void refreshAuthToken(Dio dio, String userName, String password, Response response) async {
    dio.lock();
    try {
      AuthResult result = await Auth.login(username: userName, password: password, loginType: LoginType.PHONE);
      if (result.result == Result.ok) {
        // resend a request to fetch data
        //Dio req = RestClient.createDio();
        dio.request(response.requestOptions.path);
      }
    } on Exception catch (e) {
      CruiseLogHandler.logErrorException("登录失败", e);
    } finally {
      dio.unlock();
    }
  }
}
