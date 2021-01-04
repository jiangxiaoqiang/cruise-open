import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChannelPgComponent extends Component<ChannelPgState> {
  ChannelPgComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ChannelPgState>(
                adapter: null,
                slots: <String, Dependent<ChannelPgState>>{
                }),);

}
