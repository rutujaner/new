import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'second.dart';

String filter='Time';
var sort=false;

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  String readTimestamp(Timestamp timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('dd/MM/yyyy HH:mm a');
    var date = new DateTime.fromMillisecondsSinceEpoch(
        timestamp.millisecondsSinceEpoch);
    var finaltime = format.format(date);

    return finaltime.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('DISPLAY'),
          leading: TextButton(onPressed: null, child: Icon(Icons.set_meal)),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(25),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('FILTER BY: '),
                  Container(
                    width: 150,
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    child: Center(child: Text(filter, style: TextStyle(color: Colors.black),)),
                  ),
                  TextButton(onPressed: (){
                    setState(() {
                      sort=sort==true?false:true;
                    });
                  }, child: Icon(Icons.sort)),
                  TextButton(onPressed: (){
                    setState(() {
                      if(filter=='Time')
                        filter='Rating';
                      else if(filter=='Rating')
                        filter='Title';
                      else
                        filter='Time';
                    });
                  }, child: Icon(Icons.filter_alt))
                ],
              )),
              Expanded(
                child: FutureBuilder<QuerySnapshot>(
                    // <2> Pass `Future<QuerySnapshot>` to future
                    future:
                        FirebaseFirestore.instance.collection('Rating').orderBy(filter,descending: sort).get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                        final List<DocumentSnapshot> documents =
                            snapshot.data.docs;
                        return ListView(
                            children: documents
                                .map((doc) => Card(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              title: Text(
                                                doc['Title'],
                                                style:
                                                    TextStyle(fontSize: 20.0),
                                              ),
                                              subtitle: Text(
                                                  readTimestamp(doc['Time'])),
                                            ),
                                          ),
                                          Text(
                                            doc['Rating'].toString(),
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  FirebaseFirestore.instance.collection('Rating').doc(doc.id).delete();
                                                });
                                            
                                              },
                                              child: Container(
                                                child: Icon(Icons.delete),
                                              ))
                                        ],
                                      ),
                                    ))
                                .toList());
                      } else  {
                        return Center(
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 100.0,
                          ),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
