import 'package:get/get.dart';

import '../../../common/cruise_user.dart';

class ProfileController extends GetxController {
  var isMe = true.obs;
  CruiseUser user = new CruiseUser(phone: '', registerTime: '');
}
