// lib/character_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/character_model.dart';

class CharacterPage extends StatefulWidget {
  final String projectId;
  const CharacterPage({super.key, required this.projectId});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final List<Character> _characters = [
    Character(
        id: "char_1",
        name: "Kael'thas Sunstrider",
        role: "Protagonist / Tragic Hero",
        imageUrl: "https://sportshub.cbsistatic.com/i/2021/10/07/1c40c8f8-d333-4eed-982a-ad5060866503/the-elder-scrolls-v-skyrim.png",
        age: "Over 2,000 years old",
        profession: "Lord of the Blood Elves, Archmage",
        height: "6'3\" (approx. 190 cm)",
        weight: "185 lbs (approx. 84 kg)",
        hairColor: "Blonde",
        eyeColor: "Green (Fel-infused)",
        bodyBuild: "Slender, Athletic",
        nationality: "Quel'Thalas",
        birthPlace: "Silvermoon City",
        catchphrase: "My people's salvation is all that matters!",
        trait1: "Arrogant but brilliant",
        trait2: "Desperate for recognition",
        trait3: "Willing to do anything for his people",
        childhood: "Born into royalty, he was a prodigy in the arcane arts, studying in the magical city of Dalaran. He was destined for greatness but burdened by the expectations of his lineage.",
        wants: "To find a new source of power to sate his people's magical addiction and secure their future.",
        needs: "To overcome his pride and accept help, rather than seeking dangerous and forbidden powers.",
        notes: "Kael'thas's journey is a tragic one. He started as a hero trying to save his people after the destruction of the Sunwell, but his quest led him down a dark path, ultimately making alliances with demons and becoming a villain himself."
    ),
        Character(
        id: "char_2",
        name: "Lina the Slayer",
        role: "Antagonist"
    ),
    Character(
        id: "char_3",
        name: "Rylai the Crystal Maiden",
        role: "Supporting Character"
    ),
  ];

  void _navigateAndAddCharacter() async {
    final result = await context.push<Character>('/projects/${widget.projectId}/characters/add');
    if (result != null) {
      setState(() {
        _characters.add(result);
      });
    }
  }

  void _navigateToCharacterDetail(Character character) async {
    final result = await context.push<dynamic>(
      '/projects/${widget.projectId}/characters/${character.id}',
      extra: character,
    );

    // Periksa tipe hasil yang dikembalikan

    if (result == null) return; // Pengguna  menekan tombol kembali

    if (result is Character) {
      // KARAKTER DI-EDIT
      final int characterIndex = _characters.indexWhere((c) => c.id == result.id);
      if (characterIndex != -1) {
        setState(() {
          _characters[characterIndex] = result;
        });
      }
    } else if (result is Map && result['action'] == 'DELETE') {
      // KARAKTER DI-HAPUS
      final characterToDelete = result['character'] as Character;
      setState(() {
        _characters.removeWhere((c) => c.id == characterToDelete.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Character Library"),
      ),
      body: _characters.isEmpty
          ? const Center(child: Text('No characters yet.\nPress the + button to add one!', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.grey)))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _characters.length,
        itemBuilder: (context, index) {
          final character = _characters[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

              // Foto Profile Karakter
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.red[100],
                backgroundImage: (character.imageUrl != null && character.imageUrl!.isNotEmpty)
                    ? NetworkImage(character.imageUrl!)
                    : null,

                // Tampilkan huruf awal nama jika tidak ada foto
                child: (character.imageUrl == null || character.imageUrl!.isEmpty)
                    ? Text(
                  character.name.isNotEmpty ? character.name[0].toUpperCase() : '?',
                  style: TextStyle(fontSize: 24, color: Colors.red[800]),
                )
                    : null, // Jangan tampilkan teks jika ada gambar
              ),
              // ===================================================================
              title: Text(character.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(character.role, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                _navigateToCharacterDetail(character);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndAddCharacter,
        backgroundColor: Colors.red[400],
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        tooltip: 'Add Character',
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
