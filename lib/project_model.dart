enum ThumbnailType { none, file, url }

class Project {
  final String title;
  final String description;
  final String date;
  final String? thumbnailPathOrUrl;
  final ThumbnailType thumbnailType;

  const Project({
    required this.title,
    required this.description,
    required this.date,
    this.thumbnailPathOrUrl,
    this.thumbnailType = ThumbnailType.none,
  });
}
