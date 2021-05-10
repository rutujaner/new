import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rr/third.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'first.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

int rating = 1;
var title="";
String _chosenValue;
class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  final _database=FirebaseFirestore.instance;
  final auth=FirebaseAuth.instance;

  void getCurrentUser(){
    user= auth.currentUser;
    if(user!=null){
      print(user.email);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(child: Image.asset("images/logo.png",width: 150.0,)),
          backgroundColor: Colors.black,
          actions: [
            TextButton(
              child: Icon(Icons.notifications,color: Colors.white,),
              onPressed: null,),

          ],

        ),

        body: Container(
          color: Colors.blueGrey[200],
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        title=value;
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter the title',
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
                    SizedBox(height: 30.0,),
                    Container(
                      padding: EdgeInsets.all(10.0),


                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                rating.toString(),
                                style: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "/10",
                                style: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          Center(
                            child: Text("User Rating",style: TextStyle(
                              fontSize:20.0,
                              color: Colors.grey,
                            ),),
                          ),
                          Slider(
                            value: rating.toDouble(),
                            min: 1.0,
                            max: 10.0,
                            onChanged: (double value) {
                              setState(() {
                                rating = value.round();
                              });
                            },
                            activeColor: Colors.black,
                            inactiveColor: Colors.blueGrey[300],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    Container(
                      
                      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                          value: _chosenValue,
                          dropdownColor: Colors.white,
                          // elevation: 10,
                          style: TextStyle(color: Colors.black),
                          items: <String>[
                            'ACTION',
                            'ROMANCE',
                            'DRAMA',
                            'SUSPENSE',
                            'COMEDY',
                            'HORROR',
                            'DOCUMENTARY',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(

                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: Center(
                            child: Text(
                              "Select a Genre",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _chosenValue = value;
                            });
                          },
                        ),
                      ),
                    )





                  ],
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                color: Colors.black,
                child: TextButton(
                  child: Text(
                    "ADD",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  onPressed: (){
                  if(title!="" && _chosenValue!=null) {
                    _database.collection('Rating').add({
                      'Title': title,
                      'Rating': rating,
                      'Time': DateTime.now(),
                      'Genre': _chosenValue,
                      'User': user.email.toString(),
                    }
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ThirdPage()));
                  }
                  else{
                    print("Please enter a value");
                  }


                  },
                ),
              ),

            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.arrow_forward),
        //   onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>ThirdPage()));
        //   },
        // ),
        drawer:  Drawer(
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
                title: Text('VIEW LIST'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>ThirdPage()));
                },
              ),
              ListTile(
                title: Text('CATEGORIES'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>FirstPage()));
                },
              ),
              ListTile(
              title: Text('LOG OUT'),
              onTap: () {
                auth.signOut();
                // Update the state of the app
                // ...
                // Then close the drawer

                Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginScreen()));
              },
            )
          

            ],
          ),
        ),

      ),
    );
  }
}
