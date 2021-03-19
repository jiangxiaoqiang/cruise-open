import 'package:cruise/src/page/channel/channellist_component/component.dart';
import 'package:cruise/src/page/channel/channellist_component/state.dart';
import 'package:cruise/src/page/channel/channellistdefault_component/effect.dart';
import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChannelListDefaultComponent extends Component<ChannelListDefaultState> {
  ChannelListDefaultComponent()
      : super(
          reducer: buildReducer(),
          view: buildView,
          effect: buildEffect(),
          dependencies: Dependencies<ChannelListDefaultState>(
              adapter: null,
              slots: <String, Dependent<ChannelListDefaultState>>{
                'channellist': ChannelListConnector() + ChannelListComponent()
              }),
        );
}
