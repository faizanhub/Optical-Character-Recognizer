import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:optical_character_recognizer/constants/text_styles.dart';
import 'package:optical_character_recognizer/core/services/auth_service.dart';
import 'package:optical_character_recognizer/core/utils/utils.dart';
import 'package:optical_character_recognizer/core/utils/validators.dart';
import 'package:optical_character_recognizer/ui/screens/auth/sign_up_screen.dart';
import 'package:optical_character_recognizer/ui/widgets/custom_button.dart';
import 'package:optical_character_recognizer/ui/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot_password_screen';

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _authService = AuthService();

  handleForgotPasswordBtn() async {
    ProgressDialog pD = ProgressDialog(
      context,
      message: const Text('Please wait...'),
      title: const Text('Sending Email'),
    );

    if (_formKey.currentState!.validate()) {
      pD.show();
      AuthResponse response =
          await _authService.forgotPassword(_emailController.text.trim());

      pD.dismiss();

      if (response.status) {
        if (!mounted) return;
        Utils.showAlertDialog(context, 'Success', response.message);
      } else {
        if (!mounted) return;
        Utils.showAlertDialog(context, 'Failed', response.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text('Oh, No! ',
                      style: loginTextTextStyle.copyWith(fontSize: 50)),
                  Text('I Forgot',
                      style: loginTextTextStyle.copyWith(fontSize: 50)),
                  const SizedBox(height: 10),
                  Text(
                      'Enter your email we will send you a link to change a new password',
                      style: loginTextSmallTextStyle),
                  const SizedBox(height: 50),
                  CustomTextField(
                    hintText: 'Email',
                    labelText: 'Email',
                    controller: _emailController,
                    validator: validateEmailField,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Forgot Password',
                    onPress: handleForgotPasswordBtn,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont have an account?',
                        // style: alreadyHaveAccountStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: const Text(
                          '  Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          // style: loginNowTextStyle,
                        ),
                      ),
                    ],
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
