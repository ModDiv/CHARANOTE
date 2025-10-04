// lib/detail_project.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/project_model.dart';

class DetailProject extends StatelessWidget {
  final Project project;

  const DetailProject({super.key, required this.project});

  void _navigateToEdit(BuildContext context) async {
    final updatedProject = await context.push<Project>(
      '/projects/${project.id}/edit',
      extra: project,
    );
    if (updatedProject != null) {
      context.pop(updatedProject);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget thumbnailWidget;
    if (project.thumbnailPathOrUrl != null) {
      if (project.thumbnailType == ThumbnailType.file && project.thumbnailPathOrUrl!.isNotEmpty) {
        thumbnailWidget = Image.file(
          File(project.thumbnailPathOrUrl!),
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
          errorBuilder: (ctx, err, st) => const Center(child: Icon(Icons.broken_image, size: 100, color: Colors.grey)),
        );
      } else if (project.thumbnailType == ThumbnailType.url && project.thumbnailPathOrUrl!.isNotEmpty) {
        thumbnailWidget = Image.network(
          project.thumbnailPathOrUrl!,
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
          loadingBuilder: (ctx, child, progress) => progress == null ? child : const Center(child: CircularProgressIndicator()),
          errorBuilder: (ctx, err, st) => const Center(child: Icon(Icons.error_outline, size: 100, color: Colors.grey)),
        );
      } else {
        thumbnailWidget = const Center(child: Icon(Icons.image, size: 100, color: Colors.grey));
      }
    } else {
      thumbnailWidget = const Center(child: Icon(Icons.image, size: 100, color: Colors.grey));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Thumbnail
            Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 250,
              child: thumbnailWidget,
            ),

            const SizedBox(height: 24),

            // 2. Title Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Title",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 3. Description Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ==================== BAGIAN TOMBOL-TOMBOL UTAMA ====================

            // 5. Tombol View Characters (Aksi sekunder, dipindahkan ke bawah)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.people_alt_outlined),
                label: const Text("View Characters", style: TextStyle(fontWeight: FontWeight.bold)),
                // MENGGUNAKAN STYLE YANG SAMA DENGAN TOMBOL EDIT
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red[300],
                  minimumSize: const Size(double.infinity, 50),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  context.push('/projects/${project.id}/characters');
                },
              ),
            ),

            const SizedBox(height: 12), // Beri jarak antar tombol

            // 4. Tombol Edit (Aksi primer)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Project", style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[300],
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    _navigateToEdit(context);
                  },
                ),
              ),
            ),





            const SizedBox(height: 40), // Jarak di bagian bawah halaman
          ],
        ),
      ),
    );
  }
}
