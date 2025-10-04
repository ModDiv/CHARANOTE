// lib/character_model.dart

class Character {
  final String id;
  final String name;
  final String role;
  final String? imageUrl;

  // PASTIKAN SEMUA FIELD INI ADA
  final String? age;
  final String? height;
  final String? weight;
  final String? hairColor;
  final String? eyeColor;
  final String? bodyBuild;
  final String? profession;
  final String? nationality;
  final String? birthPlace;
  final String? catchphrase;
  final String? trait1;
  final String? trait2;
  final String? trait3;
  final String? childhood;
  final String? wants;
  final String? needs;
  final String? notes;


  Character({
    required this.id,
    required this.name,
    required this.role,
    this.imageUrl,
    this.age,
    this.height,
    this.weight,
    this.hairColor,
    this.eyeColor,
    this.bodyBuild,
    this.profession,
    this.nationality,
    this.birthPlace,
    this.catchphrase,
    this.trait1,
    this.trait2,
    this.trait3,
    this.childhood,
    this.wants,
    this.needs,
    this.notes,
  });
}
