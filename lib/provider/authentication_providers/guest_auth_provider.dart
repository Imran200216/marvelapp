import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/constants/debounce_helper.dart';
import 'package:marvelapp/modals/user_modal.dart';
import 'package:marvelapp/screens/bottom_nav.dart';
import 'package:marvelapp/screens/details_screens/user_guest_avatar_details_screen.dart';
import 'package:marvelapp/screens/get_started_screen.dart';
import 'package:marvelapp/widgets/toast_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuestAuthenticationProvider extends ChangeNotifier {
  /// debounce helper
  final DebounceHelper debounceHelper = DebounceHelper();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  UserModal? _guestUser;

  UserModal? get guestUser => _guestUser;

  /// Sign in with guest and add to db
  /// Sign in with guest using debounce mechanism
  Future<void> signInWithGuest(BuildContext context) async {
    if (debounceHelper.isDebounced()) return; // Prevent multiple triggers

    try {
      _isLoading = true;
      notifyListeners();

      /// Sign in anonymously
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;

      if (user != null) {
        /// Create a UserModal instance
        _guestUser = UserModal(
          uid: user.uid,
        );

        /// Debounce activated for 2 seconds
        debounceHelper.activateDebounce(duration: const Duration(seconds: 2));

        /// Showing success toast
        ToastHelper.showSuccessToast(
          context: context,
          message: "Authentication Success as Guest!",
        );

        /// Save guest sign-in status to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isSignedInAsGuest', true);

        /// Add guest user to Firestore using UserModal's toJson method
        await FirebaseFirestore.instance
            .collection('userByGuestAuth')
            .doc(user.uid)
            .set(_guestUser!.toJson());

        /// Push to bottom nav bar
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserGuestAvatarDetailsScreen(),
          ),
        );
      }
    } catch (e) {
      /// Prevent multiple error toasts with debounce check
      if (!debounceHelper.isDebounced()) {
        debounceHelper.activateDebounce(duration: const Duration(seconds: 2));

        /// Showing failure toast
        ToastHelper.showErrorToast(
          context: context,
          message: "Failed to authenticate as Guest!",
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sign out with guest and delete their data with debounce mechanism
  Future<void> signOutWithGuest(BuildContext context) async {
    if (debounceHelper.isDebounced()) return;

    _isLoading = true;
    notifyListeners();

    try {
      // Get the current user (guest)
      User? user = _auth.currentUser;

      if (user != null) {
        // Delete guest data from Firestore
        await FirebaseFirestore.instance
            .collection('userByGuestAuth')
            .doc(user.uid)
            .delete();

        // Sign the user out
        await _auth.signOut().then((value) async {
          /// Debounce mechanism activated for 2 seconds to avoid multiple toasts
          debounceHelper.activateDebounce(duration: const Duration(seconds: 2));

          /// Showing success toast
          ToastHelper.showSuccessToast(
            context: context,
            message: "Signed out and guest data deleted successfully!",
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
      }
    } catch (e) {
      /// Debounce mechanism to avoid multiple error toasts
      if (!debounceHelper.isDebounced()) {
        debounceHelper.activateDebounce(duration: const Duration(seconds: 2));

        /// Showing failure toast
        ToastHelper.showErrorToast(
          context: context,
          message: "Failed to sign out or delete data. Please try again.",
        );
      }
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
