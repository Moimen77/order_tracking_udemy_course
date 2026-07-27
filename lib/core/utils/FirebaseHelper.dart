import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ==================== Auth ====================

  static User? get currentUser => auth.currentUser;

  static Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  // ==================== Firestore ====================

  static Future<void> addData({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(collection).add(data);
  }

  static Future<void> setData({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(collection).doc(documentId).set(data);
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getData({
    required String collection,
    required String documentId,
  }) async {
    return await firestore.collection(collection).doc(documentId).get();
  }

  static Future<void> updateData({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(collection).doc(documentId).update(data);
  }

  static Future<void> deleteData({
    required String collection,
    required String documentId,
  }) async {
    await firestore.collection(collection).doc(documentId).delete();
  }
}
