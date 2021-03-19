import 'package:cruise/src/page/home/components/articlelist_component/component.dart';
import 'package:cruise/src/page/user/fav/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CruiseSettingComponent extends Component<CruiseSettingState> {
  CruiseSettingComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CruiseSettingState>(
                adapter: null,
                slots: <String, Dependent<CruiseSettingState>>{
                  //'fav': FavConnector() + ArticleListComponent()
                }),);

}
