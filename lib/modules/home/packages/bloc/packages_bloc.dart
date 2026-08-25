import 'package:bloc/bloc.dart';
import 'package:myflutter/modules/home/packages/bloc/packages_event.dart';
import 'package:myflutter/modules/home/packages/bloc/packages_state.dart';

class PackageBloc extends Bloc<PackagesEvent, PackagesState> {
  PackageBloc() : super(const PackagesState()) {
    on<LoadPackagesEvent>(_loadPackages);
    on<SearchFieldEvent>(_searchPackages);
    on<FilterEvent>(_filterPackages);
  }

  Future<void> _loadPackages(
      LoadPackagesEvent event,
      Emitter<PackagesState> emit,
      ) async {
    // Firebase + pub.dev API yahan connect karenge
  }

  void _searchPackages(
      SearchFieldEvent event,
      Emitter<PackagesState> emit,
      ) {
    // Search logic yahan
  }

  void _filterPackages(
      FilterEvent event,
      Emitter<PackagesState> emit,
      ) {
    // Category filter logic yahan
  }
}