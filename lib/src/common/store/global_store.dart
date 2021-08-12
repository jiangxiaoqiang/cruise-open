import 'package:cruise/src/common/store/store.dart';
import 'package:fish_redux/fish_redux.dart';
import 'reducer.dart';

class GlobalStore{
  static Store<GlobalState>? _globalStore;
  static Store<GlobalState> get store =>
      _globalStore ??= createStore<GlobalState>(GlobalState(), buildReducer());
}