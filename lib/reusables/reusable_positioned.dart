import 'package:flutter/material.dart';

class ReusablePositioned extends StatelessWidget {
  ReusablePositioned({this.bottom,this.left,this.text});
  final double left;
  final double bottom;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: InkWell(
        child: Text(text,style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold),),
      ),
      left: left,
      bottom: bottom,
    );
  }
}
