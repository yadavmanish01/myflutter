import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myflutter/data/status.dart';
import 'package:myflutter/utils/appstyles.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../extens/constants.dart';
import '../newsState.dart';
import '../newsbloc.dart';
import '../newsevent.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  Future<void> _openUrl(String url) async {
    debugPrint("Opening: $url");

    final uri = Uri.parse(url);

    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint("Launch Error: $e");
    }
  }

  String _removeHtml(String html) {
    return html.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter News"),
        centerTitle: true,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          switch (state.newsList.status) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case Status.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.newsList.message ?? "Something went wrong",
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        context.read<NewsBloc>().add(
                          FetchNewsEvent(),
                        );
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );

            case Status.completed:
              final news = state.newsList.data ?? [];

              if (news.isEmpty) {
                return const Center(
                  child: Text("No News Available"),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<NewsBloc>().add(
                    RefreshNewsEvent(),
                  );
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    final item = news[index];
                    debugPrint("Image => ${item.imageUrl}");
                    debugPrint("Link => ${item.link}");
                    return Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () => _openUrl(item.link),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              if (item.imageUrl.isNotEmpty)
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(12),
                                  child: Image.network(
                                    item.imageUrl,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (_, __, ___) =>
                                    const SizedBox(),
                                  ),
                                ),

                              if (item.imageUrl.isNotEmpty)
                                const SizedBox(height: 12),

                              Text(
                                item.title,
                                style:AppStyle.title
                              ),
                              10.ph,
                              Text(
                                _removeHtml(item.description),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color:Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                 15.ph,
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).focusColor,
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      item.source,
                                      style:AppStyle.captionbold
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.person,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      item.author,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              10.ph,
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                  ),
                                 6.pw,
                                  Text(
                                    DateFormat('dd MMM yyyy')
                                        .format(item.publishedDate),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}