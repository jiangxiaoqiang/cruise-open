import 'package:Cruise/src/page/login.dart';
import 'package:Cruise/src/page/reg/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:Cruise/src/common/auth.dart';

class RegPage extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());

    double screenWidth = MediaQuery.of(context).size.width;

    final phone = useState("");
    final submitting = useState(false);

    return Scaffold(
      appBar: AppBar(title: Text(""),
        actions: [
        FlatButton(
        textColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Text("登录"),
        shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
      ),],),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB( 20.0, 120, 20.0, 40),
              child: TextFormField(
                autocorrect: false,
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
                  if (value.isEmpty) {
                    return "手机号码不能为空";
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
                            AuthResult result = await Auth.sms(
                              phone: phone.value,
                            );

                            Widget page;
                            page = VerifyPage(phone: phone.value);
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
