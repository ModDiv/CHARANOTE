// lib/character_page.dart
import 'package:flutter/material.dart';
import 'package:project/character_model.dart';
import 'package:project/form_add_character.dart';
import 'package:project/detail_character.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final List<Character> _characters = [
    Character(id: "1", name: "Kael'thas Sunstrider", role: "Protagonist"),
    Character(id: "2", name: "Lina the Slayer", role: "Antagonist"),
    Character(id: "3", name: "Rylai the Crystal Maiden", role: "Supporting Character"),
  ];

  void _navigateAndAddCharacter() async {
    final result = await Navigator.push<Character>(
      context,
      MaterialPageRoute(builder: (context) => const FormAddCharacter()),
    );
    if (result != null) {
      setState(() {
        _characters.add(result);
      });
    }
  }

  void _navigateToCharacterDetail(Character character) async {
    final int characterIndex = _characters.indexOf(character);

    final result = await Navigator.push<Character>(
      context,
      MaterialPageRoute(
        builder: (context) => DetailCharacter(character: character),
      ),
    );

    if (result != null) {
      setState(() {
        if (characterIndex != -1) {
          _characters[characterIndex] = result;
        }
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
          ? const Center(
        child: Text(
          'No characters yet.\nPress the + button to add one!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
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
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.red[100],
                child: Text(
                  character.name.isNotEmpty ? character.name[0].toUpperCase() : '?',
                  style: TextStyle(fontSize: 24, color: Colors.red[800]),
                ),
              ),
              title: Text(
                character.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                character.role,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
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
