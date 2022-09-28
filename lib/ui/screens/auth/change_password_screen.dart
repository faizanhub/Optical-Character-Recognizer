import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:optical_character_recognizer/constants/text_styles.dart';
import 'package:optical_character_recognizer/core/services/auth_service.dart';
import 'package:optical_character_recognizer/core/utils/utils.dart';
import 'package:optical_character_recognizer/core/utils/validators.dart';
import 'package:optical_character_recognizer/ui/screens/auth/login_screen.dart';
import 'package:optical_character_recognizer/ui/widgets/custom_button.dart';
import 'package:optical_character_recognizer/ui/widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = '/change_password_screen';

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  handleChangePasswordBtn() async {
    ProgressDialog pD = ProgressDialog(context,
        message: const Text('Please wait...'),
        title: const Text('Changing Password'));

    if (_formKey.currentState!.validate()) {
      if (_newPasswordController.text == _confirmPasswordController.text) {
        pD.show();
        AuthResponse response = await _authService.changePassword(
            _oldPasswordController.text.trim(),
            _newPasswordController.text.trim());

        pD.dismiss();

        if (response.status) {
          if (!mounted) return;
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.routeName, (route) => false);
          Utils.showSnackBar(context, response.message);
        } else {
          if (!mounted) return;
          Utils.showAlertDialog(context, 'Failed', response.message);
        }
      } else {
        Utils.showAlertDialog(
            context, 'Failed', 'Password fields are not same.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text('Change',
                      style: loginTextTextStyle.copyWith(fontSize: 50)),
                  Text('Password',
                      style: loginTextTextStyle.copyWith(fontSize: 50)),
                  const SizedBox(height: 10),
                  Text(
                    'Enter your old Password',
                    style: loginTextSmallTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Old Password',
                    labelText: 'Old Password',
                    obsecureText: true,
                    maxLines: 1,
                    controller: _oldPasswordController,
                    validator: validatePasswordField,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Enter your new Password',
                    style: loginTextSmallTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    hintText: 'New Password',
                    labelText: 'New Password',
                    obsecureText: true,
                    maxLines: 1,
                    controller: _newPasswordController,
                    validator: validatePasswordField,
                  ),
                  CustomTextField(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    obsecureText: true,
                    maxLines: 1,
                    controller: _confirmPasswordController,
                    validator: validatePasswordField,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Change Password',
                    onPress: handleChangePasswordBtn,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
