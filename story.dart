import 'package:hive/hive.dart';

part 'story.g.dart';

@HiveType(typeId: 0)
class Story {
  @HiveField(0)
  String title;
  
  @HiveField(1)
  List<String> pages;
  
  @HiveField(2)
  List<String> images;
  
  @HiveField(3)
  DateTime createdAt;
  
  @HiveField(4)
  String theme;

  Story({
    required this.title,
    required this.pages,
    required this.images,
    required this.theme,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Helper method to get the first page text as a short title
  String get shortTitle {
    if (pages.isNotEmpty) {
      String firstPage = pages.first;
      // Take first 30 characters and add ellipsis if longer
      return firstPage.length > 30 
          ? '${firstPage.substring(0, 30)}...' 
          : firstPage;
    }
    return title;
  }

  // Helper method to get the first image as thumbnail
  String? get thumbnailImage {
    return images.isNotEmpty ? images.first : null;
  }

  // Copy method for Hive compatibility
  Story copyWith({
    String? title,
    List<String>? pages,
    List<String>? images,
    String? theme,
    DateTime? createdAt,
  }) {
    return Story(
      title: title ?? this.title,
      pages: pages ?? this.pages,
      images: images ?? this.images,
      theme: theme ?? this.theme,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Story(title: $title, pages: ${pages.length}, images: ${images.length}, theme: $theme, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Story &&
        other.title == title &&
        other.theme == theme &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return title.hashCode ^ theme.hashCode ^ createdAt.hashCode;
  }
}
