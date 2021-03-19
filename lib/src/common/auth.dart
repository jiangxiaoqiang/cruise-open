import 'package:cruise/src/common/net/rest/rest_clinet.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cruise/src/common/global.dart' as global;
import 'global.dart';
import 'net/rest/http_result.dart';

class AuthResult {
  String message;
  Result result;

  AuthResult({
    required this.message,
    required this.result,
  });
}

class Auth {
  static const baseUrl = global.baseUrl;
  static RegExp validationRequired = RegExp(r"Validation required");

  static Future<bool> isLoggedIn() async {
    final storage = new FlutterSecureStorage();
    String? username = await storage.read(key: "username");
    return false;
  }

  static Future<String?> currentUser() async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: "username");
  }

  static Future<AuthResult> vote({required String itemId}) async {
    Map body = {
      "id": itemId
    };
    final response = await RestClient.putHttp("/post/article/upvote",body);
    if (RestClient.respSuccess(response)) {
      return AuthResult(message: "SMS send success", result: Result.ok);
    } else {
      return AuthResult(
          message: "SMS send failed. Did you mistype your credentials?",
          result: Result.error);
    }
  }

  static Future<bool> logout() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: "username");
    await storage.delete(key: "password");
    return true;
  }

  static Future<AuthResult> sms({required String phone}) async {
    Map body = {
      "phone": phone
    };
    final response = await RestClient.postHttp("/post/user/sms",body);
    if (RestClient.respSuccess(response)) {
      final storage = new FlutterSecureStorage();
      await storage.write(key: "phone", value: phone);
      return AuthResult(message: "SMS send success", result: Result.ok);
    } else {
      return AuthResult(
          message: "SMS send failed. Did you mistype your credentials?",
          result: Result.error);
    }
  }

  static Future<AuthResult> setPwd({required String phone, required String password}) async {
    Map body = {
      "phone": phone,
      "password": password,
      "goto": 'news',
    };
    final response = await RestClient.postHttp("/post/user/set/pwd",body);
    if (RestClient.respSuccess(response)) {
      final storage = new FlutterSecureStorage();
      await storage.write(key: "username", value: phone);
      await storage.write(key: "password", value: password);
      return AuthResult(message: "Login success", result: Result.ok);
    }  else {
      return AuthResult(
          message: "Login failed. Did you mistype your credentials?",
          result: Result.error);
    }
  }

  static Future<AuthResult> verifyPhone({required String phone, required String verifyCode}) async {
    Map body = {
      "phone": phone,
      "verifyCode": verifyCode,
      "goto": 'news',
    };
    final response = await RestClient.postHttp("/post/user/verify",body);
    if (RestClient.respSuccess(response)) {
      final storage = new FlutterSecureStorage();
      await storage.write(key: "phone", value: phone);
      await storage.write(key: "verifyCode", value: verifyCode);
      return AuthResult(message: "Login success", result: Result.ok);
    } else {
      return AuthResult(
          message: "Login failed. Did you mistype your credentials?",
          result: Result.error);
    }
  }

  static Future<AuthResult> login({required String username, required String password}) async {
    Map body = {
      "phone": username,
      "password": password,
      "goto": 'news',
    };
    final response = await RestClient.postHttp("/post/user/login",body);
    if (RestClient.respSuccess(response)) {
      Map result = response.data["result"];
      String token = result["token"];
      await storage.write(key: "username", value: username);
      await storage.write(key: "password", value: password);
      await storage.write(key: "token", value: token);
      return AuthResult(message: "Login success", result: Result.ok);
    } else {
      return AuthResult(
          message: "Login failed. Did you mistype your credentials?",
          result: Result.error);
    }
  }
}
