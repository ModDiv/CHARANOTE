// lib/detail_character.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/character_model.dart';

class DetailCharacter extends StatelessWidget {
  final Character character;
  final String projectId;

  const DetailCharacter({
    super.key,
    required this.character,
    required this.projectId,
  });

  void _navigateToEdit(BuildContext context) async {
    final updatedCharacter = await context.push<Character>(
      '/projects/$projectId/characters/${character.id}/edit',
      extra: character,
    );
    if (updatedCharacter != null) {
      context.pop(updatedCharacter);
    }
  }

  // FUNGSI UNTUK MENAMPILKAN DIALOG KONFIRMASI HAPUS
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: Text("Are you sure you want to delete '${character.name}'? This action cannot be undone."),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                // Tutup hanya dialog
                dialogContext.pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Delete"),
              onPressed: () {
                // 2. KEMBALI KE HALAMAN SEBELUMNYA DENGAN SINYAL HAPUS
                // Kita akan mengirim string 'DELETE' dan objek karakter yang mau dihapus.
                dialogContext.pop(); // Tutup dialog dulu
                context.pop({'action': 'DELETE', 'character': character});
              },
            ),
          ],
        );
      },
    );
  }

  //style konten data karakter
  Widget _buildInfoRow(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text("$label :", style: TextStyle(color: Colors.grey[700]))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
        ],
      ),
    );
  }

  //style judul section data
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
    );
  }

  //style text data
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

            //menampilkan detail data karakter
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[200],
                backgroundImage: (character.imageUrl != null && character.imageUrl!.isNotEmpty)
                    ? NetworkImage(character.imageUrl!)
                    : null,
                child: (character.imageUrl == null || character.imageUrl!.isEmpty)
                    ? const Icon(Icons.person, size: 80, color: Colors.grey)
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(character.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ),
            Center(
              child: Text(character.role, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey)),
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

            // TOMBOL EDIT
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

            const SizedBox(height: 12), // Jarak antar tombol

            // TOMBOL DELETE
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.delete_outline),
                label: const Text("Delete Character"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Buat transparan
                  foregroundColor: Colors.red, // Warna teks merah
                  elevation: 0, // Hilangkan bayangan
                  side: const BorderSide(color: Colors.red), // Beri border merah
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: () => _confirmDelete(context),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
