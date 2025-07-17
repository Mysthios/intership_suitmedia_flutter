import 'package:flutter/material.dart';
import 'package:intership_suitmedia/pages/first_page.dart';
import 'package:intership_suitmedia/provider/provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Palindrome User App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FirstScreen(),
      ),
    );
  }
}


