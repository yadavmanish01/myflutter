import 'package:bloc/bloc.dart';

import 'package:myflutter/modules/home/packages/bloc/packages_event.dart';
import 'package:myflutter/modules/home/packages/bloc/packages_state.dart';
import '../../../../model/packages/packagesModel.dart';
import '../firestore_repository/firestore_repository.dart';
import '../pub_repository/pub_repository.dart';


class PackageBloc extends Bloc<PackagesEvent, PackagesState> {
  final PackageFirestoreRepository firestoreRepository;
  final PackagePubRepository pubRepository;

  PackageBloc({
    required this.firestoreRepository,
    required this.pubRepository,
  }) : super(const PackagesState()) {
    on<LoadPackagesEvent>(_loadPackages);
    on<SearchFieldEvent>(_searchPackages);
    on<FilterEvent>(_filterPackages);
  }

  // ==========================================================
  // LOAD PACKAGES
  // ==========================================================

  Future<void> _loadPackages(
      LoadPackagesEvent event,
      Emitter<PackagesState> emit,
      ) async {
    print('🔥 LOAD PACKAGES EVENT RECEIVED');

    emit(
      state.copyWith(
        status: PackagesStatus.loading,
        message: '',
      ),
    );

    try {
      // ========================================================
      // 1. FIRESTORE
      // ========================================================

      print('🔥 Fetching packages from Firestore...');

      final firebasePackages =
      await firestoreRepository.getFeaturedPackages();

      print(
        '🔥 Firestore packages: ${firebasePackages.length}',
      );

      if (firebasePackages.isEmpty) {
        emit(
          state.copyWith(
            status: PackagesStatus.success,
            packages: const [],
            filteredPackages: const [],
          ),
        );

        return;
      }

      // ========================================================
      // 2. PUB.DEV
      // ========================================================

      final List<PackageModel> packages = [];

      for (final firebasePackage in firebasePackages) {
        final packageName =
        firebasePackage['packageName']?.toString();

        if (packageName == null || packageName.isEmpty) {
          print('⚠️ Package name missing');
          continue;
        }

        try {
          print(
            '🔥 Fetching pub.dev: $packageName',
          );

          // ----------------------------------------------------
          // Package Info
          // ----------------------------------------------------

          final packageInfo =
          await pubRepository.getPackageInfo(
            packageName,
          );

          // ----------------------------------------------------
          // Package Score
          // ----------------------------------------------------

          final packageScore =
          await pubRepository.getPackageScore(
            packageName,
          );

          // ----------------------------------------------------
          // Publisher
          // ----------------------------------------------------

          final publisherData =
          await pubRepository.getPublisher(
            packageName,
          );

          // ====================================================
          // INFO DATA
          // ====================================================

          final latest =
              packageInfo['latest'] as Map<String, dynamic>? ?? {};

          final pubspec =
              latest['pubspec'] as Map<String, dynamic>? ?? {};

          final name =
              pubspec['name']?.toString() ?? packageName;

          final description =
              pubspec['description']?.toString() ?? '';

          final version =
              latest['version']?.toString() ?? '';

          // ====================================================
          // SCORE DATA
          // ====================================================

          final likes =
              (packageScore['likeCount'] as num?)?.toInt() ?? 0;

          final downloads =
              (packageScore['downloadCount30Days'] as num?)
                  ?.toInt() ??
                  0;

          final pubPoints =
              (packageScore['grantedPoints'] as num?)?.toInt() ?? 0;

          // ====================================================
          // TAGS
          // ====================================================

          final tagsData = packageScore['tags'];

          final List<String> tags =
          tagsData is List
              ? tagsData
              .map((tag) => tag.toString())
              .toList()
              : [];

          // ====================================================
          // LINKS
          // ====================================================

          final repository =
          pubspec['repository']?.toString();

          final homepage =
          pubspec['homepage']?.toString();

          final documentation =
          pubspec['documentation']?.toString();

          // ====================================================
          // PUBLISHER
          // ====================================================

          final publisher =
          publisherData['publisherId']?.toString();

          // ====================================================
          // FIRESTORE DATA
          // ====================================================

          final category =
              firebasePackage['category']?.toString() ?? 'Other';

          final isActive =
              firebasePackage['isActive'] == true;

          final displayOrder =
              (firebasePackage['displayOrder'] as num?)
                  ?.toInt() ??
                  0;

          // ====================================================
          // CREATE MODEL
          // ====================================================

          final package = PackageModel(
            name: name,
            description: description,
            version: version,
            likes: likes,
            downloads: downloads,
            pubPoints: pubPoints,
            category: category,
            publisher: publisher,
            repository: repository,
            homepage: homepage,
            documentation: documentation,
            tags: tags,
            isActive: isActive,
            displayOrder: displayOrder,
          );

          // ====================================================
          // ADD PACKAGE
          // ====================================================

          packages.add(package);

          print(
            '✅ Loaded: $packageName',
          );
        } catch (e) {
          print(
            '❌ Failed: $packageName -> $e',
          );
        }
      }

      // ==========================================================
      // 3. SUCCESS
      // ==========================================================

      print(
        '🔥 FINAL PACKAGE COUNT: ${packages.length}',
      );

      emit(
        state.copyWith(
          status: PackagesStatus.success,
          packages: packages,
          filteredPackages: packages,
        ),
      );
    } catch (e) {
      print(
        '❌ PACKAGE ERROR: $e',
      );

      emit(
        state.copyWith(
          status: PackagesStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  // ==========================================================
  // SEARCH
  // ==========================================================

  void _searchPackages(
      SearchFieldEvent event,
      Emitter<PackagesState> emit,
      ) {
    final query =
    event.searched.trim().toLowerCase();

    final filtered = _applyFilters(
      packages: state.packages,
      query: query,
      category: state.selectedCategory,
    );

    emit(
      state.copyWith(
        searchQuery: query,
        filteredPackages: filtered,
      ),
    );
  }

  // ==========================================================
  // FILTER
  // ==========================================================

  void _filterPackages(
      FilterEvent event,
      Emitter<PackagesState> emit,
      ) {
    final filtered = _applyFilters(
      packages: state.packages,
      query: state.searchQuery,
      category: event.category,
    );

    emit(
      state.copyWith(
        selectedCategory: event.category,
        filteredPackages: filtered,
      ),
    );
  }

  // ==========================================================
  // COMMON FILTER
  // ==========================================================

  List<PackageModel> _applyFilters({
    required List<PackageModel> packages,
    required String query,
    required String category,
  }) {
    return packages.where((package) {
      final matchesSearch =
          query.isEmpty ||
              package.name
                  .toLowerCase()
                  .contains(query) ||
              package.description
                  .toLowerCase()
                  .contains(query);

      final matchesCategory =
          category == 'All' ||
              package.category == category;

      return matchesSearch && matchesCategory;
    }).toList();
  }
}

