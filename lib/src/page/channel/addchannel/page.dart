import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AddChannelPage extends Page<AddChannelState, Map<String, dynamic>> {
  AddChannelPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AddChannelState>(
                adapter: null,
                slots: <String, Dependent<AddChannelState>>{
                }),
            middleware: <Middleware<AddChannelState>>[
            ],);

}
