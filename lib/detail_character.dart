// lib/detail_character.dart
import 'package:flutter/material.dart';
import 'package:project/character_model.dart';
import 'package:project/form_add_character.dart';

class DetailCharacter extends StatelessWidget {
  final Character character;

  const DetailCharacter({super.key, required this.character});

  void _navigateToEdit(BuildContext context) async {
    final updatedCharacter = await Navigator.push<Character>(
      context,
      MaterialPageRoute(
        builder: (context) => FormAddCharacter(existingCharacter: character),
      ),
    );
    if (updatedCharacter != null) {
      Navigator.pop(context, updatedCharacter);
    }
  }

  Widget _buildInfoRow(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label :",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
      ),
    );
  }

  Widget _buildParagraph(String label, String text) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(text, style: const TextStyle(height: 1.4)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.person, size: 80, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                character.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                character.role,
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
              ),
            ),
            _buildSectionTitle("Personal Info"),
            _buildInfoRow("Age", character.age ?? ""),
            _buildInfoRow("Profession", character.profession ?? ""),
            _buildInfoRow("Height", character.height ?? ""),
            _buildInfoRow("Weight", character.weight ?? ""),
            _buildInfoRow("Hair Colour", character.hairColor ?? ""),
            _buildInfoRow("Eye Colour", character.eyeColor ?? ""),
            _buildInfoRow("Body Build", character.bodyBuild ?? ""),
            _buildInfoRow("Nationality", character.nationality ?? ""),
            _buildInfoRow("Place of Birth", character.birthPlace ?? ""),

            _buildSectionTitle("Personality"),
            _buildInfoRow("Catchphrase", character.catchphrase ?? ""),
            _buildInfoRow("Trait 1", character.trait1 ?? ""),
            _buildInfoRow("Trait 2", character.trait2 ?? ""),
            _buildInfoRow("Trait 3", character.trait3 ?? ""),

            _buildSectionTitle("Background"),
            _buildParagraph("Childhood", character.childhood ?? ""),
            _buildParagraph("What the Character Wants", character.wants ?? ""),
            _buildParagraph("What the Character Needs", character.needs ?? ""),
            _buildParagraph("Notes", character.notes ?? ""),
            const SizedBox(height: 32),

            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("Edit Character"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: () => _navigateToEdit(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
