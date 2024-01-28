import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference notes =
    FirebaseFirestore.instance.collection("Notes");

class FirestoreService {
  //get collection of notes

  //CREATE: add a new note
  Future<void> addNote(String noteTitle, String noteContent, int colorId) {
    return notes
        .add({
          "note_title": noteTitle,
          "creation_date": DateTime.now().toString(),
          "note_content": noteContent,
          "color_id": colorId
        })
        .then((value) => print("Note added successfully!"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('creation_date', descending: true).snapshots();
    return notesStream;
  }

  //UPDATE: update notes given a doc id
  Future<void> updateNote(String docID, String newNoteTitle,
      String newNoteContent, int colorId) async {
    return notes
        .doc(docID)
        .update({
          "note_title": newNoteTitle,
          "creation_date": DateTime.now().toString(),
          "note_content": newNoteContent,
          "color_id": colorId
        })
        .then((value) => print("Note Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  //DELETE: delete notes given a doc id
  Future<void> deleteNote(String docID) {
    return notes
        .doc(docID)
        .delete()
        .then((value) => print("Note Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
