import 'package:cruise/src/page/channel/channellistdefault_component/component.dart';
import 'package:cruise/src/page/channel/channellistdefault_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomeListComponent extends Component<HomeListState> {
  HomeListComponent()
      : super(
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<HomeListState>(adapter: null, slots: <String, Dependent<HomeListState>>{
            'channellistdefault': ChannelListDefaultConnector() + ChannelListDefaultComponent()
          }),
        );
}
