import 'package:flutter/material.dart';
import 'package:newsapp/welcomepage/welcome_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SWU News App',
      theme: ThemeData(
        
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
