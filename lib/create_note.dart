import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List colors = [
  Colors.grey,
  Colors.brown,
  Colors.purple,
  Colors.lightGreen,
  Colors.lime,
  Colors.red,
  Colors.blue,
  Colors.yellow,
  Colors.blueGrey,
  Colors.orange
];

class CreateNote extends StatelessWidget {
  CreateNote({super.key});
  final idController = TextEditingController();
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  Future createNewNote(String id, String title, String note) async {
    final create = FirebaseFirestore.instance.collection("crud").doc(id);
    final colorr = colors[Random().nextInt(10)];
    final json = {
      'id': id,
      'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
      'title': title,
      'note': note,
      'colorr': colorr.toString(),
      'done': false,
    };
    await create.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width > 450
            ? 350
            : MediaQuery.of(context).size.width,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("New Task"),
            actions: [
              IconButton(
                  onPressed: () {
                    final title = titleController.text;
                    final note = noteController.text;
                    createNewNote(
                        DateTime.now().microsecondsSinceEpoch.toString(),
                        title,
                        note);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.done))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                    TextField(
                      maxLines: null,
                      controller: titleController,
                      onChanged: (enter) {
                        titleController.text == enter;
                      },
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.black),
                          hintText: "Task Title",
                          label: Text(
                            "Title",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                    TextField(
                      maxLines: null,
                      controller: noteController,
                      onChanged: (enter) {
                        noteController.text == enter;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: "Write description....",
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
