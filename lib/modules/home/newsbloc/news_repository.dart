import 'dart:async';

import 'package:dio/dio.dart';
import 'package:myflutter/model/newsmodel/news_model.dart';
import 'package:myflutter/widgets/app_logger.dart';
import 'package:webfeed_plus/webfeed_plus.dart';

import '../../../network/network_api_services.dart';

class NewsRepository {
  final NetworkApiService _api = NetworkApiService();

  static const List<Map<String, String>> rssFeeds = [
    {
      "name": "Flutter Community",
      "url": "https://medium.com/feed/flutter-community",
    },
    {
      "name": "Dart",
      "url": "https://medium.com/feed/dartlang",
    },
    {
      "name": "Flutter Awesome",
      "url": "https://flutterawesome.com/feed/",
    },
    {
      "name": "Flutter GitHub",
      "url": "https://github.com/flutter/flutter/releases.atom",
    },
    {
      "name": "Dart GitHub",
      "url": "https://github.com/dart-lang/sdk/releases.atom",
    },
    {
      "name": "Android Developers",
      "url": "https://android-developers.googleblog.com/feeds/posts/default",
    },
  ];

  Future<List<NewsModel>> fetchFlutterNews() async {
    final futures = rssFeeds.map(
          (feed) => _fetchFeed(
        feed["url"]!,
        feed["name"]!,
      ),
    );
    final results = await Future.wait(futures);
    final List<NewsModel> news =
    results.expand((e) => e).toList();

    final Map<String, NewsModel> unique = {};

    for (final article in news) {
      if (article.link.isNotEmpty) {
        unique[article.link] = article;
      }
    }

    final list = unique.values.toList();

    list.sort(
          (a, b) => b.publishedDate.compareTo(a.publishedDate),
    );

    logger.d("Repository Returned ${list.length} items");

    return list;
  }

  Future<List<NewsModel>> _fetchFeed(
      String url,
      String source,
      ) async {
    try {
      logger.d("Loading : $source");
      final response = await _api.GetApi(
        url,
        responseType: ResponseType.plain,
      );

      final String xml = response.toString();

      /// ---------------- RSS ----------------
      try {
        final rss = RssFeed.parse(xml);

        if (rss.items != null && rss.items!.isNotEmpty) {
          return rss.items!.map((item) {
            return NewsModel(
              source: source,
              title: item.title ?? "",
              description: item.description ?? "",
              link: item.link ?? "",
              imageUrl: _extractImage(item.description ?? ""),
              author: item.author ?? source,
              publishedDate:
              item.pubDate ?? DateTime.now(),
            );
          }).toList();
        }
      } catch (_) {}

      /// ---------------- Atom ----------------
      try {
        final atom = AtomFeed.parse(xml);

        if (atom.items != null &&
            atom.items!.isNotEmpty) {
          return atom.items!.map((item) {
            return NewsModel(
              source: source,
              title: item.title ?? "",
              description: item.content ?? item.summary ?? "",
              link: item.links != null &&
                  item.links!.isNotEmpty
                  ? item.links!.first.href ?? ""
                  : "",
              imageUrl: "",
              author: item.authors != null &&
                  item.authors!.isNotEmpty
                  ? item.authors!.first.name ??
                  source
                  : source,
              publishedDate:
              item.updated ?? DateTime.now(),
            );
          }).toList();
        }
      } catch (_) {}

      logger.i("⚠ Unsupported Feed : $source");

      return [];
    } catch (e) {
      logger.e(" Feed Error : $source");
      logger.e(e);

      return [];
    }
  }

  String _extractImage(String html) {
    final imageRegex = RegExp(
      r'<img[^>]+src="([^">]+)"',
      caseSensitive: false,
    );

    final match = imageRegex.firstMatch(html);

    if (match != null) {
      return match.group(1) ?? "";
    }

    return "";
  }
}