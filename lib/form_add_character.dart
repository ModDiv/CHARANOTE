// lib/form_add_character.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/character_model.dart';

class FormAddCharacter extends StatefulWidget {
  final Character? existingCharacter;

  const FormAddCharacter({
    super.key,
    this.existingCharacter, // Jika null, berarti mode Tambah Baru
  });

  @override
  State<FormAddCharacter> createState() => _FormAddCharacterState();
}

class _FormAddCharacterState extends State<FormAddCharacter> {
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _hairController = TextEditingController();
  final TextEditingController _eyeController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _catchphraseController = TextEditingController();
  final TextEditingController _trait1Controller = TextEditingController();
  final TextEditingController _trait2Controller = TextEditingController();
  final TextEditingController _trait3Controller = TextEditingController();
  final TextEditingController _childhoodController = TextEditingController();
  final TextEditingController _wantController = TextEditingController();
  final TextEditingController _needController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  late bool _isEditMode;

  @override
  void initState() {
    super.initState();
    // Cek apakah ini mode edit
    _isEditMode = widget.existingCharacter != null;

    if (_isEditMode) {
      // Jika mode edit, isi semua controller dengan data yang ada
      final char = widget.existingCharacter!;
      _nameController.text = char.name;
      _roleController.text = char.role;
      _ageController.text = char.age ?? '';
      _heightController.text = char.height ?? '';
      _weightController.text = char.weight ?? '';
      _hairController.text = char.hairColor ?? '';
      _eyeController.text = char.eyeColor ?? '';
      _bodyController.text = char.bodyBuild ?? '';
      _professionController.text = char.profession ?? '';
      _birthController.text = char.birthPlace ?? '';
      _nationalityController.text = char.nationality ?? '';
      _catchphraseController.text = char.catchphrase ?? '';
      _trait1Controller.text = char.trait1 ?? '';
      _trait2Controller.text = char.trait2 ?? '';
      _trait3Controller.text = char.trait3 ?? '';
      _childhoodController.text = char.childhood ?? '';
      _wantController.text = char.wants ?? '';
      _needController.text = char.needs ?? '';
      _notesController.text = char.notes ?? '';
    }
  }

  @override
  void dispose() {
    // Dispose semua controller
    _nameController.dispose();
    _roleController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _hairController.dispose();
    _eyeController.dispose();
    _bodyController.dispose();
    _professionController.dispose();
    _birthController.dispose();
    _nationalityController.dispose();
    _catchphraseController.dispose();
    _trait1Controller.dispose();
    _trait2Controller.dispose();
    _trait3Controller.dispose();
    _childhoodController.dispose();
    _wantController.dispose();
    _needController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveCharacter() {
    final name = _nameController.text.trim();
    final role = _roleController.text.trim();

    if (name.isNotEmpty && role.isNotEmpty) {
      final resultCharacter = Character(
        id: _isEditMode ? widget.existingCharacter!.id : DateTime.now().toIso8601String(),
        name: name,
        role: role,
        age: _ageController.text.trim(),
        height: _heightController.text.trim(),
        weight: _weightController.text.trim(),
        hairColor: _hairController.text.trim(),
        eyeColor: _eyeController.text.trim(),
        bodyBuild: _bodyController.text.trim(),
        profession: _professionController.text.trim(),
        nationality: _nationalityController.text.trim(),
        birthPlace: _birthController.text.trim(),
        catchphrase: _catchphraseController.text.trim(),
        trait1: _trait1Controller.text.trim(),
        trait2: _trait2Controller.text.trim(),
        trait3: _trait3Controller.text.trim(),
        childhood: _childhoodController.text.trim(),
        wants: _wantController.text.trim(),
        needs: _needController.text.trim(),
        notes: _notesController.text.trim(),
      );

      // Kirim kembali objek yang sudah dibuat/diperbarui
      context.pop(resultCharacter);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name and Role are required fields.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: true,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? "Edit Character" : "Add New Character"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.image_outlined, size: 80, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_a_photo_outlined),
                    label: Text(_isEditMode ? "Change Image" : "Add Image"),
                    onPressed: () { /* TODO: Image Picker Logic */ },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text("Personal Info", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            _buildTextField("Name", _nameController),
            _buildTextField("Role", _roleController),
            _buildTextField("Age", _ageController),
            _buildTextField("Profession", _professionController),
            _buildTextField("Height", _heightController),
            _buildTextField("Weight", _weightController),
            _buildTextField("Hair Colour", _hairController),
            _buildTextField("Eye Colour", _eyeController),
            _buildTextField("Body Build", _bodyController),
            _buildTextField("Place of Birth", _birthController),
            _buildTextField("Nationality", _nationalityController),
            const SizedBox(height: 24),

            const Text("Personality", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            _buildTextField("Catchphrase", _catchphraseController),
            _buildTextField("Trait 1", _trait1Controller),
            _buildTextField("Trait 2", _trait2Controller),
            _buildTextField("Trait 3", _trait3Controller),
            const SizedBox(height: 24),

            const Text("Background Story", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            _buildTextField("Childhood", _childhoodController, maxLines: 3),
            _buildTextField("What the Character Wants", _wantController, maxLines: 3),
            _buildTextField("What the Character Needs", _needController, maxLines: 3),
            _buildTextField("Notes", _notesController, maxLines: 4),
            const SizedBox(height: 32),

            Center(
              child: ElevatedButton.icon(
                icon: Icon(_isEditMode ? Icons.save_as : Icons.save),
                label: Text(_isEditMode ? "Update Character" : "Save Character"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: _saveCharacter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
