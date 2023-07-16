import 'package:country_code_picker/country_code_picker.dart';
import 'package:cruise/src/common/nav/nav_util.dart';
import 'package:cruise/src/common/style/global_style.dart';
import 'package:cruise/src/component/user_agreement.dart';
import 'package:cruise/src/page/reg/reg.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wheel/wheel.dart';

class LoginPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());
    final username = useState("");
    final password = useState("");
    final countryCode = useState("+86");
    final phoneValid = useState(false);
    final submitting = useState(false);
    final showPassword = useState(true);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Cruise"),
          actions: [
            TextButton(
              style: GlobalStyle.textButtonStyle,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegPage(phoneNumber: username.value)));
              },
              child: Text("注册", style: TextStyle(fontSize: 16.0)),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Row(
                      children: [
                        CountryCodePicker(
                          onChanged: (CountryCode country) {
                            countryCode.value = country.toString();
                          },
                          initialSelection: 'CN',
                          favorite: ['+86', 'ZH'],
                          // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                          flagDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        SizedBox(
                            height: 45,
                            width: (screenWidth - 20) * 0.72,
                            child: TextFormField(
                              autocorrect: false,
                              onChanged: (value) {
                                username.value = value;
                              },
                              keyboardType: TextInputType.phone,
                              obscureText: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "电话号码不能为空";
                                }
                                phoneValid.value = true;
                                return null;
                              },
                            ))
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16, top: 32),
                  child: TextFormField(
                    autocorrect: false,
                    onChanged: (value) {
                      password.value = value;
                    },
                    obscureText: showPassword.value,
                    decoration: InputDecoration(
                        labelText: '密码',
                        contentPadding: EdgeInsets.all(10.0), //控制输入控件高度
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            showPassword.value = !showPassword.value;
                          },
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "密码不能为空";
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      child: Builder(
                        builder: (context) {
                          return ButtonTheme(
                              minWidth: screenWidth * 0.85,
                              height: 50.0,
                              child: Center(
                                  child: ElevatedButton(
                                style: GlobalStyle.getButtonStyle(context),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate() && phoneValid.value) {
                                    submitting.value = true;
                                    String userName = countryCode.value + username.value;
                                    AppLoginRequest appLoginRequest =
                                        new AppLoginRequest(password: password.value, username: userName, loginType: LoginType.PHONE, loginUrl: '/post/user/login');
                                    Response resp = await Auth.login(appLoginRequest: appLoginRequest);
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
                                        height: 45,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        ),
                                      )
                                    : Text("登录"),
                              )));
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: Center(child: UserAgreement()),
                )
              ],
            ),
          ),
        ));
  }
}
