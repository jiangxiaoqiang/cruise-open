import 'package:Cruise/src/page/home/components/articlelist_component/component.dart';
import 'package:Cruise/src/page/home/components/articlelist_component/state.dart';
import 'package:Cruise/src/page/home/components/homelistdefault_component/component.dart';
import 'package:Cruise/src/page/home/components/homelistdefault_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChannelDetailComponent extends Component<ChannelDetailState> {
  ChannelDetailComponent()
      : super(
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ChannelDetailState>(adapter: null, slots: <String, Dependent<ChannelDetailState>>{
            'homelistdefault': HomeListDefaultChannelDetailConnector() + HomeListDefaultComponent(),
            'articlelist': ArticleListChannelDetailConnector() + ArticleListComponent()
          }),
        );
}
