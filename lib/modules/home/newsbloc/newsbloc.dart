import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutter/data/api_response.dart';
import 'package:myflutter/model/newsmodel/news_model.dart';
import 'newsState.dart';
import 'news_repository.dart';
import 'newsevent.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc(this.repository) : super(const NewsState()) {
    on<FetchNewsEvent>(_fetchNews);
    on<RefreshNewsEvent>(_fetchNews);
  }

  Future<void> _fetchNews(
      NewsEvent event,
      Emitter<NewsState> emit,
      ) async {
    emit(
      state.copyWith(
        newsList: const ApiResponse.loading(),
      ),
    );

    try {
      final List<NewsModel> news =
      await repository.fetchFlutterNews();
      emit(
        state.copyWith(
          newsList: ApiResponse.completed(news),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          newsList: ApiResponse.error(e.toString()),
        ),
      );
    }
  }
}