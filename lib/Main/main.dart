// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:list_view/View/todo.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "To-Do App",
      debugShowCheckedModeBanner: false,
      home: Todo(),
    );
  }
}
