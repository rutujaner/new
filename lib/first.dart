import 'package:flutter/material.dart';
import 'second.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SELECT'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [

            //1
            TextButton(onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>SecondPage()));
            }, 
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              child: Text('ANIME', style: TextStyle(fontSize: 20.0),),
              color: Colors.grey,
            ),
            ),

            //2
            TextButton(onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>SecondPage()));
            },
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              child: Text('MOVIE', style: TextStyle(fontSize: 20.0),),
              color: Colors.grey,
            ),
            ),

            //3
            TextButton(onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>SecondPage()));
            }, 
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              child: Text('SERIES', style: TextStyle(fontSize: 20.0),),
              color: Colors.grey,
            ),
            ),


          ],
        ),
      ),
    );
  }
}