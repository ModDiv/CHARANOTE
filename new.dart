import 'package:flutter/material.dart';
import 'package:project/project_card.dart'; // Assuming you create project_card.dart
import 'package:project/project_model.dart'; // Import the model

class HomePage extends StatefulWidget {
  // Changed to StatefulWidget for future data changes
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Example: Replace with your actual data source later
  final List<Project> _projects = [
    const Project(title: "Project Alpha",
        description: "Description of Alpha...",
        date: "14/09/25"),
    const Project(title: "Project Beta",
        description: "Details for Beta project...",
        date: "20/10/25"),
    const Project(title: "Project Gamma",
        description: "Gamma project overview...",
        date: "01/12/25"),
  ];

  void _addProject() {
    // TODO: Implement logic to add a new project
    // For example, navigate to a new screen or show a dialog
    print("Add project button pressed");
  }

  void _openMenu() {
    // TODO: Implement menu logic
    print("Menu button pressed");
  }

  void _openMoreOptions() {
    // TODO: Implement more options logic
    print("More options button pressed");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("HOME"), // Uses titleTextStyle from theme
        title: const Text("HOME"), // If you prefer explicit style here
        leading: IconButton(
          icon: const Icon(Icons.menu), // Icon color from theme
          onPressed: _openMenu,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert), // Icon color from theme
            onPressed: _openMoreOptions,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          return ProjectCard(project: project); // Pass the whole project object
        },
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: _addProject,
          child: const Icon(Icons.add, size: 40), // Icon color from theme
        ),
      ),
    );
  }
}
