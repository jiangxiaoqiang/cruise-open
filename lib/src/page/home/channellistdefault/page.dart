import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChannelListDefaultPage extends Page<ChannelListDefaultState, Map<String, dynamic>> {
  ChannelListDefaultPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ChannelListDefaultState>(
                adapter: null,
                slots: <String, Dependent<ChannelListDefaultState>>{
                }),
            middleware: <Middleware<ChannelListDefaultState>>[
            ],);

}
