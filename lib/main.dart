import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project List',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return ProjectCard(
            title: "Project Tittle",
            description: "Description of Project...",
            date: "14/09/25",
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: Colors.grey[300],
          shape: const CircleBorder(
            side: BorderSide(color: Colors.black26, width: 2),
          ),
          onPressed: () {},
          child: const Icon(Icons.add, size: 40, color: Colors.black),
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                Text(
                  date,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
