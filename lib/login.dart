import 'package:flutter/material.dart';
import 'package:rr/first.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome_screen.dart';

var email, password;

class LoginScreen extends StatelessWidget {
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
            Hero(
              tag: 'logo',
              child: Image.asset(
                "images/logo_1.png",
                width: 220,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextButton(onPressed: null, child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                    child: Row(
                      children: [
                        Image.asset("images/google_logo.png",width: 20,),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("Sign In with Google"),

                      ],
                    ),
                  ),),
                  Text("OR",style: TextStyle(fontSize: 20,color: Colors.white),),
                  SizedBox(
                    height: 10.0,
                  ),
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
                          final newUser= await _auth.signInWithEmailAndPassword(email: email, password: password);
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
                              "Log In",
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
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
                        },
                        child: Text(
                          "New User?",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      TextButton(
                        onPressed: null,
                        child: Text(
                          "Forgot Password?",
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
