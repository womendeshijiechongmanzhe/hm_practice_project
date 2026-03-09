import 'package:get/get.dart';
import 'package:hm_shop/viewmodels/user.dart';

//需要共享的对象，要有一些共享的属性，属性响应式更新
class UserController extends GetxController {
  var user = UserInfo.fromJSON({}).obs;
  //想要取值，需要user.value
  updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
