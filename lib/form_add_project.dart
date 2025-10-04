// lib/form_add_project.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/project_model.dart';
// Tambahkan import image_picker jika Anda sudah mengimplementasikannya
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

class FormAddProject extends StatefulWidget {
  // 1. Tambahkan Project opsional di konstruktor
  final Project? existingProject;

  const FormAddProject({
    super.key,
    this.existingProject, // 'null' berarti ini adalah mode Tambah
  });

  @override
  State<FormAddProject> createState() => _FormAddProjectState();
}

class _FormAddProjectState extends State<FormAddProject> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Variabel untuk menentukan apakah ini mode edit
  late bool _isEditMode;

  @override
  void initState() {
    super.initState();
    // 2. Cek apakah ada 'existingProject' saat state diinisialisasi
    _isEditMode = widget.existingProject != null;

    if (_isEditMode) {
      // Jika mode edit, isi controller dengan data yang ada
      _titleController.text = widget.existingProject!.title;
      _descriptionController.text = widget.existingProject!.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveProject() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isNotEmpty) {
      Project resultProject;

      if (_isEditMode) {
        // 3. Jika mode edit, buat objek Project baru dengan data yang diperbarui,
        // tapi pertahankan data asli seperti tanggal dan thumbnail.
        resultProject = Project(
          title: title,
          description: description.isNotEmpty ? description : "No description",
          date: widget.existingProject!.date, // Gunakan tanggal asli
          thumbnailPathOrUrl: widget.existingProject!.thumbnailPathOrUrl,
          thumbnailType: widget.existingProject!.thumbnailType,
        );
      } else {
        // Jika mode tambah, buat objek baru seperti sebelumnya
        final currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
        resultProject = Project(
          title: title,
          description: description.isNotEmpty ? description : "No description",
          date: currentDate,
        );
      }
      // Kirim balik objek Project (baik yang baru maupun yang diperbarui)
      Navigator.pop(context, resultProject);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 4. Ubah judul AppBar berdasarkan mode
        title: Text(_isEditMode ? "Edit Project" : "New Project"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Nanti di sini Anda bisa menampilkan preview thumbnail yang sudah ada jika dalam mode edit
              const SizedBox(height: 20),
              const Icon(Icons.image, size: 120, color: Colors.black),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () { /* Logika picker image */ },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                ),
                child: const Text("Change Image"), // Ganti teks jika perlu
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  hintText: "Enter project title",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  hintText: "Enter project description",
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveProject,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
                // 5. Ubah teks tombol berdasarkan mode
                child: Text(_isEditMode ? "Update" : "Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
