import 'package:Cruise/src/common/net/rest/http_result.dart';
import 'package:Cruise/src/component/user_agreement.dart';
import 'package:Cruise/src/page/reg/reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:Cruise/src/common/auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginPage extends HookWidget {
  final PhoneNumber number = PhoneNumber(isoCode: 'CN');
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());
    final username = useState("");
    final password = useState("");
    final phoneValid = useState(false);
    final submitting = useState(false);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(""),
        actions: [
          FlatButton(
            textColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegPage()));
            },
            child: Text("注册",style: TextStyle(fontSize: 16.0)),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
      ],),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB( 20.0, 120, 20.0, 40),
              child: SingleChildScrollView(
                child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  username.value = number.phoneNumber;
                },
                locale: "zh",
                hintText: "手机号码",
                errorMessage:"无效的手机号码",
                onInputValidated: (bool value) {
                  phoneValid.value = value;
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                ),
                ignoreBlank: false,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                textFieldController: controller,
                inputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                inputDecoration: InputDecoration(
                  //fillColor: Colors.black,
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
                left: 16,
                right: 16,
              ),
              child: TextFormField(
                autocorrect: false,
                onChanged: (value) {
                  password.value = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    labelText: '密码',
                    contentPadding: EdgeInsets.all(10.0),//控制输入控件高度
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    prefixIcon: Icon(Icons.remove_red_eye)),
                validator: (value) {
                  if (value.isEmpty) {
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Builder(
                    builder: (context) {
                      return ButtonTheme(
                          minWidth: screenWidth * 0.85,
                          height: 50.0,
                          child: Center(
                              child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            onPressed: () async {
                              if (_formKey.currentState.validate() && phoneValid.value) {
                                submitting.value = true;
                                AuthResult result = await Auth.login(
                                  username: username.value,
                                  password: password.value,
                                );

                                if (result.result == Result.error) {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(result.message),
                                    ),
                                  );
                                } else {
                                  Navigator.pop(context);
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
                                : Text("登录"),
                          )));
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 200.0),
              child: Center(child: UserAgreement()),
            )
          ],
        ),
      ),
    );
  }
}
