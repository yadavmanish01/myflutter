import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../packages/bloc/packages_bloc.dart';
import '../packages/bloc/packages_event.dart';
import '../packages/bloc/packages_state.dart';
import 'bloc/bookmarks_bloc.dart';
import 'bloc/bookmarks_event.dart';
import 'bloc/bookmarks_state.dart';


class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  @override
  void initState() {
    super.initState();

    // Load user's bookmarks from Firestore
    context.read<BookmarkBloc>().add(
      const LoadBookmarksEvent(),
    );

    // Make sure package data is available
    context.read<PackageBloc>().add(
      const LoadPackagesEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookmarks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, bookmarkState) {
          // ====================================================
          // LOADING
          // ====================================================

          if (bookmarkState.status == BookmarkStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ====================================================
          // ERROR
          // ====================================================

          if (bookmarkState.status == BookmarkStatus.error) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: theme.colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Something went wrong',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      bookmarkState.message,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<BookmarkBloc>().add(
                          const LoadBookmarksEvent(),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          // ====================================================
          // EMPTY
          // ====================================================

          if (bookmarkState.bookmarkedPackages.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      size: 80,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'No Bookmarks Yet',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Save your favorite Flutter packages\n'
                          'and they will appear here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }


          // PACKAGE DATA


          return BlocBuilder<PackageBloc, PackagesState>(
            builder: (context, packageState) {
              if (packageState.status == PackagesStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final bookmarkedPackages =
              packageState.packages.where(
                    (package) {
                  return bookmarkState.bookmarkedPackages
                      .contains(package.name);
                },
              ).toList();



              if (bookmarkedPackages.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 70,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Packages Not Available',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your bookmarks exist, but package data '
                              'could not be loaded.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // ==================================================
              // LIST
              // ==================================================

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<BookmarkBloc>().add(
                    const LoadBookmarksEvent(),
                  );

                  context.read<PackageBloc>().add(
                    const LoadPackagesEvent(),
                  );
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: bookmarkedPackages.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final package = bookmarkedPackages[index];

                    return Card(
                      elevation: 0,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),

                        leading: CircleAvatar(
                          child: const Icon(
                            Icons.extension_outlined,
                          ),
                        ),

                        title: Text(
                          package.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            package.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        trailing: IconButton(
                          tooltip: 'Remove bookmark',
                          onPressed: () {
                            context.read<BookmarkBloc>().add(
                              ToggleBookmarkEvent(
                                package.name,
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.bookmark,
                          ),
                        ),

                        onTap: () {
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}