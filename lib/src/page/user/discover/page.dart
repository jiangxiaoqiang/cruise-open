import 'package:cruise/src/page/home/components/homelist_component/component.dart';
import 'package:cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DiscoverPage extends Page<DiscoverState, Map<String, dynamic>> {
  DiscoverPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DiscoverState>(adapter: null, slots: <String, Dependent<DiscoverState>>{
            'homelist': DiscoverConnector() + HomeListComponent(),
          }),
          middleware: <Middleware<DiscoverState>>[],
        );
}
