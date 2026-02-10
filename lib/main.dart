import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto', 
        scaffoldBackgroundColor: const Color(0xFFF2F5F9),
        primaryColor: const Color(0xFF6F3CD7),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}