//this is the page which you navigate to when you are within the range
//-------------------------------------------------------------------------
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygarage/reusables/reusable_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'find_parking.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class NormalFees extends StatefulWidget {
  @override
  _NormalFeesState createState() => _NormalFeesState();
}

class _NormalFeesState extends State<NormalFees> {

  final _firestore = Firestore.instance;
  String timeOne, timeTwo;
  int now = DateTime.now().hour;
  int startTime,endTime;

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
                child: Image(
              image: AssetImage('images/thumb1.jpg'),
            )),

            // a stream builder which retrieves data from database
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('booking').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                  final items = snapshot.data.documents.reversed;

                  for (var item in items) {
                    timeOne = item.data['fromTime'];
                    timeTwo = item.data['toTime'];
                  }

                  startTime = int.parse(timeOne);
                  endTime = int.parse(timeTwo);

                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.all(18.0),
                            child: (startTime > 12 && endTime > 12)
                                ? Text(
                                    'Your reservation from: ${startTime - 12} pm to: ${(endTime - 12)} pm',
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    'Your reservation from ($startTime) am to ($endTime) am',
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
            Card(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('You don\'t have any extra fees'),
              ),
              elevation: 5,
            ),
            ReusableButton(
              colour: Colors.blueAccent,
              title: 'Home Page',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FindParking(),
                  ),
                );
              },
            )
          ],
        ));
  }
}
