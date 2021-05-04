import 'package:flutter/material.dart';
import 'second.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: Scaffold(
        appBar: AppBar(
          title: Text('DISPLAY'),
          leading: TextButton(onPressed: null, child: Icon(Icons.set_meal)),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [

              //1
              RawMaterialButton(onPressed:null, 
              child: Container(
                padding: EdgeInsets.all(20.0),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ANIME TITLE', style: TextStyle(fontSize: 20.0),),
                        Text('03-05-2021', style: TextStyle(fontSize: 15.0),),
                      ],
                    ),
                    Text('4/5', style: TextStyle(fontSize: 20.0),),
                  ],
                ),
                color: Colors.grey,
              ),
              ),

              

            ],
          ),
        ),
      ),
    );
  }
}