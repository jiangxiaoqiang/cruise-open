import 'dart:async';

import 'package:cruise/src/common/auth.dart';
import 'package:cruise/src/common/net/rest/rest_clinet.dart';
import 'package:cruise/src/models/api/response_status.dart';
import 'package:dio/dio.dart';

import '../../global.dart';
import 'http_result.dart';

class AppInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    if (!options.headers.containsKey("token")) {
      String? token = await storage.read(key: "token");
      options.headers["token"] = token;
      return options;
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) async {
    autoLogin(response);
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) async {
    //autoLogin(err.response);
    return super.onError(err);
  }

  void autoLogin(Response response) async {
    if (response.data["statusCode"] == ResponseStatus.NOT_LOGIN.statusCode) {
      Dio dio = RestClient.createDio();
      dio.lock();
      String? userName = await storage.read(key: "username");
      String? password = await storage.read(key: "password");
      if (userName != null && password != null) {
        refreshAuthToken(userName, password, response);
      }
      dio.unlock();
    }
  }

  void refreshAuthToken(String userName, String password, Response response) async {
    AuthResult result = await Auth.login(
      username: userName,
      password: password,
    );
    if (result.result == Result.ok) {
      // resend a request to fetch data
      Dio req = RestClient.createDio();
      req.request(response.request.path);
    }
  }
}
