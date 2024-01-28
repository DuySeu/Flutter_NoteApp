// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:note_app/screens/note_create.dart';
import 'package:note_app/screens/note_update_delete.dart';
import 'package:note_app/style/app_style.dart';
import 'package:note_app/widgets/firestore.dart';
import 'package:note_app/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyle.mainColor,
        appBar: AppBar(
          elevation: 0.0,
          title: const Text("FireNotes", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: AppStyle.mainColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your recent Notes",
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: firestoreService.getNotesStream(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        List notesList = snapshot.data!.docs;
                        return GridView.builder(
                          itemCount: notesList.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot doc = notesList[index];
                            return noteCard(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NoteUpdate(doc: doc)));
                            }, notesList[index]);
                            // return null;
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                        );
                      }
                      return Text("There is no Notes",
                          style: GoogleFonts.nunito(color: Colors.white));
                    }),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NoteEditorScreen()));
            // Get.to(NoteEditorScreen());
          },
          label: const Text("Add Note"),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
