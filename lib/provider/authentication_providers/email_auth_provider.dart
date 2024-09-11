import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/modals/user_modal.dart';
import 'package:marvelapp/screens/bottom_nav.dart';
import 'package:marvelapp/screens/details_screens/user_email_avatar_details_screen.dart';
import 'package:marvelapp/screens/get_started_screen.dart';
import 'package:marvelapp/widgets/toast_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailAuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerConfirmPasswordController =
      TextEditingController();

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  User? get emailUser => _auth.currentUser;

  Future<void> _saveLoginState(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  // Function to register with email and password
  Future<void> registerWithEmailPassword(BuildContext context) async {
    final String name = nameController.text.trim();
    final String email = registerEmailController.text.trim();
    final String password = registerPasswordController.text.trim();
    final String confirmPassword =
        registerConfirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _errorMessage = "Please fill out all fields";
      ToastHelper.showErrorToast(context: context, message: _errorMessage);
      notifyListeners();
      return;
    }

    if (!isValidEmail(email)) {
      _errorMessage = "Invalid email format";
      ToastHelper.showErrorToast(context: context, message: _errorMessage);
      notifyListeners();
      return;
    }

    if (password != confirmPassword) {
      _errorMessage = "Passwords do not match";
      ToastHelper.showErrorToast(context: context, message: _errorMessage);
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? emailUser = userCredential.user;
      if (emailUser != null) {
        await emailUser.updateDisplayName(name);

        UserModal emailModalUser = UserModal(
          uid: emailUser.uid,
          userName: name,
          userEmail: emailUser.email,
          userPhotoURL: emailUser.photoURL,
        );

        await _firestore.collection('userByEmailAuth').doc(emailUser.uid).set(
              emailModalUser.toJson(),
            );

        await _saveLoginState(true);

        nameController.clear();
        registerEmailController.clear();
        registerPasswordController.clear();
        registerConfirmPasswordController.clear();

        ToastHelper.showSuccessToast(
            context: context, message: "Registration Successful!");

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const UserEmailAvatarDetailsScreen()));
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "An error occurred";
      ToastHelper.showErrorToast(context: context, message: _errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginWithEmailPassword(BuildContext context) async {
    final String email = loginEmailController.text.trim();
    final String password = loginPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _errorMessage = "Please fill out all fields";
      ToastHelper.showErrorToast(context: context, message: _errorMessage);
      notifyListeners();
      return;
    }

    if (!isValidEmail(email)) {
      _errorMessage = "Invalid email format";
      ToastHelper.showErrorToast(context: context, message: _errorMessage);
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? emailUser = userCredential.user;
      if (emailUser != null) {
        await _saveLoginState(true);

        loginEmailController.clear();
        loginPasswordController.clear();

        ToastHelper.showSuccessToast(
            context: context, message: "Login Successful!");

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "An error occurred";
      ToastHelper.showErrorToast(context: context, message: _errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await _saveLoginState(false);

      ToastHelper.showSuccessToast(
          context: context, message: "Sign Out Successful!");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const GetStartedScreen()));
    } catch (e) {
      ToastHelper.showErrorToast(context: context, message: "Sign Out Failed!");
    }
  }

  final TextEditingController forgetPasswordEmailController =
      TextEditingController();

  Future<void> resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
              email: forgetPasswordEmailController.text.trim())
          .then((value) {
        forgetPasswordEmailController.clear();
        ToastHelper.showSuccessToast(
            context: context,
            message: "Password reset link sent! Check your email");
      });
    } catch (e) {
      ToastHelper.showErrorToast(
          context: context,
          message: "Failed to send reset link. Try again later.");
    }
  }
}
