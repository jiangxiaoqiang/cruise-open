import 'package:fish_redux/fish_redux.dart';

class ContractState implements Cloneable<ContractState> {

  @override
  ContractState clone() {
    return ContractState();
  }
}

ContractState initState(Map<String, dynamic> args) {
  return ContractState();
}
