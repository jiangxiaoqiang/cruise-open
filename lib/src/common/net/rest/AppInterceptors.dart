import 'dart:async';

import 'package:Cruise/src/common/auth.dart';
import 'package:Cruise/src/common/net/rest/rest_clinet.dart';
import 'package:Cruise/src/models/api/response_status.dart';
import 'package:dio/dio.dart';

import '../../global.dart';
import 'http_result.dart';

class AppInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    if (!options.headers.containsKey("token")) {
      String token = await storage.read(key: "token");
      options.headers["token"] = token;
      return options;
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) async {
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) async {
    if (err.response != null && err.response.data["statusCode"] == ResponseStatus.NOT_LOGIN.statusCode) {
      Dio dio = RestClient.createDio();
      dio.lock();
      AuthResult result = await Auth.login(
        username: await storage.read(key: "username"),
        password: await storage.read(key: "password"),
      );
      if (result.result == Result.ok) {
        // resend a request to fetch data
        Dio req = RestClient.createDio();
        req.request(err.request.path);
      }
      dio.unlock();
    }
    return super.onError(err);
  }
}
