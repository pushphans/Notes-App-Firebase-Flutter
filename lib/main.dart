import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase_flutter/data/models/notes.dart';
import 'package:notes_app_firebase_flutter/firebase_options.dart';
import 'package:notes_app_firebase_flutter/presentation/pages/home.dart';
import 'package:notes_app_firebase_flutter/presentation/pages/login_page.dart';
import 'package:notes_app_firebase_flutter/presentation/pages/register_page.dart';
import 'package:notes_app_firebase_flutter/presentation/pages/update_page.dart';
import 'package:notes_app_firebase_flutter/presentation/providers/auth_viewmodel.dart';
import 'package:notes_app_firebase_flutter/utils/widgets/toggle_widget.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AuthViewModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data != null) {
            return Home();
          }

          return ToggleWidget();
        },
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/update':
            {
              final (id, note) = settings.arguments as (String, Notes);
              return MaterialPageRoute(
                builder: (context) => UpdatePage(note: note, id: id),
              );
            }
        }
      },
    );
  }
}
