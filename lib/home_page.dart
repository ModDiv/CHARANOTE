// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/project_card.dart';
import 'package:project/project_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Project> _projects = [
    // Data Dummy Awal
    const Project(title: "Project Alpha", description: "Description of Alpha...", date: "14/09/2025"),
    const Project(title: "Project Beta", description: "Details for Beta project...", date: "20/10/2025"),
  ];

  // Controller untuk input field di dialog
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _openAddProjectDialog() {
    // Reset controller setiap kali dialog dibuka
    _titleController.clear();
    _descriptionController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add New Project"),
          content: SingleChildScrollView( // Agar bisa di-scroll jika kontennya panjang
            child: Column(

              children: <Widget>[
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3, // Izinkan beberapa baris untuk deskripsi
                  textInputAction: TextInputAction.done,
                ),
                // Tanggal akan dibuat otomatis, jadi tidak perlu input field
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            ElevatedButton(
              child: const Text("Add"),
              onPressed: () {
                _addNewProject();
                Navigator.of(context).pop(); // Tutup dialog setelah menambahkan
              },
            ),
          ],
        );
      },
    );
  }

  void _addNewProject() {
    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();

    if (title.isNotEmpty) { // Pastikan judul tidak kosong
      // Buat tanggal otomatis (format: dd/MM/yyyy)
      final String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      final newProject = Project(
        title: title.isNotEmpty ? title : "Untittled",
        description: description.isNotEmpty ? description : "No description", // Default jika deskripsi kosong
        date: currentDate,
      );

      setState(() {
        _projects.add(newProject); // Tambahkan proyek baru ke daftar
      });
    }
  }

  void _openMenu() {
    print("Menu button pressed");
  }

  void _openMoreOptions() {
    print("More options button pressed");
  }

  @override
  void dispose() {
    // Penting untuk dispose controller ketika widget tidak lagi digunakan
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _openMenu,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _openMoreOptions,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          // Urutkan proyek berdasarkan tanggal terbaru (opsional)
          // Jika Anda ingin mengurutkan, lakukan sebelum return ProjectCard
          // Misalnya: _projects.sort((a, b) => b.date.compareTo(a.date));
          return ProjectCard(project: project);
        },
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: _openAddProjectDialog, // Panggil fungsi untuk membuka dialog
          child: const Icon(Icons.add, size: 40),
        ),
      ),
    );
  }
}
