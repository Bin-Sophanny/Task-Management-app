import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management/services/auth_services.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final AuthServices _auth = AuthServices();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9acce7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF9acce7),
        foregroundColor: Colors.black,
        title: const Text('Forgot the password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/splash.png'),
                      fit: BoxFit.cover),
                ),
              ),
              const Text("Forgot ?",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              const Text("Submit Email for reset",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400)),
              const SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  labelStyle: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await _auth.sendPasswordResetEmail(emailController.text);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Password reset email sent successfully."),
                        ),
                      );
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    } catch (e) {
                      // Handle errors (e.g., invalid email, network issues)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "The Email does not exist.: ${e.toString()}"),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Send Password Reset Email",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Don't have an account ?",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/signUp', (route) => false);
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                "Already have an account?",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/signUp', (route) => false);
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
