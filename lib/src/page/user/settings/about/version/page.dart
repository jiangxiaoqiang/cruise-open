import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class VersionPage extends Page<VersionState, Map<String, dynamic>> {
  VersionPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<VersionState>(
                adapter: null,
                slots: <String, Dependent<VersionState>>{
                }),
            middleware: <Middleware<VersionState>>[
            ],);

}
