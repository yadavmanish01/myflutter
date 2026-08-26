import 'package:equatable/equatable.dart';

enum BookmarkStatus {
  initial,
  loading,
  success,
  error,
}

class BookmarkState extends Equatable {
  final BookmarkStatus status;
  final Set<String> bookmarkedPackages;
  final String message;

  const BookmarkState({
    this.status = BookmarkStatus.initial,
    this.bookmarkedPackages = const {},
    this.message = '',
  });

  BookmarkState copyWith({
    BookmarkStatus? status,
    Set<String>? bookmarkedPackages,
    String? message,
  }) {
    return BookmarkState(
      status: status ?? this.status,
      bookmarkedPackages:
      bookmarkedPackages ?? this.bookmarkedPackages,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    bookmarkedPackages,
    message,
  ];
}