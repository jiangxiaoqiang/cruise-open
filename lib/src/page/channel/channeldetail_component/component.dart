import 'package:cruise/src/page/home/components/articlelist_component/component.dart';
import 'package:cruise/src/page/home/components/articlelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChannelDetailComponent extends Component<ChannelDetailState> {
  ChannelDetailComponent()
      : super(
          reducer: buildReducer(),
          view: buildView,
          effect: buildEffect(),
          dependencies: Dependencies<ChannelDetailState>(
              adapter: null, slots: <String, Dependent<ChannelDetailState>>{'articlelist': ArticleListChannelDetailConnector() + ArticleListComponent()}),
        );
}
