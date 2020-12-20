import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomeListDefaultPage extends Page<HomeListDefaultState, Map<String, dynamic>> {
  HomeListDefaultPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HomeListDefaultState>(
                adapter: null,
                slots: <String, Dependent<HomeListDefaultState>>{
                }),
            middleware: <Middleware<HomeListDefaultState>>[
            ],);

}
