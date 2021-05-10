import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'second.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'first.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String filtertype = "Rating";
var sorttype = true;
var spinner = false;
var searched;
var firebasequery;

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final _database = FirebaseFirestore.instance;

  void getData() async {
    await for (var snapshot in _database.collection("Rating").snapshots()) {
      print(snapshot.docs[0].data()["doc_id"]);
      for (var fetchdata in snapshot.docs) {
        // print(fetchdata.data());
      }
    }
  }

  String readTimestamp(Timestamp timestamp) {
    var now = DateTime.now();
    var format = DateFormat('dd-MM-yyyy  HH:mm ');
    var date =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    var diff = now.difference(date);
    var time = '';
    var d = format.format(date);

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return d.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebasequery = FirebaseFirestore.instance
        .collection("Rating")
        .orderBy(filtertype, descending: sorttype)
        .get();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searched = value.toUpperCase();
                  if (searched != "") {
                    firebasequery = FirebaseFirestore.instance
                        .collection("Rating")
                        .where("Genre", isEqualTo: searched)
                        .get();
                  } else {
                    firebasequery = FirebaseFirestore.instance
                        .collection("Rating")
                        .orderBy(filtertype, descending: sorttype)
                        .get();
                  }
                });
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.blueGrey[300],
                ),
                hintText: "Search for a Genre. eg. Action",
                hintStyle: TextStyle(color: Colors.blueGrey[300]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey[300]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey[300]),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey[300]),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.blueGrey[200],
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                    future: firebasequery,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data.docs;
                        if (documents.length == 0) {
                          return Center(
                            child: SpinKitFadingCircle(
                              color: Colors.black,
                              size: 100.0,
                            ),
                          );
                        }
                        return Column(
                          children: [
                            Container(

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Filter By:",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  Container(
                                    width: 150.0,
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Center(
                                        child: Text(
                                      filtertype,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.grey[700]),
                                    )),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        sorttype =
                                            sorttype == true ? false : true;
                                        firebasequery = FirebaseFirestore
                                            .instance
                                            .collection("Rating")
                                            .orderBy(filtertype,
                                                descending: sorttype)
                                            .get();
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: Icon(
                                        Icons.sort,
                                        size: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        if (filtertype == "Time") {
                                          filtertype = "Rating";
                                          firebasequery = FirebaseFirestore
                                              .instance
                                              .collection("Rating")
                                              .orderBy(filtertype,
                                                  descending: sorttype)
                                              .get();
                                        } else if (filtertype == "Rating") {
                                          filtertype = "Title";
                                          firebasequery = FirebaseFirestore
                                              .instance
                                              .collection("Rating")
                                              .orderBy(filtertype,
                                                  descending: sorttype)
                                              .get();
                                        } else {
                                          filtertype = "Time";
                                          firebasequery = FirebaseFirestore
                                              .instance
                                              .collection("Rating")
                                              .orderBy(filtertype,
                                                  descending: sorttype)
                                              .get();
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: Icon(
                                        Icons.filter_alt,
                                        size: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                  children: documents
                                      .map(
                                        (doc) => Card(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: ListTile(
                                                  title: Text(doc['Title']),
                                                  subtitle: Text(readTimestamp(
                                                      doc['Time'])),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(3.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .blueGrey[200])),
                                                child: Text(
                                                  doc["Genre"],
                                                  style: TextStyle(
                                                      fontSize: 10.0,
                                                      color: Colors.green),
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        doc['Rating']
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 25.0),
                                                      ),
                                                      Text(
                                                        "/10",
                                                        style: TextStyle(
                                                            fontSize: 25.0),
                                                      ),
                                                    ],
                                                  )),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            Colors.grey[300]),
                                                    shape: BoxShape.circle),
                                                child: TextButton(
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      FirebaseFirestore.instance
                                                          .collection("Rating")
                                                          .doc(doc.id)
                                                          .delete();
                                                      firebasequery = FirebaseFirestore.instance
                                                          .collection("Rating")
                                                          .orderBy(filtertype, descending: sorttype)
                                                          .get();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList()),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: SpinKitFadingCircle(
                            color: Colors.black,
                            size: 100.0,
                          ),
                        );
                      }
                    }),
              ),


            ],
          ),
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text(""),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: Text('ADD NEW'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondPage()));
                },
              ),
              ListTile(
                title: Text('VIEW LIST'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ThirdPage()));
                },
              ),
              ListTile(
                title: Text('CATEGORIES'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FirstPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
