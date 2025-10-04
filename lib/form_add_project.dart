// lib/form_add_project.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project/project_model.dart';

class FormAddProject extends StatefulWidget {
  final Project? existingProject;
  const FormAddProject({super.key, this.existingProject});

  @override
  State<FormAddProject> createState() => _FormAddProjectState();
}

class _FormAddProjectState extends State<FormAddProject> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _dateController = TextEditingController();
  File? _imageFile;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.existingProject != null;
    if (_isEditMode) {
      final project = widget.existingProject!;
      _titleController.text = project.title;
      _descController.text = project.description;
      _dateController.text = project.date;
      if (project.thumbnailType == ThumbnailType.file && project.thumbnailPathOrUrl != null) {
        _imageFile = File(project.thumbnailPathOrUrl!);
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _saveProject() {
    if (_formKey.currentState!.validate()) {
      // 6. BUAT ATAU PERBARUI PROYEK DENGAN ID
      final resultProject = Project(
        id: _isEditMode ? widget.existingProject!.id : DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descController.text,
        date: _dateController.text,
        thumbnailPathOrUrl: _imageFile?.path,
        thumbnailType: _imageFile != null ? ThumbnailType.file : ThumbnailType.none,
      );
      context.pop(resultProject);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Project' : 'Add New Project'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 5,
                validator: (value) => value!.isEmpty ? 'Description is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
                  }
                },
                validator: (value) => value!.isEmpty ? 'Date is required' : null,
              ),
              const SizedBox(height: 24),
              _imageFile == null
                  ? const Text('No image selected.')
                  : Image.file(_imageFile!, height: 150),
              TextButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('Pick Image'),
                onPressed: _pickImage,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveProject,
                child: Text(_isEditMode ? 'Update' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
