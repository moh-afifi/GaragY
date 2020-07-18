// a screen used to display layout of the garage for area 1
//---------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:mygarage/reusables/reusable_positioned.dart';
import 'package:mygarage/reusables/reusable_button.dart';
import 'package:mygarage/screens/cost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class LayoutPage extends StatefulWidget {
  // a constructor used to pass data from screen 'find parking'
  LayoutPage({this.t2, this.t1,this.pageNumber, this.arrowImagePath,this.layoutImagePath,
    this.p1,this.p2,this.p3,this.p4, this.p5,this.p6});
  final String t1,t2,layoutImagePath,arrowImagePath;
  final double p1,p2,p3,p4,p5,p6;
  final int pageNumber;

  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage>
    with SingleTickerProviderStateMixin {

  final _auth = FirebaseAuth.instance;

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  _auth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                }),
          ],
          backgroundColor: Color(0xFF8D60FF),
          centerTitle: true,
          title: Text(
            'Layout',
            style: TextStyle(
                fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Container(
              height: 500,
              width: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 2,
                    bottom: 10,
                    child: Image(
                      image: AssetImage(widget.layoutImagePath),
                      height: 500,
                      width: 400,
                    ),
                  ),
                  ReusablePositioned(
                    left: widget.p1,
                    bottom: widget.p2,
                    text: ((int.parse(widget.t1)) > 12 &&
                        (int.parse(widget.t2)) > 12)
                        ? '${(int.parse(widget.t1)) - 12} pm - ${(int.parse(widget.t2)) - 12} pm'
                        : ' ${widget.t1} am - ${widget.t2} am',
                  ),
                  Positioned(
                    left: widget.p3,
                    bottom: widget.p4,
                    child: Opacity(
                      opacity: controller.value,
                      child: Image(
                        height: widget.p5,
                        width: widget.p6,
                        image: AssetImage(widget.arrowImagePath),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            ReusableButton(
              colour: Colors.teal,
              title: 'Go Forward!',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cost(
                      t1: widget.t1,
                      t2: widget.t2,
                      pageNumber: widget.pageNumber,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
    );
  }
}
