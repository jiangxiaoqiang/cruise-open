import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class loginPage extends Page<loginState, Map<String, dynamic>> {
  loginPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<loginState>(
                adapter: null,
                slots: <String, Dependent<loginState>>{
                }),
            middleware: <Middleware<loginState>>[
            ],);

}
