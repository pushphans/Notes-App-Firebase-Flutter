import 'package:flutter/material.dart';
import 'package:notes_app_firebase_flutter/presentation/providers/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RegisterPage')),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            Consumer<AuthViewModel>(
              builder: (context, value, child) => GestureDetector(
                onTap: () async {
                  await value.signUp(
                    emailController.text,
                    passwordController.text,
                  );
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: Text("Register")),
                ),
              ),
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap: widget.onTap,
              child: Text("Already have an account? Login here"),
            ),
          ],
        ),
      ),
    );
  }
}
