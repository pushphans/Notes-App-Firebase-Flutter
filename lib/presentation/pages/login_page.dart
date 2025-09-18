import 'package:flutter/material.dart';
import 'package:notes_app_firebase_flutter/presentation/providers/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LoginPage')),

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
                  await value.signIn(
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
                  child: Center(child: Text("Login")),
                ),
              ),
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap: widget.onTap,
              child: Text("Don't have an account yet? Register here"),
            ),

            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: Divider(height: 2, color: Colors.grey.shade400),
            ),

            SizedBox(height: 10),

            Text("or"),

            SizedBox(height: 10),

            GestureDetector(
              child: Image(
                image: AssetImage("assets/images/google.png"),
                height: 90,
                width: 90,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
