import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

final userServiceProvider = Provider<UserService>((ref) {
  return UserService(FirebaseFirestore.instance);
});

class UserService {
  final FirebaseFirestore _firestore;

  UserService(this._firestore);

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  /// Create user profile document keyed by Firebase Auth UID.
  Future<void> createUserProfile(UserModel user) async {
    await _usersCollection.doc(user.uid).set(user.toMap());
  }

  /// Stream a single user profile.
  Stream<UserModel?> getUserProfile(String uid) {
    return _usersCollection.doc(uid).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return UserModel.fromMap(doc.data()!, doc.id);
    });
  }

  /// Update the googleEmail field after linking.
  Future<void> updateGoogleEmail(String uid, String googleEmail) async {
    await _usersCollection.doc(uid).update({'googleEmail': googleEmail});
  }

  /// Check if a NIC is already registered.
  Future<bool> isNicRegistered(String nic) async {
    final query = await _usersCollection
        .where('nic', isEqualTo: nic)
        .limit(1)
        .get();
    return query.docs.isNotEmpty;
  }
}
