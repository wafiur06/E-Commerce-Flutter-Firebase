import 'package:bloc_app/src/data/models/user_model.dart';
import 'package:bloc_app/src/data/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Starts the Google Sign-In process
  Future<User?> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize();

      final GoogleSignInAccount googleSignInAccount = await googleSignIn
          .authenticate();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(
        credential,
      );

      debugPrint('User: ${authResult.user?.email}');

      if (authResult.user != null) {
        await createUserInDatabase(authResult.user!, null);
      }

      return authResult.user;
    } catch (error) {
      debugPrint("Error signing in with Google: $error");
      throw Exception(error);
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      // 1. Request explicit permissions (email is crucial for Firebase)
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );

      if (result.status == LoginStatus.success) {
        // 2. Fix: Use '.token' to get the actual String string
        final OAuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken!.tokenString,
        );

        final UserCredential authResult = await _auth.signInWithCredential(
          credential,
        );
        debugPrint("facebook login success: ${authResult.user?.displayName}");
        return authResult.user;
      } else {
        debugPrint("facebook login failed: ${result.message}");
        return null;
      }
    } catch (e) {
      debugPrint("Error signing in with Facebook: $e");
      throw Exception(e);
    }
  }

  Future<User?> signInWithTwitter() async {
    try {
      final TwitterLogin twitterLogin = TwitterLogin(
        apiKey: TWITTER_API_KEY,
        apiSecretKey: TWITTER_SECRET_KEY,
        redirectURI: 'bloc-ecommerce://',
      );
      final result = await twitterLogin.loginV2();

      debugPrint('Twitter login result: ${result.user?.name}');

      if (result.status == TwitterLoginStatus.loggedIn) {
        final credential = TwitterAuthProvider.credential(
          accessToken: result.authToken!,
          secret: result.authTokenSecret!,
        );
        final UserCredential authResult = await _auth.signInWithCredential(
          credential,
        );
        debugPrint('Twitter login success: ${authResult.user?.displayName}');
        return authResult.user;
      } else {
        debugPrint('Twitter login failed: ${result.errorMessage}');
        return null;
      }
    } catch (e) {
      debugPrint('Error signing in with Twitter: $e');
      throw Exception(e);
    }
  }

  Future<User?> signInWithEmail(String email, String password) async {
    try{
     final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
     return userCredential.user;
    }catch(e){
      throw Exception(e);
    }
  }


  Future<void> createUserInDatabase(User user, String? username) async {
    final data = UserModel(
      userName: user.displayName ?? username,
      email: user.email,
      photoUrl: user.photoURL,
      phoneNumber: user.phoneNumber,
    );

    await _firestore.collection('users').doc(user.uid).set(data.toJson()).then((
      value,
    ) {
      debugPrint('User created in database ${user.uid}');
    });
  }

  Future<void> signoutUser() async {
    await _auth.signOut();
  }

  Future<User?> signUpWIthEmail(String email, String password, String username) async {
    try{
      final credintial = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credintial.user;
      if (user != null) {
        await createUserInDatabase(user, username);
      }

      return user;
    }catch(e){
      debugPrint('Error signing up with email: $e');
      throw Exception(e);
    }
  }
}
