//this is the page which you navigate to when pressing 'exit' in drawer
//----------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mygarage/reusables/reusable_button.dart';
import 'noraml_fees.dart';
import 'extra_fees.dart';
import 'other_fees_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
class ExitGarage extends StatefulWidget {
  @override
  _ExitGarageState createState() => _ExitGarageState();
}

class _ExitGarageState extends State<ExitGarage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String timeOne, timeTwo;
  int now = DateTime.now().hour;
  int startTime,endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Exit Garage',style: TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      //---------------------------------------------------------------
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image(
            image: AssetImage('images/exit1.png'),
            height: 500,
            width: 200,
          ),

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

                return Center(
                  child:ReusableButton(
                      title: 'Exit Garage',
                      colour: Colors.red,
                      onPressed: (){
                        if(now == startTime && now < endTime){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NormalFees(),
                            ),
                          );
                        }else if (now > endTime){
                          int extraHours = now - endTime ;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExtraFees(numOfExtraHours: extraHours,),
                            ),
                          );
                        }else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Other(),
                            ),
                          );
                        }
                      }
                  ),
                );
              }
              ),
          //-------------------------------------------------------------------
        ],
      ),
    );
  }
}
