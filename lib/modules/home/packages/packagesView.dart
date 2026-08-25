import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myflutter/modules/home/packages/bloc/packages_bloc.dart';
import 'package:myflutter/modules/home/packages/bloc/packages_event.dart';
import 'package:myflutter/modules/home/packages/bloc/packages_state.dart';
import 'package:myflutter/modules/home/packages/package_details/packages_detailview.dart';
import 'package:myflutter/utils/appstyles.dart';
import 'package:myflutter/widgets/custom_form_field.dart';
import 'package:myflutter/widgets/emptyDataPage.dart';
import 'package:myflutter/widgets/simpleErrorPage.dart';

import '../../../extens/constants.dart';
import '../../../model/packages/packagesModel.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({super.key});

  static const List<String> categories = [
    'All',
    'State Management',
    'Networking',
    'Firebase',
    'UI',
    'Navigation',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Packages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<PackageBloc, PackagesState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular Flutter Packages',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    6.ph,

                    Text(
                      'Discover useful packages for your Flutter projects.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    10.ph,

                    CustomFormField(
                      prefixIcon: const Icon(Icons.search),
                      hint: 'Search packages...',
                      onChanged: (value) {
                        context.read<PackageBloc>().add(
                          SearchFieldEvent(value),
                        );
                      },
                    ),

                    SizedBox(
                      height: 58,
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          0,
                          12,
                          0,
                          8,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) {
                          return const SizedBox(width: 8);
                        },
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          final selected =
                              state.selectedCategory == category;

                          return ChoiceChip(
                            label: Text(category),
                            selected: selected,
                            onSelected: (_) {
                              context.read<PackageBloc>().add(
                                FilterEvent(category),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // CONTENT
              // ==================================================

              Expanded(
                child: _buildContent(
                  context,
                  state,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(
      BuildContext context,
      PackagesState state,
      ) {
    switch (state.status) {
      case PackagesStatus.initial:
        return const SizedBox();

      case PackagesStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );

      case PackagesStatus.error:
        return SimpleErrorPage(
          message: state.message,
          onRetry: () {
            context.read<PackageBloc>().add(
              const LoadPackagesEvent(),
            );
          },
        );

      case PackagesStatus.success:
        if (state.filteredPackages.isEmpty) {
          return const EmptyDataPage();
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(
            16,
            8,
            16,
            30,
          ),
          itemCount: state.filteredPackages.length,
          itemBuilder: (context, index) {
            final package = state.filteredPackages[index];

            return _buildPackageItem(
              context,
              package,
            );
          },
        );
    }
  }

  Widget _buildPackageItem(
      BuildContext context,
      PackageModel package,
      ) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(
        bottom: 14,
      ),
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(.12),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PackageDetailsScreen(
                package: package,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // PACKAGE NAME + DESCRIPTION
              // ==================================================

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(.10),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.inventory_2_outlined,
                      color: theme.colorScheme.primary,
                      size: 27,
                    ),
                  ),

                  14.pw,

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package.name,
                          style: AppStyle.subheading17,
                        ),

                        5.ph,

                        Text(
                          package.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.caption13,
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),

              16.ph,

              // ==================================================
              // PACKAGE STATS
              // ==================================================

              Row(
                children: [
                  _InfoItem(
                    icon: Icons.star_outline,
                    value: _formatNumber(package.likes),
                  ),

                  18.pw,

                  _InfoItem(
                    icon: Icons.download_outlined,
                    value: _formatNumber(package.downloads),
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'v${package.version}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),

              12.ph,

              // ==================================================
              // CATEGORY
              // ==================================================

              Row(
                children: [
                  Icon(
                    Icons.folder_outlined,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),

                  6.pw,

                  Text(
                    package.category,
                    style: AppStyle.caption,
                  ),

                  const Spacer(),

                  if (package.pubPoints > 0)
                    Text(
                      '${package.pubPoints} points',
                      style: TextStyle(
                        fontSize: 11,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ],
          ),
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


class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: theme.colorScheme.onSurfaceVariant,
        ),

        5.pw,

        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}