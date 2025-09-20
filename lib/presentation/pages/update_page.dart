import 'package:flutter/material.dart';
import 'package:notes_app_firebase_flutter/data/models/notes.dart';
import 'package:notes_app_firebase_flutter/data/services/database_service.dart';

class UpdatePage extends StatefulWidget {
  final Notes note;
  final String id;
  const UpdatePage({super.key, required this.note, required this.id});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final dbService = DatabaseService();
  late final titleController = TextEditingController(text: widget.note.title);
  late final bodyController = TextEditingController(text: widget.note.body);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Note"),
        actions: [
          IconButton(
            onPressed: () {
              Notes updatedNote = widget.note.copyWith(
                title: titleController.text,
                body: bodyController.text,
              );

              dbService.updateNote(widget.id, updatedNote);
              Navigator.pop(context);
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                style: TextStyle(fontSize: 30),
                controller: titleController,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Expanded(
                child: TextField(
                  controller: bodyController,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
