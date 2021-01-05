import 'package:Cruise/src/page/channel/channellist_component/component.dart';
import 'package:Cruise/src/page/channel/channellist_component/state.dart';
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
                'channellist': ChannelListConnector() + ChannelListComponent()
              }),
        );
}
