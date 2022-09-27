import 'package:firebase_auth/firebase_auth.dart';
import 'package:optical_character_recognizer/constants/app_strings.dart';
import 'package:optical_character_recognizer/constants/error_strings.dart';

abstract class AuthBase {
  Future<AuthResponse> login(String email, String password);

  Future<AuthResponse> createAccount(String email, String password);

  Future<void> signOut();

  Future<AuthResponse> forgotPassword(String email);

  Future<AuthResponse> changePassword(
      String currentPassword, String newPassword);
}

class AuthService extends AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        return AuthResponse(status: true, message: '');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.userNotFound) {
        return AuthResponse(status: false, message: ErrorStrings.userNotFound);
      } else if (e.code == AppStrings.wrongPassword) {
        return AuthResponse(status: false, message: ErrorStrings.wrongPassword);
      }
    } catch (e) {
      return AuthResponse(
          status: false, message: ErrorStrings.somethingWentWrong);
    }

    return AuthResponse(
        status: false, message: ErrorStrings.somethingWentWrong);
  }

  @override
  Future<AuthResponse> createAccount(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return AuthResponse(status: true, message: '');
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.weakPassword) {
        return AuthResponse(
            status: false, message: ErrorStrings.passwordTooWeak);
      } else if (e.code == AppStrings.emailAlreadyInUse) {
        return AuthResponse(
            status: false, message: ErrorStrings.accountAlreadyExists);
      }
    } catch (e) {
      return AuthResponse(
          status: false, message: ErrorStrings.somethingWentWrong);
    }

    return AuthResponse(
        status: false, message: ErrorStrings.somethingWentWrong);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<AuthResponse> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return AuthResponse(
          status: true,
          message: 'Password reset email sent, Please check your email');
    } on FirebaseAuthException catch (e) {
      return AuthResponse(
          status: false, message: e.message ?? 'Something wrong happened');
    }
  }

  @override
  Future<AuthResponse> changePassword(
      String currentPassword, String newPassword) async {
    var user = FirebaseAuth.instance.currentUser!;

    final credential = EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);
    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      return AuthResponse(
          status: true, message: 'Password Changed Successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return AuthResponse(status: false, message: 'User Not found');
      } else if (e.code == 'invalid-credential') {
        return AuthResponse(status: false, message: 'Invalid Credentials');
      } else if (e.code == 'invalid-email') {
        return AuthResponse(status: false, message: 'Email not found');
      } else if (e.code == 'wrong-password') {
        return AuthResponse(status: false, message: 'Wrong old password');
      }
    } catch (e) {
      return AuthResponse(
          status: false, message: ErrorStrings.somethingWentWrong);
    }

    return AuthResponse(
        status: false, message: ErrorStrings.somethingWentWrong);
  }
}

class AuthResponse {
  bool status;
  String message;

  AuthResponse({required this.status, required this.message});
}
