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

  Future<void> saveQuizResult({
    required String userId,
    required String quizId,
    required String quizTitle,
    required int totalQuestions,
    required int correct,
    required int wrong,
    required int skipped,
    required double percentage,
    required int timeTaken,
  }) async {
    await _firestore.collection('quizResults').add({
      'userId': userId,
      'quizId': quizId,
      'quizTitle': quizTitle,
      'totalQuestions': totalQuestions,
      'correct': correct,
      'wrong': wrong,
      'skipped': skipped,
      'score': correct,
      'percentage': percentage,
      'timeTaken': timeTaken,
      'submittedAt': FieldValue.serverTimestamp(),
    });
  }
}