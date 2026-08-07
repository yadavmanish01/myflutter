import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/quizmodel/question_model.dart';
import '../../../../model/quizmodel/quiz_category_model.dart';


class QuizRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QuizCategoryModel>> getQuizCategories() async {
    final snapshot = await _firestore.collection('quiz').get();

    return snapshot.docs.map((doc) {
      return QuizCategoryModel.fromJson(
        doc.data(),
        doc.id,
      );
    }).toList();
  }

  /// Fetch Questions by Category
  Future<List<QuestionModel>> getQuestions(
      String categoryId) async {
    final snapshot = await _firestore
        .collection('quiz')
        .doc(categoryId)
        .collection('questions')
        .get();

    return snapshot.docs.map((doc) {
      return QuestionModel.fromJson(
        doc.data(),
        doc.id,
      );
    }).toList();
  }
}