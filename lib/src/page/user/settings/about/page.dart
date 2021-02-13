import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AboutPage extends Page<aboutState, Map<String, dynamic>> {
  AboutPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<aboutState>(
                adapter: null,
                slots: <String, Dependent<aboutState>>{
                }),
            middleware: <Middleware<aboutState>>[
            ],);

}
