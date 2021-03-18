import 'package:Cruise/src/common/net/rest/app_interceptors.dart';
import 'package:dio/dio.dart';

import '../../global.dart';

class RestClient {
  static Dio dioInstance = Dio(BaseOptions(connectTimeout: 30000, receiveTimeout: 30000, baseUrl: "$baseUrl"));

  static Dio createDio() {
    return addInterceptors(dioInstance);
  }

  static Dio addInterceptors(Dio dio) {
    return dio..interceptors.add(AppInterceptors());
  }

  static Future<Response> postHttp(String path, Object data) async {
    final url = "$baseUrl" + path;
    Dio dio = createDio();
    Response response = await dio.post(url, data: data);
    return response;
  }

  static Future<Response> putHttp(String path, Object? data) async {
    final url = "$baseUrl" + path;
    Dio dio = createDio();
    Response response = await dio.put(url, data: data);
    return response;
  }

  static Future<Response> getHttp(String path) async {
    final url = "$baseUrl" + path;
    Dio dio = createDio();
    Response response = await dio.get(url);
    return response;
  }

  static bool respSuccess(Response response) {
    return response.statusCode == 200 && response.data["statusCode"] == "200";
  }
}
