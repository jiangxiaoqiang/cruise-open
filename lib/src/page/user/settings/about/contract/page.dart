import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ContractPage extends Page<ContractState, Map<String, dynamic>> {
  ContractPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ContractState>(
                adapter: null,
                slots: <String, Dependent<ContractState>>{
                }),
            middleware: <Middleware<ContractState>>[
            ],);

}
