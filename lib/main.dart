import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/View/Landing_page/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBV19MlIfSCOdLL3FeQWA-HWUvrt4wZYxA",
      appId: "1:777011857439:android:67daf0177092c491806d2a",
      messagingSenderId: "777011857439",
      projectId: "todo-app-b7ecf",
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Todo App",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
