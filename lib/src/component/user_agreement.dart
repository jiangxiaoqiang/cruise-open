import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UserAgreement extends HookWidget {

  final TextStyle _lowProfileStyle = TextStyle(
    fontSize: 12.0,
    color: Color(0xFF4A4A4A),
  );

  final TextStyle _highProfileStyle = TextStyle(
    fontSize: 12.0,
    color: Color(0xFF00CED2),
  );

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '登录即同意',
        style: _lowProfileStyle,
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () {
              print('点击了“服务条款”');
            },
            text: '“服务条款”',
            style: _highProfileStyle,
          ),
          TextSpan(
            text: '和',
            style: _lowProfileStyle,
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () {
              print('点击了“隐私政策”');
            },
            text: '“隐私政策”',
            style: _highProfileStyle,
          ),
        ],
      ),
    );
  }

}
