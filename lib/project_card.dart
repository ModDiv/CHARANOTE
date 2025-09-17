// lib/project_card.dart
import 'dart:io'; // Untuk File
import 'package:flutter/material.dart';
import 'package:project/project_model.dart'; // Pastikan path ini benar

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  // Text Style
  static const TextStyle _titleTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle _descriptionTextStyle = TextStyle(color: Colors.white70);
  static const TextStyle _dateTextStyle = TextStyle(color: Colors.white70);


  @override
  //Widget Card
  Widget build(BuildContext context) {
    final cardBackgroundColor = Colors.grey[300];
    // final imagePlaceholderColor = Colors.grey[400];
    final detailsBackgroundColor = Colors.red[600];
    const cardBorderRadius = BorderRadius.all(Radius.circular(20));
    const topBorderRadius = BorderRadius.vertical(top: Radius.circular(20));
    const bottomBorderRadius = BorderRadius.vertical(bottom: Radius.circular(20));

    //Widget Thumbnail
    Widget thumbnailWidget;
    if (project.thumbnailPathOrUrl != null) {
      if (project.thumbnailType == ThumbnailType.file) {
        thumbnailWidget = Image.file(
          File(project.thumbnailPathOrUrl!),
          height: 150,
          width: double.infinity, // Agar mengisi lebar kontainer
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container( // Placeholder jika error load file
            height: 150,
            color: Colors.grey[400],
            child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.white54)),
          ),
        );
      } else if (project.thumbnailType == ThumbnailType.url) {
        thumbnailWidget = Image.network(
          project.thumbnailPathOrUrl!,
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 150,
              color: Colors.grey[400],
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container( // Placeholder jika error load URL
            height: 150,
            color: Colors.grey[400],
            child: const Center(child: Icon(Icons.error_outline, size: 50, color: Colors.white54)),
          ),
        );
      } else {

        // ThumbnailType.none atau tidak diset
        thumbnailWidget = Container( // Placeholder default jika tidak ada thumbnail
          height: 150,
          color: Colors.grey[400],
          child: const Center(child: Icon(Icons.image_outlined, size: 50, color: Colors.white54)),
        );
      }
    } else {
      thumbnailWidget = Container( // Placeholder default jika path/URL null
        height: 150,
        color: Colors.grey[400],
        child: const Center(child: Icon(Icons.image_not_supported_outlined, size: 50, color: Colors.white54)),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: cardBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Widget Thumbnail
          ClipRRect( // Untuk memastikan border radius diterapkan pada gambar
            borderRadius: topBorderRadius,
            child: thumbnailWidget,
          ),
          // Kontainer Detail
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: detailsBackgroundColor,
              borderRadius: bottomBorderRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project.title, style: _titleTextStyle),
                      const SizedBox(height: 4),
                      Text(project.description, style: _descriptionTextStyle, maxLines: 2, overflow: TextOverflow.ellipsis), // Batasi deskripsi jika terlalu panjang
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(project.date, style: _dateTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

