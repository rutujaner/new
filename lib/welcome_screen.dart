import 'package:flutter/material.dart';
import 'package:rr/first.dart';
import 'components/animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

var email, password;

class WelcomeScreen extends StatelessWidget {
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.black,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: RotateImage(),
            ),
            SizedBox(
              height: 30.0,
            ),
            Hero(
              tag: 'logo',
              child: Image.asset(
                "images/logo_1.png",
                width: 250,
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [

                  TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
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
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
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
                  SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                      onPressed: ()async{
                        try{
                          final newUser= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                          if(newUser!=null){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstPage()));
                          }
                        }
                        catch(e){
                          print(e);
                        }

                      },
                      child: Container(
                        width: double.infinity,
                        child: Center(
                            child: Text(
                          "Register",
                          style: TextStyle(fontSize: 15.0),
                        )),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[200],
                            borderRadius: BorderRadius.circular(20)),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a user?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                            decoration: TextDecoration.underline
                              ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
