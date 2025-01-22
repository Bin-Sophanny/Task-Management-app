import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_management/add_task_screen.dart';
import 'package:task_management/firebase_options.dart';
import 'package:task_management/forgot_password_screen.dart';
import 'package:task_management/home_screen.dart';
import 'package:task_management/login_screen.dart';
import 'package:task_management/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
      ),
      home: _auth.currentUser != null ? const HomeScreen():LoginScreen(),
      routes: {
        '/signUp': (context) => SignUpScreen(),
        '/login' : (context) => LoginScreen(),
        '/homescreen' : (context) =>  const HomeScreen(),
        '/forgotpass' : (context) => ForgotPasswordScreen(),
        '/addtask' : (context) => AddTaskScreen(),
      },
    );
  }
}