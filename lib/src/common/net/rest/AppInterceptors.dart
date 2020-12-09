import 'dart:async';
import 'package:Cruise/src/common/auth.dart';
import 'package:Cruise/src/models/api/response_status.dart';
import 'package:dio/dio.dart';
import '../../global.dart';
import 'http_result.dart';

class AppInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async{
    if (!options.headers.containsKey("token")) {
      String token = await storage.read(key: "token");
      options.headers["token"] = token;
      return options;
    }
    return super.onRequest(options);
  }
  @override
  Future onResponse(Response response) async{
    if(response.data["statusCode"] == ResponseStatus.NOT_LOGIN.statusCode){
      AuthResult result = await Auth.login(
        username:await storage.read(key:"username"),
        password: await storage.read(key:"password"),
      );

      if (result.result == Result.error) {

      }
    }
    return super.onResponse(response);
  }
  @override
  Future onError(DioError err) {
    print("ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    return super.onError(err);
  }

}