import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:optical_character_recognizer/constants/text_styles.dart';
import 'package:optical_character_recognizer/core/services/auth_service.dart';
import 'package:optical_character_recognizer/core/utils/utils.dart';
import 'package:optical_character_recognizer/core/utils/validators.dart';
import 'package:optical_character_recognizer/ui/screens/auth/login_screen.dart';
import 'package:optical_character_recognizer/ui/widgets/custom_button.dart';
import 'package:optical_character_recognizer/ui/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign_up_screen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _contactController = TextEditingController();
  final _genderController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _contactController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  handleSignUpBtn() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _confirmPasswordController.text) {
        ProgressDialog pD = ProgressDialog(
          context,
          message: const Text('Please wait...'),
          title: const Text('Signing up'),
        );
        pD.show();

        AuthResponse response = await authService.createAccount(
            _emailController.text, _passwordController.text);

        pD.dismiss();

        if (response.status) {
          ///Account Creation Successful
          if (!mounted) return;
          Utils.showSnackBar(context, 'Account Created Successfully');

          Navigator.pushNamed(context, LoginScreen.routeName);
        } else {
          ///Show Alert
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
                  const SizedBox(height: 20),
                  Text('Hi! ', style: loginTextTextStyle),
                  Text('Welcome', style: loginTextTextStyle),
                  const SizedBox(height: 10),
                  Text('Lets create an account',
                      style: loginTextSmallTextStyle),
                  CustomTextField(
                    hintText: 'Email',
                    labelText: 'Email',
                    controller: _emailController,
                    validator: validateEmailField,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    hintText: 'Full Name',
                    labelText: 'Full Name',
                    controller: _fullNameController,
                    validator: validateFullNameField,
                  ),
                  CustomTextField(
                    hintText: 'Password',
                    labelText: 'Password',
                    obsecureText: true,
                    maxLines: 1,
                    controller: _passwordController,
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
                  CustomTextField(
                    hintText: 'Contact',
                    labelText: 'Contact',
                    controller: _contactController,
                    validator: validateContactField,
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextField(
                    hintText: 'Gender',
                    labelText: 'Gender',
                    controller: _genderController,
                    validator: validateGenderField,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Sign Up',
                    onPress: handleSignUpBtn,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        // style: alreadyHaveAccountStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: const Text(
                          '  Log In',
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
