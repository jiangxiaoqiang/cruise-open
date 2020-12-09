import 'package:Cruise/src/common/net/rest/http_result.dart';
import 'package:Cruise/src/home/home_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:Cruise/src/common/auth.dart';

class SetPwdPage extends HookWidget {
  const SetPwdPage({@required this.phone});

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
              padding: const EdgeInsets.fromLTRB( 20.0, 120, 20.0, 40),
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
                  if (value.isEmpty) {
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
                          child:RaisedButton(
                        color: Theme.of(context).primaryColor,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            submitting.value = true;
                            AuthResult result = await Auth.setPwd(
                              phone: phone,
                              password: password.value,
                            );

                            if (result.result == Result.error) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result.message),
                                ),
                              );
                            } else {
                              Widget page;
                              page = HomeNew();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => page),
                              );
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
