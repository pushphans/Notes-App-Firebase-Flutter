import 'package:flutter/material.dart';
import 'package:notes_app_firebase_flutter/data/models/notes.dart';
import 'package:notes_app_firebase_flutter/presentation/providers/auth_viewmodel.dart';
import 'package:notes_app_firebase_flutter/presentation/providers/firestore_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  void openDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(labelText: "Body"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  SizedBox(width: 5),
                  TextButton(
                    onPressed: () async {
                      final note = Notes(
                        id: randomAlphaNumeric(20),
                        title: titleController.text.trim(),
                        body: bodyController.text.trim(),
                        createdAt: DateTime.now(),
                      );

                      Provider.of<FireStoreViewModel>(
                        context,
                        listen: false,
                      ).addNote(note);

                      Navigator.pop(context);
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
              onPressed: () async {
                await value.signOut();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),

        body: ,


        floatingActionButton: FloatingActionButton(
          onPressed: openDialog,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
