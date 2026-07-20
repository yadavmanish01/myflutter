class NewsModel {
  final String title;
  final String description;
  final String link;
  final String imageUrl;
  final String author;
  final String source;
  final DateTime publishedDate;

  const NewsModel({
    required this.title,
    required this.description,
    required this.link,
    required this.imageUrl,
    required this.author,
    required this.source,
    required this.publishedDate,
  });

  NewsModel copyWith({
    String? title,
    String? description,
    String? link,
    String? imageUrl,
    String? author,
    String? source,
    DateTime? publishedDate,
  }) {
    return NewsModel(
      title: title ?? this.title,
      description: description ?? this.description,
      link: link ?? this.link,
      imageUrl: imageUrl ?? this.imageUrl,
      author: author ?? this.author,
      source: source ?? this.source,
      publishedDate: publishedDate ?? this.publishedDate,
    );
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      link: json['link'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      author: json['author'] ?? '',
      source: json['source'] ?? '',
      publishedDate:
      DateTime.tryParse(json['publishedDate'] ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'link': link,
      'imageUrl': imageUrl,
      'author': author,
      'source': source,
      'publishedDate': publishedDate.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'NewsModel(title: $title, source: $source, link: $link)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NewsModel &&
              title == other.title &&
              link == other.link;

  @override
  int get hashCode => title.hashCode ^ link.hashCode;
}