import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class App1Page extends Page<AppState, Map<String, dynamic>> {
  App1Page()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AppState>(
                adapter: null,
                slots: <String, Dependent<AppState>>{
                }),
            middleware: <Middleware<AppState>>[
            ],);

}
