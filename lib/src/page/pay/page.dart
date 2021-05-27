import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PayPage extends Page<PayState, Map<String, dynamic>> {
  PayPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PayState>(
                adapter: null,
                slots: <String, Dependent<PayState>>{
                }),
            middleware: <Middleware<PayState>>[
            ],);

}
