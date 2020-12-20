import 'package:fish_redux/fish_redux.dart';

enum loginAction { login,emailFail,loginSuccess}

class LoginActionCreator {
  static Action onEmailFail() {
    return Action(loginAction.emailFail);
  }
  static Action onLoginSuccess(loginAction loginModel) {
    return Action(loginAction.loginSuccess,payload: loginModel);
  }
  static Action onLoginAction(params) {
    return Action(loginAction.login,payload: params);
  }
}
