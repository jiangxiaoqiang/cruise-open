import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChannelListComponent extends Component<ChannelListState> {
  ChannelListComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ChannelListState>(
                adapter: null,
                slots: <String, Dependent<ChannelListState>>{
                }),);

}
