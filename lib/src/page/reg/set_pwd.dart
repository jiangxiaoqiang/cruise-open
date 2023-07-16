import 'package:cruise/src/common/nav/nav_util.dart';
import 'package:cruise/src/common/style/global_style.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wheel/wheel.dart';

class SetPwdPage extends HookWidget {
  const SetPwdPage({required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());

    double screenWidth = MediaQuery.of(context).size.width;

    final password = useState("");
    final submitting = useState(false);

    return Scaffold(
      appBar: AppBar(title: Text("设置密码")),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 120, 20.0, 40),
              child: TextFormField(
                autocorrect: false,
                onChanged: (value) {
                  password.value = value;
                },
                decoration: InputDecoration(
                  labelText: '密码',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "密码不能为空";
                  }
                  if (value.length < 8) {
                    return "至少8位密码长度";
                  }
                  return null;
                },
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Builder(
                    builder: (context) {
                      return ButtonTheme(
                          minWidth: screenWidth * 0.9,
                          height: 50.0,
                          child: ElevatedButton(
                            style: GlobalStyle.getButtonStyle(context),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                submitting.value = true;
                                Response resp = await UserService.regUser(
                                  phone: phone,
                                  password: password.value,
                                  verifyCode: '123456', appRegUrl: '/post/user/regUser',
                                );

                                if (!RestClient.respSuccess(resp)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(resp.data["msg"]),
                                    ),
                                  );
                                } else {
                                  NavUtil.navProfile(context);
                                }
                                submitting.value = false;
                              }
                            },
                            child: submitting.value
                                ? SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                : Text("提交"),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
