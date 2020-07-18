//this is the screen to which we navigate when booking from Are 1
//-------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../reusables/reusable_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mygarage/screens/layout_page.dart';
class Booking extends StatefulWidget {
  Booking({this.pageNumber});
  final int pageNumber;
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  int now = DateTime.now().hour;
  //these string are used for Slider!
  int time1 = 12;
  int time2 = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Booking',
          style: TextStyle(
              fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      //---------------------------------------------------------------
      body: Builder(
        builder: (context) => Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'From:',
                    style: TextStyle(
                        color: Color(0xFF8D60FF),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            time1.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'H',
                          )
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Colors.red[100],
                          activeTrackColor: Colors.red,
                          thumbColor: Color(0xFFEB1555),
                          overlayColor: Color(0x29EB1555),
                          thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                        ),
                        child: Slider(
                          value: time1.toDouble(),
                          min: 1.0,
                          max: 24.0,
                          onChanged: (double newValue) {
                            setState(() {
                              time1 = newValue.round();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //---------------------------------------------------------------
              Row(
                children: <Widget>[
                  Text(
                    'To: ',
                    style: TextStyle(
                        color: Color(0xFF8D60FF),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            time2.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'H',
                          )
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Colors.red[100],
                          activeTrackColor: Colors.red,
                          thumbColor: Color(0xFFEB1555),
                          overlayColor: Color(0x29EB1555),
                          thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                        ),
                        child: Slider(
                          value: time2.toDouble(),
                          min: 1.0,
                          max: 24.0,
                          onChanged: (double newValue) {
                            setState(() {
                              time2 = newValue.round();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //---------------------------------------------------------------
              ReusableButton(
                  colour: Colors.teal,
                  title: 'Park Now!',
                  onPressed: () {
                    if(time1 == time2 ){
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                        content: Row(
                          children: <Widget>[
                            SizedBox(width: 20,),
                            Text("Please enter a valid time!"),
                          ],
                        ),
                      ));
                    }else if (time1 > time2) {
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                        content: Row(
                          children: <Widget>[
                            SizedBox(width: 20,),
                            Text("Please enter a valid time!"),
                          ],
                        ),
                      ));
                    }
                    else if (time1 < now) {
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                        content: Row(
                          children: <Widget>[
                            SizedBox(width: 20,),
                            Text("Please enter a valid time!"),
                          ],
                        ),
                      ));
                    }else{
                      if(widget.pageNumber == 1){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LayoutPage(
                              t1: time1.toString(),
                              t2: time2.toString(),
                              pageNumber: 1,
                              p1: 35,p2: 275,p3: 136,p4: 15,p5: 400,p6: 75,
                              arrowImagePath: 'images/arrow1.png',
                              layoutImagePath: 'images/layout1.png',
                            ),
                          ),
                        );
                      }
                      else if(widget.pageNumber == 2){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LayoutPage(
                              t1: time1.toString(),
                              t2: time2.toString(),
                              pageNumber: 2,
                              p1: 265,p2: 270,p3: 180,p4: 135,p5: 160,p6: 85,
                              arrowImagePath: 'images/arrow2.png',
                              layoutImagePath: 'images/layout2.png',
                            ),
                          ),
                        );
                      }
                      else if(widget.pageNumber == 3){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LayoutPage(
                              t1: time1.toString(),
                              t2: time2.toString(),
                              pageNumber: 3,
                              p1: 35,p2: 275,p3: 136,p4: 15,p5: 400,p6: 75,
                              arrowImagePath: 'images/arrow1.png',
                              layoutImagePath: 'images/layout1.png',
                            ),
                          ),
                        );
                      }
                      else if(widget.pageNumber == 4){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LayoutPage(
                              t1: time1.toString(),
                              t2: time2.toString(),
                              pageNumber: 4,
                              p1: 265,p2: 270,p3: 180,p4: 135,p5: 160,p6: 85,
                              arrowImagePath: 'images/arrow2.png',
                              layoutImagePath: 'images/layout2.png',
                            ),
                          ),
                        );
                      }

                    }
                  }
                  ),
            ],
          ),
        )
      ),
    );
  }
}
