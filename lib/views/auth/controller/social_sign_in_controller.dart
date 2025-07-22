import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../controllers/base_controller.dart';
import '../../../services/local_storage/shared_preferences.dart';
import 'auth_controller.dart';

class SocialSignInController extends GetxController {
  RxString userId = "".obs;
  RxString userName = "".obs;
  RxString appleUserName = "".obs;
  RxString userEmail = "".obs;
  RxString userPhoto = "".obs;
  final AuthController authController = Get.find();
  BaseController _baseController = BaseController.instance;
  final AuthPreference _authPreference = AuthPreference.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  Future<void> googleSignOut() async {
    googleSignIn.disconnect();
    // setUserLoggedIn(false);
    // print("")
  }
  Future<void> signInWithGoogle() async {

    try {
      _baseController.showLoading();
      await googleSignOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return; // User canceled sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Get user details
      User? user = userCredential.user;
      if (user != null) {
        userId.value = user.uid; // Google User ID
        userName.value = user.displayName ?? "No Name";
        userEmail.value = user.email ?? "No Email";
        userPhoto.value = user.photoURL ?? "";
        // Get.put(GeneralController().onBottomBarTapped(0));
        // Get.put(AuthController().loginUser(userEmail.value, '', false, userId.value));

      }

      print("User ID: ${userId.value}");
      print("User Name: ${userName.value}");
      print("User Email: ${userEmail.value}");
      print("User Photo: ${userPhoto.value}");
      // authController.signUp(userName.value, userEmail.value, '', false, userId.value,userPhoto.value);
      _baseController.hideLoading();
    } catch (e) {
      _baseController.hideLoading();
      print("Google Sign-In Error: $e");
      // CustomDialog.showErrorDialog(description: e.toString());

    }
  }

  Future<void> signInWithFacebook() async {
    try {
      _baseController.showLoading();

      // Trigger the Facebook Login
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final accessToken = loginResult.accessToken;

        // Create a credential for Firebase
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(accessToken!.tokenString);

        // Sign in to Firebase
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        final User? user = userCredential.user;
        if (user != null) {
          userId.value = user.uid;
          userName.value = user.displayName ?? "No Name";
          userEmail.value = user.email ?? "No Email";
          userPhoto.value = user.photoURL ?? "";

          print("Facebook User ID: ${userId.value}");
          print("Facebook Name: ${userName.value}");
          print("Facebook Email: ${userEmail.value}");
          print("Facebook Photo: ${userPhoto.value}");

          // You can call your backend registration/auth methods here
          // authController.signUp(...);
        }
      } else {
        print("Facebook Sign-In Failed: ${loginResult.status}");
      }

      _baseController.hideLoading();
    } catch (e) {
      _baseController.hideLoading();
      print("Facebook Sign-In Error: $e");
    }
  }

  // Google Sign-Out Function
  Future<void> signOutGoogleSignedInUser() async {
    try {
      await GoogleSignIn().signOut(); // Sign out from Google
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase

      // Clear user data
      userId.value = "";
      userName.value = "";
      userEmail.value = "";
      userPhoto.value = "";

      print("User signed out successfully.");
    } catch (e) {
      print("Sign-Out Error: $e");
    }
  }

  // Future<void> signOutApple() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //
  //     print("Apple Sign-Out successful.");
  //   } catch (e) {
  //     print("Error during Apple Sign-Out: $e");
  //   }
  // }


  // Delete Account Function
  Future<void> deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Re-authenticate before deleting
        GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) return; // User canceled sign-in

        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await user.reauthenticateWithCredential(credential); // Re-authenticate
        await user.delete(); // Delete account

        await GoogleSignIn().signOut();
        await FirebaseAuth.instance.signOut();

        // Clear user data
        userId.value = "";
        userName.value = "";
        userEmail.value = "";
        userPhoto.value = "";

        print("User account deleted successfully.");
      }
    } catch (e) {
      print("Delete Account Error: $e");
    }
  }

  // Future<void> deleteAppleAccount() async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       await user.delete(); // Deletes the user from Firebase Authentication
  //       await AuthPreference.instance.signOutApple(); // Clears stored Apple User ID
  //
  //       print("Apple account deleted successfully.");
  //     } else {
  //       print("No user is currently signed in.");
  //     }
  //   } catch (e) {
  //     print("Error deleting Apple account: $e");
  //   }
  // }


  // Future<void> signInWithApple() async {
  //   try {
  //     _baseController.showLoading();
  //
  //     final AuthorizationCredentialAppleID appleCredential =
  //     await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );
  //
  //     final OAuthCredential credential = OAuthProvider("apple.com").credential(
  //       idToken: appleCredential.identityToken,
  //       accessToken: appleCredential.authorizationCode,
  //     );
  //
  //     UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //     User? user = userCredential.user;
  //     if (user != null) {
  //       userId.value = user.uid;
  //       userName.value = user.displayName ?? appleCredential.givenName ?? "Apple User";
  //       userEmail.value = user.email ?? "No Email";
  //       userPhoto.value = user.photoURL ?? "";
  //       if(userName.value!='Apple User'){
  //         await _authPreference.saveAppleUserName(userName.value);
  //       }
  //       appleUserName.value=(await _authPreference.getAppleUserName())!;
  //
  //       print("User ID: ${userId.value}");
  //       print("User Name: ${userName.value}");
  //       print("User Email: ${userEmail.value}");
  //       print("User Photo: ${userPhoto.value}");
  //       // await AuthPreference.instance.saveAppleUserId(userId.value);
  //       authController.signUpWithApple(appleUserName.value, userEmail.value, userId.value,false ,userPhoto.value);
  //     }
  //
  //     _baseController.hideLoading();
  //   } catch (e) {
  //     _baseController.hideLoading();
  //     print("Apple Sign-In Error: $e");
  //     // CustomDialog.showErrorDialog(description: e.toString());
  //   }
  // }

}
