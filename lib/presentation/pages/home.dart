import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_firebase_flutter/presentation/providers/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../data/models/notes.dart';
import '../../data/services/database_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dbService = DatabaseService();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  void addNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),

            SizedBox(height: 10),

            TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: "Body"),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),

                SizedBox(width: 5),

                TextButton(
                  onPressed: () {
                    Notes note = Notes(
                      title: titleController.text,
                      body: bodyController.text,
                      createdAt: Timestamp.now(),
                    );

                    dbService.addNote(note);
                    Navigator.pop(context);
                    titleController.clear();
                    bodyController.clear();
                    setState(() {});
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, value, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade300,
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

        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,

          child: StreamBuilder(
            stream: dbService.getNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text("Error ${snapshot.error}"));
              }

              if (snapshot.hasData) {
                List notes = snapshot.data!.docs ?? [];
                if (notes.isEmpty) {
                  return Center(child: Text("No notes found"));
                }
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    Notes note = notes[index].data();

                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: ListTile(
                        tileColor: Colors.deepPurple.shade200,
                        title: Text(note.title),
                        subtitle: Text(note.body),
                        trailing: Text(
                          DateFormat(
                            "dd/mm/yyyy HH:mm a",
                          ).format(note.createdAt.toDate()),
                        ),
                      ),
                    );
                  },
                );
              }

              return Center(child: Text("No notes found"));
            },
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () => addNote(),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
