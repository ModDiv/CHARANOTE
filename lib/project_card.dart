// lib/project_card.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/project_model.dart';

enum ProjectMenuAction { viewDetails, delete }

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onDelete;
  final VoidCallback onViewDetails;
  final VoidCallback onTap; // Callback untuk tap

  const ProjectCard({
    super.key,
    required this.project,
    required this.onDelete,
    required this.onViewDetails,
    required this.onTap, // onTap sekarang wajib
  });

  // Text Style
  static const TextStyle _titleTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle _descriptionTextStyle = TextStyle(color: Colors.white70);

  @override
  Widget build(BuildContext context) {
    final detailsBackgroundColor = Colors.redAccent[200];
    const topBorderRadius = BorderRadius.vertical(top: Radius.circular(20));
    const bottomBorderRadius = BorderRadius.vertical(bottom: Radius.circular(20));
    const cardBorderRadius = BorderRadius.all(Radius.circular(20));

    //Widget Thumbnail (Logika yang sudah Anda buat sebelumnya)
    Widget thumbnailWidget;
    if (project.thumbnailPathOrUrl != null) {
      if (project.thumbnailType == ThumbnailType.file) {
        thumbnailWidget = Image.file(
          File(project.thumbnailPathOrUrl!),
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
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
          errorBuilder: (context, error, stackTrace) => Container(
            height: 150,
            color: Colors.grey[400],
            child: const Center(child: Icon(Icons.error_outline, size: 50, color: Colors.white54)),
          ),
        );
      } else {
        thumbnailWidget = Container(
          height: 150,
          color: Colors.grey[400],
          child: const Center(child: Icon(Icons.image_outlined, size: 50, color: Colors.white54)),
        );
      }
    } else {
      thumbnailWidget = Container(
        height: 150,
        color: Colors.grey[400],
        child: const Center(child: Icon(Icons.image_not_supported_outlined, size: 50, color: Colors.white54)),
      );
    }

    return Material( // Gunakan Material untuk efek InkWell yang benar di atas shadow
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap, // Panggil callback saat kartu ditekan
        borderRadius: cardBorderRadius,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.grey[300],
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
              ClipRRect(
                borderRadius: topBorderRadius,
                child: thumbnailWidget, // <-- KESALAHAN SEBELUMNYA DI SINI
              ),
              // Kontainer Detail
              Container(
                padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
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
                          Text(project.description, style: _descriptionTextStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    PopupMenuButton<ProjectMenuAction>(
                      onSelected: (ProjectMenuAction action) {
                        if (action == ProjectMenuAction.viewDetails) {
                          onViewDetails();
                        } else if (action == ProjectMenuAction.delete) {
                          onDelete();
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<ProjectMenuAction>>[
                        const PopupMenuItem<ProjectMenuAction>(
                          value: ProjectMenuAction.viewDetails,
                          child: Text('Lihat Detail'),
                        ),
                        const PopupMenuItem<ProjectMenuAction>(
                          value: ProjectMenuAction.delete,
                          child: Text('Hapus'),
                        ),
                      ],
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
