import 'package:equatable/equatable.dart';
import '../../../../model/packages/packagesModel.dart';

enum PackagesStatus {
  initial,
  loading,
  success,
  error,
}

class PackagesState extends Equatable {
  final PackagesStatus status;
  final List<PackageModel> packages;
  final List<PackageModel> filteredPackages;
  final String selectedCategory;
  final String searchQuery;
  final String message;

  const PackagesState({
    this.status = PackagesStatus.initial,
    this.packages = const [],
    this.filteredPackages = const [],
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.message = '',
  });

  PackagesState copyWith({
    PackagesStatus? status,
    List<PackageModel>? packages,
    List<PackageModel>? filteredPackages,
    String? selectedCategory,
    String? searchQuery,
    String? message,
  }) {
    return PackagesState(
      status: status ?? this.status,
      packages: packages ?? this.packages,
      filteredPackages: filteredPackages ?? this.filteredPackages,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    packages,
    filteredPackages,
    selectedCategory,
    searchQuery,
    message,
  ];
}