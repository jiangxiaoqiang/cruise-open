import 'package:country_code_picker/country_code_picker.dart';
import 'package:cruise/src/common/auth.dart';
import 'package:cruise/src/common/global_style.dart';
import 'package:cruise/src/common/net/rest/http_result.dart';
import 'package:cruise/src/component/user_agreement.dart';
import 'package:cruise/src/page/reg/reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginPage extends HookWidget {
  final PhoneNumber number = PhoneNumber(isoCode: 'CN');
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());
    final username = useState("");
    final password = useState("");
    final countryCode = useState("");
    final phoneValid = useState(false);
    final submitting = useState(false);
    double screenWidth = MediaQuery.of(context).size.width;

    void _onCountryChange(CountryCode countryCode) {
      //TODO : manipulate the selected country code here
      print("New Country selected: " + countryCode.toString());
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          actions: [
            TextButton(
              style: GlobalStyle.textButtonStyle,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegPage()));
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
                Row(
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
                        height: 35,
                        width: 265,
                        child: TextFormField(
                          autocorrect: false,
                          onChanged: (value) {
                            username.value = value;
                          },
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone不能为空";
                            }
                            return null;
                          },
                        ))
                  ],
                ),
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
                        contentPadding: EdgeInsets.all(10.0), //控制输入控件高度
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        prefixIcon: Icon(Icons.remove_red_eye)),
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
                                    AuthResult result = await Auth.login(
                                      username: countryCode.value + username.value,
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
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: Center(child: UserAgreement()),
                )
              ],
            ),
          ),
        ));
  }
}
