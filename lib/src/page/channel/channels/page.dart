import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChannelsPage extends Page<ChannelsState, Map<String, dynamic>> {
  ChannelsPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ChannelsState>(
                adapter: null,
                slots: <String, Dependent<ChannelsState>>{
                }),
            middleware: <Middleware<ChannelsState>>[
            ],);

}
