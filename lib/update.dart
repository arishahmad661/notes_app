import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Updatee extends StatelessWidget {
  Updatee(this.id, {super.key});
  String? id;
  final idController = TextEditingController();
  final titleController = TextEditingController();
  final noteController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("crud").doc(id).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width > 450
                      ? 350
                      : MediaQuery.of(context).size.width,
                  child: Scaffold(
                      appBar: AppBar(
                        title: const Text("Edit"),
                        actions: [
                          IconButton(
                              onPressed: () {
                                final title = titleController.text;
                                final note = noteController.text;
                                FirebaseFirestore.instance
                                    .collection("crud")
                                    .doc(id)
                                    .update({      'id': id,
      'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
      'title': title,
      'note': note,
      'done': false,});

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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                TextFormField(
                                  maxLines: null,
                                  controller: titleController
                                    ..text = snapshot.data!['title'].toString()
                                    ..selection = TextSelection.fromPosition(
                                        TextPosition(
                                            offset: snapshot.data!['title']
                                                .toString()
                                                .length)),
                                  onChanged: (enter) {
                                    titleController.text == enter;
                                  },
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(color: Colors.black),
                                      hintText: "Title",
                                      label: Text(
                                        "Title",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                ),
                                TextFormField(
                                  maxLines: null,
                                  controller: noteController
                                    ..text = snapshot.data!['note'].toString()
                                    ..selection = TextSelection.fromPosition(
                                        TextPosition(
                                            offset: snapshot.data!['note']
                                                .toString()
                                                .length)),
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
                      ))),
            );
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return Container();
          }
        });
  }
}
