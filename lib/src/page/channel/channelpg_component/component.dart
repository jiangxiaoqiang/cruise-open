import 'package:cruise/src/page/channel/channeldetail_component/component.dart';
import 'package:cruise/src/page/channel/channeldetail_component/state.dart';
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
                  'channeldetail': ChannelDetailConnector() +
                      ChannelDetailComponent()
                }),);

}
