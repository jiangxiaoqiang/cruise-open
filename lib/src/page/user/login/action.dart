import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum loginAction { login,emailFail,loginSuccess}
class loginActionCreator {
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
