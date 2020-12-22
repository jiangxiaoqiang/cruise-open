import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChannelListDefaultComponent extends Component<ChannelListDefaultState> {
  ChannelListDefaultComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ChannelListDefaultState>(
                adapter: null,
                slots: <String, Dependent<ChannelListDefaultState>>{
                }),);

}
