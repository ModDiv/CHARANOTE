// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:project/character_page.dart'; //
import 'package:project/detail_project.dart';
import 'package:project/form_add_project.dart';
import 'package:project/project_card.dart';
import 'package:project/project_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ==========================================================
  // PASTIKAN SEMUA KODE DI BAWAH INI ADA DI DALAM _HomePageState
  // ==========================================================

  // 1. VARIABEL STATE: Daftar proyek
  final List<Project> _projects = [
    // Data Dummy Awal
    const Project(
      title: "Project Alpha",
      description: "Description of Alpha...",
      date: "14/09/2025",
    ),
    Project(
      title: "Project Beta",
      description: "Details for Beta project...",
      date: "20/10/2025",
      thumbnailPathOrUrl: "https://picsum.photos/seed/beta/400/200",
      thumbnailType: ThumbnailType.url,
    ),
  ];

  // 2. FUNGSI HELPER: Untuk menambah proyek
  void _navigateAndAddProject() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormAddProject()),
    );
    if (result != null && result is Project) {
      setState(() {
        _projects.add(result);
      });
    }
  }

  // 3. FUNGSI HELPER: Untuk menghapus proyek
  void _deleteProject(Project projectToDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Hapus"),
          content: Text("Apakah Anda yakin ingin menghapus '${projectToDelete.title}'?"),
          actions: [
            TextButton(
              child: const Text("Batal"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Hapus"),
              onPressed: () {
                setState(() {
                  _projects.remove(projectToDelete);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // 4. FUNGSI HELPER: Untuk melihat detail & menangani edit
  void _viewProjectDetails(Project project) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailProject(project: project),
      ),
    );
    if (result != null && result is Project) {
      setState(() {
        final index = _projects.indexWhere((p) => p.date == project.date && p.title == project.title);
        if (index != -1) {
          _projects[index] = result;
        }
      });
    }
  }

  // 5. FUNGSI HELPER: Untuk membuka halaman karakter
  void _navigateToCharacterPage(Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CharacterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () { /* Logika untuk menu drawer */ },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () { /* Logika untuk opsi lainnya */ },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _projects.length, // <- Ini sekarang akan valid
        itemBuilder: (context, index) {
          final project = _projects[index]; // <- Ini sekarang akan valid
          return ProjectCard(
            project: project,
            onTap: () {
              _navigateToCharacterPage(project); // <- Ini sekarang akan valid
            },
            onDelete: () {
              _deleteProject(project); // <- Ini sekarang akan valid
            },
            onViewDetails: () {
              _viewProjectDetails(project); // <- Ini sekarang akan valid
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndAddProject, // <- Ini sekarang akan valid
        backgroundColor: Colors.red[400],
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }
}
