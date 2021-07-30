import 'package:fish_redux/fish_redux.dart';

class LoginState implements Cloneable<LoginState> {

  static const LoginResult_EmailFail = 1;
  static const LoginResult_PassWordFail = 2; // 例子密码不合法，暂不实现
  static const LoginResult_NetWorkFail = 3; //例子网络错误，暂不实现
  static const LoginResult_LoginSuccess = 4;
  int loginResult = 0; //登陆的结果
  String? userName;
  int age = 0;

  //需要重写clone方法，因为reducer生成新的state时会调用
  @override
  LoginState clone() {
    return LoginState()
      ..loginResult = this.loginResult
      ..userName = this.userName
      ..age=this.age;
  }

  //对比方法，比较俩个实例是否相等，测试验证需要
  @override
  bool operator == (dynamic other) {
    if (!(other is LoginState)) return false;
    return loginResult == other.loginResult && userName == other.userName
        &&age==other.age;
  }
}

LoginState initState(Map<String, dynamic>? args) {
  return LoginState()
    ..loginResult = 0
    ..userName = ""
    ..age=0;
}
