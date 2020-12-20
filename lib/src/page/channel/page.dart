import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChannelPage extends Page<ChannelState, Map<String, dynamic>> {
  ChannelPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ChannelState>(
                adapter: null,
                slots: <String, Dependent<ChannelState>>{
                }),
            middleware: <Middleware<ChannelState>>[
            ],);

}
