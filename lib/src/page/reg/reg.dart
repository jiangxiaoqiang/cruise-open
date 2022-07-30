import 'package:country_code_picker/country_code_picker.dart';
import 'package:cruise/src/common/style/global_style.dart';
import 'package:cruise/src/page/login.dart';
import 'package:cruise/src/page/reg/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wheel/wheel.dart';

class RegPage extends HookWidget {
  RegPage({required this.phoneNumber});

  /// if user entered part of the phone number in login page and found not registered
  /// pass phone number make user switch to registered page did not need to input phone number again
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());

    double screenWidth = MediaQuery.of(context).size.width;
    final countryCode = useState("+86");
    final phone = useState(phoneNumber);
    final submitting = useState(false);

    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          actions: [
            TextButton(
              style: GlobalStyle.textButtonStyle,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text("登录"),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 120, 20.0, 40),
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
                          width: screenWidth - 150,
                          child: TextFormField(
                            autocorrect: false,
                            initialValue: phone.value,
                            onChanged: (value) {
                              phone.value = value;
                            },
                            decoration: InputDecoration(
                              labelText: '手机号',
                              contentPadding: EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "手机号码不能为空";
                              }
                              return null;
                            },
                          ))
                    ],
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
                                    String phoneNumber = countryCode.value + phone.value;
                                    AuthResult result = await Auth.sms(
                                      phone: phoneNumber,
                                    );

                                    if (result.result == Result.error) {
                                      submitting.value = false;
                                      ToastUtils.showToast(result.message);
                                    } else {
                                      Widget page;
                                      page = VerifyPage(phone: phoneNumber);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => page),
                                      );
                                    }
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
                                    : Text("获取验证码"),
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
