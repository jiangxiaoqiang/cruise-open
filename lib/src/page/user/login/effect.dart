import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<LoginState>? buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    //收到type为login的action执行，onlogin方法，这里开发者不用定义参数，是因为已经被Effect定义好的，
    //参数为action和Context<T>
    LoginAction.login: onLogin,
  });
}

void onLogin(Action action, Context<LoginState> ctx) {
  //取出action的登陆参数，参数类型为dynamic，可以是任意对象
  Map loginMap = action.payload;
  String email = loginMap['email'];
  if (!email.contains("@")) {
    //由于是例子，就简单的判断email是否含有@字符，如果没有说明email不合法
    //如果不合法使用context，发送EmailFailAction给reducer
    ctx.dispatch(LoginActionCreator.onEmailFail());
  }else{
    //eamil合法初始化网络请求工具类。备注：这个网络请求工具是基于dio很简单的封装，为了之后的测试mock方便
    //读者可以根据自己的业务编写。
    //这里的??=翻译一下
    //if(API.request==null){
    // 	API.request=HttpRequest(API.BASE_URL)
    //}
   /* AuthResult result = await Auth.login(
      username: "username.value",
      password: "password.value",
    );

    if (result.result == Result.error) {

    } else {
    }*/
    //ctx.dispatch(LoginActionCreator.onLoginSuccess());
  }
}
