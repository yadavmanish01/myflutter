import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookmarkRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  BookmarkRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String get _uid {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _bookmarks {
    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('bookmarks');
  }

  // ==========================================================
  // ADD BOOKMARK
  // ==========================================================

  Future<void> addBookmark(String packageName) async {
    await _bookmarks.doc(packageName).set({
      'packageName': packageName,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  // ==========================================================
  // REMOVE BOOKMARK
  // ==========================================================

  Future<void> removeBookmark(String packageName) async {
    await _bookmarks.doc(packageName).delete();
  }

  // ==========================================================
  // CHECK BOOKMARK
  // ==========================================================

  Future<bool> isBookmarked(String packageName) async {
    final document = await _bookmarks.doc(packageName).get();

    return document.exists;
  }

  // GET ALL BOOKMARKS


  Future<List<String>> getBookmarkedPackages() async {
    final snapshot = await _bookmarks
        .orderBy('addedAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => doc.data()['packageName'].toString())
        .toList();
  }
}