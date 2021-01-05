import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChannelDetailComponent extends Component<ChannelDetailState> {
  ChannelDetailComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ChannelDetailState>(
                adapter: null,
                slots: <String, Dependent<ChannelDetailState>>{
                }),);

}
