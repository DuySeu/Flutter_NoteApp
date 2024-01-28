import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/style/app_style.dart';
import 'package:note_app/widgets/firestore.dart';

// ignore: must_be_immutable
class NoteUpdate extends StatefulWidget {
  NoteUpdate({super.key, required this.doc}) {}

  QueryDocumentSnapshot doc;

  @override
  State<NoteUpdate> createState() => _NoteUpdateState();
}

class _NoteUpdateState extends State<NoteUpdate> {
  late FirestoreService firestoreService = FirestoreService();
  String date = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    String docID = widget.doc.id;
    int colorId = widget.doc['color_id'];
    late TextEditingController _titleController =
        TextEditingController(text: widget.doc['note_title']);
    late TextEditingController _mainController =
        TextEditingController(text: widget.doc['note_content']);
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
          backgroundColor: AppStyle.cardsColor[colorId],
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                firestoreService.deleteNote(docID);
                Navigator.pop(context);
              },
              icon: Icon(Icons.clear, color: AppStyle.mainColor),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: AppStyle.mainTitle,
            ),
            const SizedBox(height: 4.0),
            Text(
              date,
              style: AppStyle.dateTitle,
            ),
            const SizedBox(height: 28.0),
            TextField(
              controller: _mainController,
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () {
          firestoreService.updateNote(
              docID, _titleController.text, _mainController.text, colorId);
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
