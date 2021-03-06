import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

//编辑控制器，用于获取编辑文本
//这里使用有些欠妥，这里定义在外部，在多个相同实例的情况下，可能会有问题，建议还是将这两个字段表达在state中。
//这里是例子，就不做修改了。希望读者在实际使用中注意。
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

//参数
// state用于数据展示
// dispatch用于发送action
// ViewService 用于获取buildcontext，跳转页面需要使用到
Widget buildView(LoginState state, Dispatch dispatch, ViewService viewService) {
  return MaterialApp(
      home: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                //生成eamil编辑组件
                //这里widget较为复杂，都用私有函数生成，建议真实开发中widget嵌套不要超过三层
                SizedBox(
                  height: 20,
                ),
                //生成password编辑组件
                SizedBox(
                  height: 20,
                ),
                //生成登陆按钮组件
                _loginBtn(dispatch, viewService, key: ValueKey('loginBtn')),
                SizedBox(
                  height: 20,
                ),
                //state中的数据展示如果state更新，会自动刷新
                Text('name = ${state.userName}',style: TextStyle(fontSize: 16),),
              ],
            ),
          )));
}

Widget _loginBtn(Dispatch dispatch, ViewService viewService, {required Key key}) {
  return ElevatedButton(
  onPressed: () {
    var email = _emailController.text;
    var password = _passwordController.text;
    Map<String, dynamic> map = {"email": email, "password": password};
    dispatch(LoginActionCreator.onLoginAction(map));
  }, child: null,
  );
}