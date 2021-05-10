import 'package:flutter/material.dart';
import 'package:rr/login.dart';
import 'second.dart';
import 'third.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final _auth=FirebaseAuth.instance;
 var user;
  void getCurrentUser() async{
    user=await _auth.currentUser;
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
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Image.asset("images/logo.png",width: 150.0,)),
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            child: Icon(Icons.notifications,color: Colors.white,),
            onPressed: null,),

        ],

      ),

      body:Container(
        color: Colors.blueGrey[200],
        width: double.infinity,
        child: ListView(
          children: [
            Card(
              child: RawMaterialButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondPage()));
                },

                child: Container(
                  padding: EdgeInsets.all(20.0),
                  width: double.infinity,
                  child: Text("Anime",style: TextStyle(fontSize: 20.0),),

                ),
              ),
            ),
            Card(
              child: RawMaterialButton(
                onPressed: null,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  width: double.infinity,
                  child: Text("Movie",style: TextStyle(fontSize: 20.0),),

                ),
              ),
            ),
            Card(
              child: RawMaterialButton(
                onPressed: null,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  width: double.infinity,
                  child: Text("Web Series",style: TextStyle(fontSize: 20.0),),

                ),
              ),
            ),
          ],
        ),
      ) ,
      drawer:  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("images/logo.png",width: 100,),
                  Text("Hello ",style: TextStyle(color: Colors.white),),
                ],
              ),
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
                Navigator.push(context, MaterialPageRoute(builder:(context)=>SecondPage()));
              },
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
                _auth.signOut();
                // Update the state of the app
                // ...
                // Then close the drawer

                Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginScreen()));
              },
            ),

          ],
        ),
      ),


    );
  }
}



