import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/create_note.dart';
import 'package:crud/search.dart';
import 'package:crud/update.dart';
import 'package:flutter/material.dart';
import 'package:string_to_color/string_to_color.dart';

class Readd extends StatelessWidget {
  const Readd({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("To-Do List"),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Searchh()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateNote()),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection("crud").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                            children: List.generate(
                                snapshot.data!.docs.length,
                                (index) => SizedBox(
                                      height: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Updatee(
                                                      snapshot.data!
                                                          .docs[index]['id']
                                                          .toString())),
                                            );
                                          },
                                          child: Card(
                                            elevation: 5,
                                            shape: const ContinuousRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            color: Color(ColorUtils.stringToHexInt(snapshot
                                                        .data!
                                                        .docs[index]['colorr']
                                                        .toString()
                                                        .length >=
                                                    46
                                                ? snapshot
                                                            .data!
                                                            .docs[index]
                                                                ['colorr']
                                                            .toString()
                                                            .length ==
                                                        46
                                                    ? snapshot.data!
                                                        .docs[index]['colorr']
                                                        .toString()
                                                        .substring(35, 45)
                                                    : snapshot.data!
                                                        .docs[index]['colorr']
                                                        .toString()
                                                        .substring(21, 45)
                                                : snapshot
                                                    .data!.docs[index]['colorr']
                                                    .toString()
                                                    .substring(6, 15))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                      ['title']
                                                                  .toString()
                                                                  .length >
                                                              21
                                                          ? Expanded(
                                                              child: Text(
                                                                "${snapshot.data!.docs[index]['title'].toString().substring(0, 18)}...",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            )
                                                          : Text(
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                      ['title']
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
                                                            ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                snapshot.data!
                                                                            .docs[index]
                                                                        ['done']
                                                                    ? FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "crud")
                                                                        .doc(snapshot
                                                                            .data!
                                                                            .docs[index][
                                                                                'id']
                                                                            .toString())
                                                                        .update({
                                                                        'done':
                                                                            false
                                                                      })
                                                                    : FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "crud")
                                                                        .doc(snapshot
                                                                            .data!
                                                                            .docs[index]['id']
                                                                            .toString())
                                                                        .update({'done': true});
                                                              },
                                                              icon: !snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      ['done']
                                                                  ? const Icon(Icons
                                                                      .check_box_outline_blank)
                                                                  : const Icon(Icons
                                                                      .check_box)),
                                                          IconButton(
                                                            icon: const Icon(Icons
                                                                .delete_outline),
                                                            onPressed: () {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "crud")
                                                                  .doc(snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                          ['id']
                                                                      .toString())
                                                                  .delete();
                                                            },
                                                            iconSize: 20,
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    0),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ['date'],
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  snapshot
                                                              .data!
                                                              .docs[index]
                                                                  ['note']
                                                              .toString()
                                                              .length >
                                                          183
                                                      ? Expanded(
                                                          child: Text(
                                                            "${snapshot.data!.docs[index]['note'].toString().substring(0, 180)}...",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .docs[index]
                                                                    ['note']
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))),
                      );

                    
                    }

                    else if (snapshot.hasError) {
                      return Container();
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
