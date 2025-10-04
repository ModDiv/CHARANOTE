// lib/detail_project.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/form_add_project.dart';
import 'package:project/project_model.dart';

class DetailProject extends StatelessWidget {
  final Project project;

  const DetailProject({super.key, required this.project});

  void _navigateToEdit(BuildContext context) async {
    final updatedProject = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormAddProject(existingProject: project),
      ),
    );

    if (updatedProject != null) {
      Navigator.pop(context, updatedProject);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget untuk menampilkan thumbnail (Logika ini sudah benar)
    Widget thumbnailWidget;
    if (project.thumbnailPathOrUrl != null) {
      if (project.thumbnailType == ThumbnailType.file) {
        thumbnailWidget = Image.file(
          File(project.thumbnailPathOrUrl!),
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
          errorBuilder: (ctx, err, st) => const Center(child: Icon(Icons.broken_image, size: 100)),
        );
      } else if (project.thumbnailType == ThumbnailType.url) {
        thumbnailWidget = Image.network(
          project.thumbnailPathOrUrl!,
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
          loadingBuilder: (ctx, child, progress) => progress == null ? child : const Center(child: CircularProgressIndicator()),
          errorBuilder: (ctx, err, st) => const Center(child: Icon(Icons.error_outline, size: 100)),
        );
      } else {
        thumbnailWidget = const Center(child: Icon(Icons.image_not_supported, size: 100));
      }
    } else {
      thumbnailWidget = const Center(child: Icon(Icons.image, size: 100));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
      ),
      body: SingleChildScrollView(
        // ===== PERUBAHAN UTAMA ADA DI SINI =====
        // Kita akan menempatkan semua widget langsung di dalam satu Column.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Ratakan semua teks ke kiri
          children: [
            // 1. Thumbnail
            Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 250,
              child: thumbnailWidget,
            ),

            const SizedBox(height: 24), // Beri jarak dari thumbnail ke konten

            // 2. Title Section (Langsung di dalam Column utama)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
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

            // 3. Description Section (Langsung di dalam Column utama)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.description,
                    style: const TextStyle(fontSize: 16, height: 1.5), // Beri sedikit jarak antar baris
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 4. Edit Button (Langsung di dalam Column utama)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text(
                    "Edit Project",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[300], // Sesuaikan warna agar cocok
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50), // Buat tombol lebih lebar
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    _navigateToEdit(context);
                  },
                ),
              ),
            ),
            const SizedBox(height: 40), // Beri jarak di bagian bawah
          ],
        ),
      ),
    );
  }
}
