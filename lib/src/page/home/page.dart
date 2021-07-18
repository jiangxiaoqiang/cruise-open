import 'package:fish_redux/fish_redux.dart';

import 'components/homelist_component/component.dart';
import 'components/homelist_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomePage extends Page<HomeState, Map<String, dynamic>> {
  HomePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HomeState>(
                adapter: null,
                slots: <String, Dependent<HomeState>>{
                  'homelist': HomeListConnector() + HomeListComponent()
                }),
            middleware: <Middleware<HomeState>>[
            ],);

}
