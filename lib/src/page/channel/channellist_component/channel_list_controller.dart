import 'package:get/get.dart';

import '../../../models/Channel.dart';

class ChannelListController extends GetxController {
  Channel? channel;
  RxList<Channel> channels = List<Channel>.empty(growable: true).obs;
}
