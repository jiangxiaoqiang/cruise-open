import 'package:Cruise/src/page/reg/set_pwd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:Cruise/src/common/auth.dart';

class VerifyPage extends HookWidget {

  const VerifyPage({required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());

    final verifyCode = useState("");
    final submitting = useState(false);

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("验证手机")),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB( 20.0, 120, 20.0, 40),
              child: TextFormField(
                autocorrect: false,
                onChanged: (value) {
                  verifyCode.value = value;
                },
                decoration: InputDecoration(
                  labelText: '验证码',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "验证码不能为空";
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
                          child:RaisedButton(
                        color: Theme.of(context).primaryColor,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            submitting.value = true;
                            AuthResult result = await Auth.verifyPhone(
                              phone: phone,
                              verifyCode: verifyCode.value,
                            );
                            Widget page;
                            page = SetPwdPage(phone: phone);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => page),
                            );
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
                            : Text("下一步"),
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
