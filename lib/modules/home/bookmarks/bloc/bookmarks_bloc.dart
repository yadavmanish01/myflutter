import 'package:flutter_bloc/flutter_bloc.dart';

import '../bookmarks_repository.dart';
import 'bookmarks_event.dart';
import 'bookmarks_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final BookmarkRepository repository;

  BookmarkBloc({
    required this.repository,
  }) : super(const BookmarkState()) {
    on<ToggleBookmarkEvent>(_toggleBookmark);
    on<CheckBookmarkEvent>(_checkBookmark);
    on<LoadBookmarksEvent>(_loadBookmarks);
  }

  // ==========================================================
  // TOGGLE
  // ==========================================================

  Future<void> _toggleBookmark(
      ToggleBookmarkEvent event,
      Emitter<BookmarkState> emit,
      ) async {
    try {
      final packageName = event.packageName;

      final isBookmarked =
      state.bookmarkedPackages.contains(packageName);

      final updatedBookmarks =
      Set<String>.from(state.bookmarkedPackages);

      if (isBookmarked) {
        await repository.removeBookmark(packageName);

        updatedBookmarks.remove(packageName);

        print('🔖 Removed bookmark: $packageName');
      } else {
        await repository.addBookmark(packageName);

        updatedBookmarks.add(packageName);

        print('🔖 Added bookmark: $packageName');
      }

      emit(
        state.copyWith(
          status: BookmarkStatus.success,
          bookmarkedPackages: updatedBookmarks,
        ),
      );
    } catch (e) {
      print('❌ Bookmark error: $e');

      emit(
        state.copyWith(
          status: BookmarkStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  // ==========================================================
  // CHECK SINGLE BOOKMARK
  // ==========================================================

  Future<void> _checkBookmark(
      CheckBookmarkEvent event,
      Emitter<BookmarkState> emit,
      ) async {
    try {
      final isBookmarked =
      await repository.isBookmarked(event.packageName);

      final updatedBookmarks =
      Set<String>.from(state.bookmarkedPackages);

      if (isBookmarked) {
        updatedBookmarks.add(event.packageName);
      } else {
        updatedBookmarks.remove(event.packageName);
      }

      emit(
        state.copyWith(
          status: BookmarkStatus.success,
          bookmarkedPackages: updatedBookmarks,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BookmarkStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  // ==========================================================
  // LOAD ALL BOOKMARKS
  // ==========================================================

  Future<void> _loadBookmarks(
      LoadBookmarksEvent event,
      Emitter<BookmarkState> emit,
      ) async {
    emit(
      state.copyWith(
        status: BookmarkStatus.loading,
      ),
    );

    try {
      final bookmarks =
      await repository.getBookmarkedPackages();

      emit(
        state.copyWith(
          status: BookmarkStatus.success,
          bookmarkedPackages: bookmarks.toSet(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BookmarkStatus.error,
          message: e.toString(),
        ),
      );
    }
  }
}