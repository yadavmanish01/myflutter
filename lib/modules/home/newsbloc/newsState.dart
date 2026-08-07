import 'package:equatable/equatable.dart';
import 'package:myflutter/data/api_response.dart';
import 'package:myflutter/model/newsmodel/news_model.dart';

class NewsState extends Equatable {
  final ApiResponse<List<NewsModel>> newsList;

  const NewsState({
    this.newsList = const ApiResponse.loading(),
  });

  NewsState copyWith({
    ApiResponse<List<NewsModel>>? newsList,
  }) {
    return NewsState(
      newsList: newsList ?? this.newsList,
    );
  }

  @override
  List<Object?> get props => [newsList];
}