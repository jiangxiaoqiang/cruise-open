import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';

// https://www.jianshu.com/p/b2581f5dadc8
abstract class GlobalBaseState{
  Color get themeColor;
  set themeColor(Color color);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState>{
  @override
  late Color themeColor;

  @override
  GlobalState clone() {
    return GlobalState();
  }
}