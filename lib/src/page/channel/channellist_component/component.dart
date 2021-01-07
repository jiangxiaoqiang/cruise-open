import 'package:Cruise/src/page/channel/channellist_component/effect.dart';
import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChannelListComponent extends Component<ChannelListState> {
  ChannelListComponent()
      : super(
          reducer: buildReducer(),
          view: buildView,
          effect: buildEffect(),
          dependencies: Dependencies<ChannelListState>(
              adapter: null, slots: <String, Dependent<ChannelListState>>{}),
        );
}
