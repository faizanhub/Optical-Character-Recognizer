import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:optical_character_recognizer/constants/text_styles.dart';
import 'package:optical_character_recognizer/core/services/auth_service.dart';
import 'package:optical_character_recognizer/core/utils/utils.dart';
import 'package:optical_character_recognizer/core/utils/validators.dart';
import 'package:optical_character_recognizer/ui/screens/auth/forgot_password_screen.dart';
import 'package:optical_character_recognizer/ui/screens/auth/sign_up_screen.dart';
import 'package:optical_character_recognizer/ui/screens/home_screen.dart';
import 'package:optical_character_recognizer/ui/widgets/custom_button.dart';
import 'package:optical_character_recognizer/ui/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  handleLoginButton() async {
    ProgressDialog pD = ProgressDialog(context,
        message: const Text('Please wait...'), title: const Text('Logging in'));

    if (_formKey.currentState!.validate()) {
      pD.show();
      AuthResponse? response = await _authService.login(
          _emailController.text.trim(), _passwordController.text.trim());

      pD.dismiss();

      if (response.status) {
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
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
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: const Color(0xffdad5f8),
                        child: Image.asset(
                          'assets/images/text_recognition.png',
                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Optical Character Recognizer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Login', style: loginTextTextStyle),
                        const SizedBox(height: 5),
                        const Text('Waiting for you, please enter your detail',
                            style: loginTextSmallTextStyle),

                        ///Text Fields
                        CustomTextField(
                          hintText: 'Email',
                          labelText: 'Email',
                          controller: _emailController,
                          validator: validateEmailField,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        CustomTextField(
                          hintText: 'Password',
                          labelText: 'Password',
                          obsecureText: true,
                          maxLines: 1,
                          controller: _passwordController,
                          validator: validatePasswordField,
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ForgotPasswordScreen.routeName);
                            },
                            child: const Text(
                              'Forgot Password ?',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        CustomButton(
                          text: 'Login',
                          onPress: handleLoginButton,
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: Column(
                            children: [
                              const Text(
                                'Login With',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: const Color(0xffefedfd),
                                child: Image.asset(
                                  'assets/images/google.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Dont have an account?',
                                    // style: alreadyHaveAccountStyle,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, SignUpScreen.routeName);
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
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
