import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practical_google_maps_example/core/utils/FirebaseHelper.dart';

class AuthRepo {
  Future<Either<String, UserCredential>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential =
          await FirebaseService.signIn(email: email, password: password);
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      print('Error in signInWithEmailAndPassword: $e');
      return left(e.message ?? 'An error occurred');
    } catch (e) {
      print('Error in signInWithEmailAndPassword: $e');
      return left('An unknown error occurred');
    }
  }

  Future<Either<String, UserCredential>> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential =
          await FirebaseService.signUp(email: email, password: password);
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      print('Error in signUpWithEmailAndPassword: $e');
      return left(e.message ?? 'An error occurred');
    } catch (e) {
      print('Error in signUpWithEmailAndPassword: $e');
      return left('An unknown error occurred');
    }
  }
}
