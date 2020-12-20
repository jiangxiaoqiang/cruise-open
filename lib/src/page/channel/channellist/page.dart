import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChannelListPage extends Page<ChannelListState, Map<String, dynamic>> {
  ChannelListPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ChannelListState>(
                adapter: null,
                slots: <String, Dependent<ChannelListState>>{
                }),
            middleware: <Middleware<ChannelListState>>[
            ],);

}
