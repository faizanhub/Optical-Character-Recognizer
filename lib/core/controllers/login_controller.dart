import 'package:get/get.dart';

class LoginController extends GetxController {
  var obscureText = true.obs;

  changeObscure(bool newValue) {
    obscureText.value = newValue;
  }
}
