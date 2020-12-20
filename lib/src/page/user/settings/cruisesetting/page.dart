import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CruiseSettingPage extends Page<CruiseSettingState, Map<String, dynamic>> {
  CruiseSettingPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CruiseSettingState>(
                adapter: null,
                slots: <String, Dependent<CruiseSettingState>>{
                }),
            middleware: <Middleware<CruiseSettingState>>[
            ],);

}
