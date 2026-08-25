import 'package:cloud_firestore/cloud_firestore.dart';

class PackageFirestoreRepository {
  final FirebaseFirestore _firestore;

  PackageFirestoreRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getFeaturedPackages() async {
    final snapshot = await _firestore
        .collection('popular_packages')
        .where('isActive', isEqualTo: true)
        .orderBy('displayOrder')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return {
        'id': doc.id,
        ...data,
      };
    }).toList();
  }
}