import 'package:equatable/equatable.dart';

abstract class PackagesEvent extends Equatable {
  const PackagesEvent();

  @override
  List<Object?> get props => [];
}

class LoadPackagesEvent extends PackagesEvent {
  const LoadPackagesEvent();
}

class SearchFieldEvent extends PackagesEvent {
  final String searched;
  const SearchFieldEvent(this.searched);

  @override
  List<Object?> get props => [searched];
}

class FilterEvent extends PackagesEvent {
  final String category;
  const FilterEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class SelectedCardEvent extends PackagesEvent {
  final String packageName;
  const SelectedCardEvent(this.packageName);

  @override
  List<Object?> get props => [packageName];
}