import 'package:flutter/material.dart';
import 'models/book.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(ReadingChampionApp());
}

class ReadingChampionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leitura Master',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
