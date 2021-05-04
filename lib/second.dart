import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'third.dart';

int rating = 0;
var title='';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final database = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FEED'),
        ),
        body: Container(
          color: Colors.pinkAccent[100],
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //1
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (newtitle) {
                    title=newtitle;

                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter title',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              //2
              Center(
                child: Text(
                  rating.toString(),
                  style: TextStyle(fontSize: 40.0),
                ),
              ),

              //3
              Container(
                child: Slider(
                  value: rating.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      rating = value.round();
                    });
                  },
                  min: 0.0,
                  max: 5.0,
                  activeColor: Color(0xFF40E0D0),
                  inactiveColor: Color(0xFF00CED1),
                ),
              ),

              //4
              Container(
                width: double.infinity,
                color: Colors.black,
                child: TextButton(
                  onPressed: (){
                    if(title!='')
                    {
                      database.collection("Rating").add({
                        'Title':title,
                        'Rating':rating,
                        'Time':DateTime.now()
                      });
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>ThirdPage()));
                    }
                  },
                  child: Text('ADD',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              )
            ],
          ),
        ));
  }
}
