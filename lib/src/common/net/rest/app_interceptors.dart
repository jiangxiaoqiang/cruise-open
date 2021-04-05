import 'dart:async';

import 'package:cruise/src/common/auth.dart';
import 'package:cruise/src/common/net/rest/rest_clinet.dart';
import 'package:cruise/src/models/api/login_type.dart';
import 'package:cruise/src/models/api/response_status.dart';
import 'package:dio/dio.dart';

import '../../global.dart';
import 'http_result.dart';

class AppInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    if (!options.headers.containsKey("token")) {
      String? token = await storage.read(key: "token");
      options.headers["token"] = token;
      return options;
    }
    return super.onRequest(options,handler);
  }

  @override
  Future onResponse(Response response,ResponseInterceptorHandler handler) async {
    autoLogin(response);
    return super.onResponse(response,handler);
  }

  @override
  Future onError(DioError err,ErrorInterceptorHandler handler) async {
    return super.onError(err,handler);
  }

  void autoLogin(Response response) async {
    if (response.data["statusCode"] == ResponseStatus.NOT_LOGIN.statusCode) {
      Dio dio = RestClient.createDio();
      dio.lock();
      String? userName = await storage.read(key: "username");
      String? password = await storage.read(key: "password");
      if (userName != null && password != null) {
        refreshAuthToken(dio, userName, password, response);
      }
    }
  }

  void refreshAuthToken(Dio dio, String userName, String password, Response response) async {
    AuthResult result = await Auth.login(
      username: userName,
      password: password,
      loginType: LoginType.PHONE
    );
    if (result.result == Result.ok) {
      dio.unlock();
      // resend a request to fetch data
      Dio req = RestClient.createDio();
      req.request(response.requestOptions.path);
    }
  }
}
