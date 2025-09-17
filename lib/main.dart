import 'package:flutter/material.dart';
import 'package:project/home_page.dart';

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
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white, // warna background

        //AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[400],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        //Button Add
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.red[400],
          shape: const CircleBorder(

          ),
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}
