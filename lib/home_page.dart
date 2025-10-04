// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/project_card.dart';
import 'package:project/project_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Project> _projects = [
    const Project(
      id: "proj_alpha_01",
      title: "Project Alpha",
      description: "Description of Alpha...",
      date: "14/09/2025",
      thumbnailPathOrUrl: "https://tse2.mm.bing.net/th/id/OIP.YR1yn7aFn7VSdupqnoOIMAHaEK?cb=12&rs=1&pid=ImgDetMain&o=7&rm=3",
      thumbnailType: ThumbnailType.url,
    ),
    const Project(
      id: "proj_beta_02",
      title: "Project Beta",
      description: "Details for Beta project...",
      date: "20/10/2025",
    ),
  ];

  /// Navigasi ke halaman tambah proyek.
  /// [ROUTE]: Memicu navigasi ke '/projects/add'.
  void _navigateAndAddProject() async {
    // `context.push` akan menampilkan halaman baru di atas halaman saat ini.
    final result = await context.push<Project>('/projects/add');

    // Jika pengguna menyimpan proyek dan kembali, `result` akan berisi data proyek baru.
    if (result != null) {
      setState(() {
        _projects.add(result);
      });
    }
  }

  /// Menampilkan dialog konfirmasi untuk menghapus proyek.
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
              // `context.pop()` digunakan untuk menutup dialog.
              onPressed: () => context.pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Hapus"),
              onPressed: () {
                setState(() {
                  _projects.remove(projectToDelete);
                });
                context.pop(); // Tutup dialog setelah menghapus.
              },
            ),
          ],
        );
      },
    );
  }

  /// Navigasi ke halaman detail proyek.
  /// [ROUTE]: Memicu navigasi ke '/projects/:projectId' (misal: '/projects/proj_alpha_01').
  void _viewProjectDetails(Project project) async {
    final result = await context.push<Project>(
      '/projects/${project.id}',
      extra: project, // menyimpan data2 project
    );

    // isi detail baru tersimpan
    if (result != null) {
      setState(() {
        final index = _projects.indexWhere((p) => p.id == result.id);
        if (index != -1) {
          _projects[index] = result;
        }
      });
    }
  }

  /// Navigasi ke halaman daftar karakter untuk sebuah proyek.
  /// [ROUTE]: Memicu navigasi ke '/projects/:projectId/characters'.
  void _navigateToCharacterPage(Project project) {
    context.push('/projects/${project.id}/characters');
  }

  // --- UI (WIDGET BUILD) ---

  /// UI HomePage.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HOME")),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];

          return ProjectCard(
            project: project,
            onTap: () => _navigateToCharacterPage(project),
            onDelete: () => _deleteProject(project),
            onViewDetails: () => _viewProjectDetails(project),
          );
        },
      ),

      //Button add project
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndAddProject,
        backgroundColor: Colors.red[400],
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }
}
