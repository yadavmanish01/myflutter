import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../model/packages/packagesModel.dart';
import '../../bookmarks/bloc/bookmarks_bloc.dart';
import '../../bookmarks/bloc/bookmarks_event.dart';
import '../../bookmarks/bloc/bookmarks_state.dart';

class PackageDetailsScreen extends StatelessWidget {
  final PackageModel package;

  const PackageDetailsScreen({
    super.key,
    required this.package,
  });

  Future<void> _openUrl(String? url) async {
    if (url == null || url.trim().isEmpty) {
      return;
    }

    final uri = Uri.tryParse(url);

    if (uri == null) {
      return;
    }

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Package Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          BlocBuilder<BookmarkBloc, BookmarkState>(
            builder: (context, state) {
              final isBookmarked =
              state.bookmarkedPackages.contains(package.name);

              return IconButton(
                onPressed: () {
                  context.read<BookmarkBloc>().add(
                    ToggleBookmarkEvent(package.name),
                  );
                },
                icon: Icon(
                  isBookmarked
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            // ==================================================
            // PACKAGE HEADER
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius:
                BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color:
                      Colors.white.withOpacity(.15),
                      borderRadius:
                      BorderRadius.circular(17),
                    ),
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    package.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    package.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color:
                      Colors.white.withOpacity(.14),
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Latest version  ${package.version}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // STATISTICS
            // ==================================================

            Text(
              'Package Statistics',
              style: theme.textTheme.titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.star_outline,
                    title: 'Likes',
                    value: _formatNumber(
                      package.likes,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _StatCard(
                    icon:
                    Icons.download_outlined,
                    title: 'Downloads',
                    value: _formatNumber(
                      package.downloads,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _StatCard(
                    icon:
                    Icons.verified_outlined,
                    title: 'Pub Points',
                    value:
                    package.pubPoints.toString(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ==================================================
            // ABOUT
            // ==================================================

            Text(
              'About Package',
              style: theme.textTheme.titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              package.description,
              style: TextStyle(
                height: 1.6,
                color: theme.colorScheme
                    .onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // PACKAGE INFORMATION
            // ==================================================

            Text(
              'Package Information',
              style: theme.textTheme.titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _DetailTile(
              icon: Icons.tag,
              title: 'Version',
              value: package.version,
            ),

            _DetailTile(
              icon:
              Icons.category_outlined,
              title: 'Category',
              value: package.category,
            ),

            _DetailTile(
              icon:
              Icons.person_outline,
              title: 'Publisher',
              value:
              package.publisher ??
                  'Unknown',
            ),

            _DetailTile(
              icon: Icons.code_outlined,
              title: 'Platform',
              value: 'Flutter / Dart',
            ),

            const SizedBox(height: 25),

            // ==================================================
            // TAGS
            // ==================================================

            if (package.tags.isNotEmpty) ...[
              Text(
                'Tags',
                style: theme.textTheme.titleLarge
                    ?.copyWith(
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: package.tags
                    .map(
                      (tag) => Chip(
                    label: Text(tag),
                  ),
                )
                    .toList(),
              ),

              const SizedBox(height: 25),
            ],

            // ==================================================
            // LINKS
            // ==================================================

            Text(
              'Resources',
              style: theme.textTheme.titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (package.repository != null)
              _LinkTile(
                icon: Icons.code,
                title: 'Repository',
                url: package.repository!,
                onTap: () => _openUrl(
                  package.repository,
                ),
              ),

            if (package.documentation != null)
              _LinkTile(
                icon:
                Icons.menu_book_outlined,
                title: 'Documentation',
                url:
                package.documentation!,
                onTap: () => _openUrl(
                  package.documentation,
                ),
              ),

            if (package.homepage != null)
              _LinkTile(
                icon: Icons.language,
                title: 'Homepage',
                url: package.homepage!,
                onTap: () => _openUrl(
                  package.homepage,
                ),
              ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _openUrl(
                    'https://pub.dev/packages/${package.name}',
                  );
                },
                icon: const Icon(
                  Icons.open_in_new,
                ),
                label: const Text(
                  'View on pub.dev',
                ),
                style:
                ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    }

    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }

    return number.toString();
  }
}

// ============================================================
// STAT CARD
// ============================================================

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius:
        BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outline
              .withOpacity(.12),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 21,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            maxLines: 1,
            overflow:
            TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: theme.colorScheme
                  .onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin:
      const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius:
        BorderRadius.circular(15),
        border: Border.all(
          color: theme.colorScheme.outline
              .withOpacity(.10),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 21,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: theme.colorScheme
                    .onSurfaceVariant,
              ),
            ),
          ),

          Flexible(
            child: Text(
              value,
              textAlign:
              TextAlign.end,
              overflow:
              TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LINK TILE
// ============================================================

class _LinkTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String url;
  final VoidCallback onTap;

  const _LinkTile({
    required this.icon,
    required this.title,
    required this.url,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin:
      const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius:
        BorderRadius.circular(15),
        border: Border.all(
          color: theme.colorScheme.outline
              .withOpacity(.10),
        ),
      ),
      child: ListTile(
        onTap: onTap,

        leading: Icon(
          icon,
          color: theme.colorScheme.primary,
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight:
            FontWeight.w600,
          ),
        ),

        subtitle: Text(
          url,
          maxLines: 1,
          overflow:
          TextOverflow.ellipsis,
        ),

        trailing: const Icon(
          Icons.open_in_new,
          size: 19,
        ),
      ),
    );
  }
}