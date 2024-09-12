import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/modals/user_modal.dart';
import 'package:marvelapp/screens/bottom_nav.dart';
import 'package:marvelapp/screens/details_screens/user_guest_avatar_details_screen.dart';
import 'package:marvelapp/screens/get_started_screen.dart';
import 'package:marvelapp/widgets/toast_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuestAuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// Sign in with guest and add to db
  Future<void> signInWithGuest(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      /// Sign in anonymously
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;

      if (user != null) {
        /// Create a UserModal instance
        UserModal guestModalUser = UserModal(
          uid: user.uid,
        );

        /// showing success toast
        ToastHelper.showSuccessToast(
          context: context,
          message: "Authentication Success as Guest!",
        );

        /// Save guest sign-in status to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isSignedInAsGuest', true);

        /// Add guest user to Fire store using UserModal's toJson method
        await FirebaseFirestore.instance
            .collection('userByGuestAuth')
            .doc(user.uid)
            .set(guestModalUser.toJson());

        /// push to bottom nav bar
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserGuestAvatarDetailsScreen(),
          ),
        );
      }
    } catch (e) {
      /// showing failure toast
      ToastHelper.showErrorToast(
        context: context,
        message: "Failed to authenticate as Guest!",
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sign out with guest
  Future<void> signOutWithGuest(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _auth.signOut().then((value) async {
        /// Showing success toast
        ToastHelper.showSuccessToast(
          context: context,
          message: "Sign Out Successfully!",
        );

        /// Clear guest sign-in status from shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('isSignedInAsGuest');

        /// Navigate to the Get Started Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const GetStartedScreen(),
          ),
        );
      });
    } catch (e) {
      /// Showing failure toast
      ToastHelper.showErrorToast(
        context: context,
        message: "Failed to sign out. Please try again.",
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Check if the user is signed in as guest
  Future<void> checkSignInStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isSignedInAsGuest = prefs.getBool('isSignedInAsGuest') ?? false;

    if (isSignedInAsGuest) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GetStartedScreen(),
        ),
      );
    }
    notifyListeners();
  }
}
