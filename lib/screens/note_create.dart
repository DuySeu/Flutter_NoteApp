// ignore_for_file: prefer_final_fields
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:note_app/style/app_style.dart';
import 'package:note_app/widgets/firestore.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
    int colorId = Random().nextInt(AppStyle.cardsColor.length);
    String date = DateTime.now().toString();

    TextEditingController _titleController = TextEditingController();
    TextEditingController _mainController = TextEditingController();
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title:
            const Text("Add a new Note", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: 'Note Title'),
            style: AppStyle.mainTitle,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            date,
            style: AppStyle.dateTitle,
          ),
          const SizedBox(
            height: 28.0,
          ),
          TextField(
            controller: _mainController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: 'Note Content'),
            style: AppStyle.mainContent,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () {
          firestoreService.addNote(
              _titleController.text, _mainController.text, colorId);
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
