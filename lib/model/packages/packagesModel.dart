class PackageModel {
  final String name;
  final String description;
  final String version;
  final int likes;
  final int downloads;
  final int pubPoints;
  final String category;

  final String? publisher;
  final String? repository;
  final String? homepage;
  final String? documentation;

  final List<String> tags;

  final bool isActive;
  final int displayOrder;

  const PackageModel({
    required this.name,
    required this.description,
    required this.version,
    required this.likes,
    required this.downloads,
    required this.pubPoints,
    required this.category,
    required this.publisher,
    required this.repository,
    required this.homepage,
    required this.documentation,
    required this.tags,
    required this.isActive,
    required this.displayOrder,
  });

  PackageModel copyWith({
    String? name,
    String? description,
    String? version,
    int? likes,
    int? downloads,
    int? pubPoints,
    String? category,
    String? publisher,
    String? repository,
    String? homepage,
    String? documentation,
    List<String>? tags,
    bool? isActive,
    int? displayOrder,
  }) {
    return PackageModel(
      name: name ?? this.name,
      description: description ?? this.description,
      version: version ?? this.version,
      likes: likes ?? this.likes,
      downloads: downloads ?? this.downloads,
      pubPoints: pubPoints ?? this.pubPoints,
      category: category ?? this.category,
      publisher: publisher ?? this.publisher,
      repository: repository ?? this.repository,
      homepage: homepage ?? this.homepage,
      documentation: documentation ?? this.documentation,
      tags: tags ?? this.tags,
      isActive: isActive ?? this.isActive,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }
}