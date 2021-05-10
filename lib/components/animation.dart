import 'package:flutter/material.dart';

class RotateImage extends StatefulWidget {
  @override
  _RotateImageState createState() => _RotateImageState();
}

class _RotateImageState extends State<RotateImage> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 5),
    );

    animationController.repeat();
  }


  stopRotation(){

    animationController.stop();
  }

  startRotation(){

    animationController.repeat();
  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
        animation: animationController,
        child: Container(
          child: Image.asset("images/clock_1.png",width: 70,),
        ),
        builder: (BuildContext context, Widget _widget){
          return Transform.rotate(
              angle:animationController.value * 6.3,
            child: _widget,
          );
        },
      ),
    );
  }
}
