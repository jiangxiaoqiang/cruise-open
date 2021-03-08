import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LoginState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoginState>>{
      //收到相应type 的action执行相应的方法
      loginAction.emailFail: _onEmailFail,
      loginAction.loginSuccess: _onLoginSuccess
    },
  );
}

LoginState _onAction(LoginState state, Action action) {
  final LoginState newState = state.clone();
  return newState;
}

LoginState _onLoginSuccess(LoginState state, Action action) {
  //返回的state一定不能拿到旧的state直接修改并返回，
  //需要创建一个新的state，大部分情况是用clone创建。
  final LoginState newState = state.clone();
  //状态赋值
  newState.loginResult = LoginState.LoginResult_LoginSuccess;
  //action.payload是action的参数，类型也是dynamic，这里不强转也不会报错，只是写的时候IDE不会
  //自动联想。所以我建议还是写上比较清晰
  newState.userName = (action.payload as LoginModel).session.toString();
  var ageObj = (action.payload as LoginModel).session;
  newState.age = int.parse(ageObj.toString());
  return newState;
}

class LoginModel {
  Object? session;
}

LoginState _onEmailFail(LoginState state, Action action) {
  final LoginState newState = state.clone();
  //改变state状态为email不合法
  newState.loginResult = LoginState.LoginResult_EmailFail;
  return newState;
}
