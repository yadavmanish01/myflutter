import 'package:equatable/equatable.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object?> get props => [];
}

class ToggleBookmarkEvent extends BookmarkEvent {
  final String packageName;

  const ToggleBookmarkEvent(this.packageName);

  @override
  List<Object?> get props => [packageName];
}

class CheckBookmarkEvent extends BookmarkEvent {
  final String packageName;

  const CheckBookmarkEvent(this.packageName);

  @override
  List<Object?> get props => [packageName];
}

class LoadBookmarksEvent extends BookmarkEvent {
  const LoadBookmarksEvent();
}