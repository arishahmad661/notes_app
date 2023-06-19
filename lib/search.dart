import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/update.dart';
import 'package:flutter/material.dart';

class Searchh extends StatefulWidget {
  const Searchh({super.key});

  @override
  _SearchhState createState() => _SearchhState();
}


class _SearchhState extends State<Searchh> {
  String enter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Card(
          child: TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (value) {
              setState(() {
                enter = value;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("crud").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount:snapshot.data!.docs.length, 
                      itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index].data();
              
                      if (data['title']
                          .toString()
                          .toLowerCase()
                          .startsWith(enter.toLowerCase())) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Updatee(snapshot.data!.docs[index].id)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0,right: 8.0),
                            child: Card(
                            color: Colors.amber,
                              child:  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data['title'].toString(),style: const TextStyle(fontSize: 20),),
                                      Text(data['date'].toString(),style: TextStyle(color:Colors.grey[700], fontSize: 15),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        // return FlutterTost.showToast(timeInSecForIosWeb: 1, msg: 'Task not found');
                      }
                      return null;
                    }),
                  ),
              );
        },
      ),
    );
  }
}
