import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';

// https://www.jianshu.com/p/b2581f5dadc8
abstract class GlobalBaseState{
  bool get showDebug;

  set showDebug(bool showDebug);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState>{

  @override
   bool showDebug = false;

  @override
  GlobalState clone() {
    return GlobalState();
  }
}