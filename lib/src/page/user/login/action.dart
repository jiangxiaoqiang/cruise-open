import 'package:fish_redux/fish_redux.dart';

enum LoginAction { login,emailFail,loginSuccess}

class LoginActionCreator {
  static Action onEmailFail() {
    return Action(LoginAction.emailFail);
  }
  static Action onLoginSuccess(LoginAction loginModel) {
    return Action(LoginAction.loginSuccess,payload: loginModel);
  }
  static Action onLoginAction(params) {
    return Action(LoginAction.login,payload: params);
  }
}
