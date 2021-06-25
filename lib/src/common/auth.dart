import 'package:cruise/src/common/config/global_config.dart' as global;
import 'package:cruise/src/common/net/rest/rest_clinet.dart';
import 'package:cruise/src/common/utils/common_utils.dart';
import 'package:cruise/src/common/utils/navigation_service.dart';
import 'package:cruise/src/models/api/login_type.dart';
import 'package:cruise/src/models/api/response_status.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:wheel/wheel.dart' show SecureStorageUtil;

import 'config/global_config.dart';
import 'cruise_user.dart';
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
  final baseUrl = global.baseUrl;
  static RegExp validationRequired = RegExp(r"Validation required");

  static Future<bool> isLoggedIn() async {
    final storage = new FlutterSecureStorage();
    String? username = await storage.read(key: "username");
    if (username == null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<CruiseUser> currentUser() async {
    final storage = new FlutterSecureStorage();
    String? userName = await storage.read(key: "username");
    String? registerTime = await storage.read(key: "registerTime");
    CruiseUser user = new CruiseUser(phone: userName, registerTime: registerTime);
    return user;
  }

  static Future<AuthResult> vote({required String itemId}) async {
    Map body = {"id": itemId};
    final response = await RestClient.putHttp("/post/article/upvote", body);
    if (RestClient.respSuccess(response)) {
      return AuthResult(message: "SMS send success", result: Result.ok);
    } else {
      return AuthResult(message: "SMS send failed. Did you mistype your credentials?", result: Result.error);
    }
  }

  static Future<bool> logout() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: "username");
    await storage.delete(key: "password");
    await storage.delete(key: "registerTime");
    await storage.delete(key: "accessToken");
    await storage.delete(key: "freshToken");
    return true;
  }

  static Future<AuthResult> sms({required String phone}) async {
    Map body = {"phone": phone};
    final response = await RestClient.postHttp("/post/user/sms", body);
    if (RestClient.respSuccess(response)) {
      final storage = new FlutterSecureStorage();
      await storage.write(key: "phone", value: phone);
      return AuthResult(message: "SMS send success", result: Result.ok);
    } else {
      return AuthResult(message: response.data["msg"], result: Result.error);
    }
  }

  static Future<AuthResult> setPwd({required String phone, required String password}) async {
    Map body = {
      "phone": phone,
      "password": password,
      "goto": 'news',
    };
    final response = await RestClient.postHttp("/post/user/set/pwd", body);
    if (RestClient.respSuccess(response)) {
      final storage = new FlutterSecureStorage();
      await storage.write(key: "username", value: phone);
      await storage.write(key: "password", value: password);
      return AuthResult(message: "Login success", result: Result.ok);
    } else {
      return AuthResult(message: "Login failed. Did you mistype your credentials?", result: Result.error);
    }
  }

  static Future<AuthResult> verifyPhone({required String phone, required String verifyCode}) async {
    Map body = {
      "phone": phone,
      "verifyCode": verifyCode,
      "goto": 'news',
    };
    final response = await RestClient.postHttp("/post/user/verify", body);
    if (RestClient.respSuccess(response)) {
      final storage = new FlutterSecureStorage();
      await storage.write(key: "phone", value: phone);
      await storage.write(key: "verifyCode", value: verifyCode);
      return AuthResult(message: "Login success", result: Result.ok);
    } else {
      return AuthResult(message: "Login failed. Did you mistype your credentials?", result: Result.error);
    }
  }

  static Future<AuthResult> refreshAccessToken({required String refreshToken}) async {
    Map body = {
      "refreshToken": refreshToken,
    };
    final response = await RestClient.postHttpNewDio("/post/auth/access_token/refresh", body);
    String refreshExpiredCode = ResponseStatus.REFRESH_TOKEN_EXPIRED.statusCode;
    String statusCode = response.data["resultCode"];
    if (RestClient.respSuccess(response)) {
      Map result = response.data["result"];
      String accessToken = result["accessToken"];
      await storage.write(key: "accessToken", value: accessToken);
      SecureStorageUtil.putString("accessToken", accessToken);
      return AuthResult(message: "ok", result: Result.ok);
    } else if(refreshExpiredCode == statusCode){
      String? username = await storage.read(key: "username");
      String? password = await storage.read(key: "password");
      if (username != null && password != null) {
        return refreshRefreshToken(phone: username, password: password);
      } else {
        return AuthResult(message: "refresh access token failed", result: Result.error);
      }
    } else {
      return AuthResult(message: "refresh access token failed", result: Result.error);
    }
  }

  static Future<AuthResult> refreshRefreshToken({required String phone, required String password}) async {
    List<String> deviceInfo = await CommonUtils.getDeviceDetails();
    int appId = GlobalConfiguration().get("appId");
    Map body = {
      "phone": phone,
      "password": password,
      "deviceId": deviceInfo[2],
      "app": appId
    };
    final response = await RestClient.postHttpNewDio("/post/auth/refresh_token/refresh", body);
    if (RestClient.respSuccess(response)) {
      Map result = response.data["result"];
      String refreshToken = result["refreshToken"];
      String accessToken = result["accessToken"];
      await storage.write(key: "refreshToken", value: refreshToken);
      await storage.write(key: "accessToken", value: accessToken);
      SecureStorageUtil.putString("refreshToken", refreshToken);
      SecureStorageUtil.putString("accessToken", accessToken);
      return AuthResult(message: "refresh success", result: Result.ok);
    } else {
      return AuthResult(message: "refresh refresh token failed", result: Result.error);
    }
  }

  static Future<AuthResult> login({required String username, required String password, required LoginType loginType}) async {
    List<String> deviceInfo = await CommonUtils.getDeviceDetails();
    int appId = GlobalConfiguration().get("appId");
    Map body = {
      "phone": username,
      "password": password,
      "goto": 'news',
      "loginType": loginType.statusCode,
      "deviceId": deviceInfo[2],
      "deviceType": int.parse(deviceInfo[1]),
      "app": appId
    };
    final response = await RestClient.postHttpNewDio("/post/user/login", body);
    if (RestClient.respSuccess(response)) {
      Map result = response.data["result"];
      String accessToken = result["accessToken"];
      String refreshToken = result["refreshToken"];
      String registerTime = result["registerTime"];
      SecureStorageUtil.putString("username", username);
      SecureStorageUtil.putString("password", password);
      SecureStorageUtil.putString("accessToken", accessToken);
      SecureStorageUtil.putString("refreshToken", refreshToken);
      SecureStorageUtil.putString("registerTime", registerTime);
      await storage.write(key: "username", value: username);
      await storage.write(key: "password", value: password);
      await storage.write(key: "accessToken", value: accessToken);
      await storage.write(key: "refreshToken", value: refreshToken);
      await storage.write(key: "registerTime", value: registerTime);
      return AuthResult(message: "Login success", result: Result.ok);
    } else {
      NavigationService.instance.navigateToReplacement("login");
      return AuthResult(message: "Login failed", result: Result.error);
    }
  }
}
