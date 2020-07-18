// the home page from where you choose are to book
//-------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:mygarage/reusables/reusable_parking_available_com.dart';
import 'package:mygarage/screens/booking.dart';
import 'package:mygarage/screens/login_screen.dart';
import 'exit_garage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FindParking extends StatefulWidget {
  FindParking({this.check, this.pageNumber});
  final int pageNumber;
  final bool check;
  @override
  _FindParkingState createState() => _FindParkingState();
}

class _FindParkingState extends State<FindParking> {
  static bool change;
  static int pageNum;
  @override
  void initState() {
    setState(() {
      change = widget.check;
      pageNum = widget.pageNumber;
      tabs = <Tab>[
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text('area 1'),
                ((change == false) && (pageNum == 1))
                    ? Text(
                  'complete',
                  style: TextStyle(color: Colors.red),
                )
                    : Text(
                  'available',
                  style: TextStyle(color: Colors.teal),
                ),
              ],
            ),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text('area 2'),
                ((change == false) &&(pageNum == 2))
                    ? Text(
                  'complete',
                  style: TextStyle(color: Colors.red),
                )
                    : Text(
                  'available',
                  style: TextStyle(color: Colors.teal),
                ),
              ],
            ),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text('area 3'),
                ((change == false) && (pageNum == 3))
                    ? Text(
                  'complete',
                  style: TextStyle(color: Colors.red),
                )
                    : Text(
                  'available',
                  style: TextStyle(color: Colors.teal),
                ),
              ],
            ),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text('area 4'),
                ((change == false) &&(pageNum == 4))
                    ? Text(
                  'complete',
                  style: TextStyle(color: Colors.red),
                )
                    : Text(
                  'available',
                  style: TextStyle(color: Colors.teal),
                ),
              ],
            ),
          ),
        )
      ];
    });
//    print('$change $pageNum');
    super.initState();
  }

  List<Tab> tabs ;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: Drawer(
          child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExitGarage(),
                  ),
                );
              },
              child: Text(
                'Exit Garage',
                style: TextStyle(fontSize: 20, color: Colors.red),
              )),
        ),
        //-------------------------------------------------------------------
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
          title: Text(
            'Find Parking',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF8D60FF),
          elevation: 0,
          bottom: TabBar(
              labelStyle: TextStyle(fontSize: 12),
              labelColor: Color(0xFF8D60FF),
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.white,
              ),
              tabs: tabs),
        ),
        //-------------------------------------------------------------
        body: TabBarView(children: <Widget>[
          ((change == false) && (pageNum == 1))
              ? ReusableParkingAvailableComp(
                  buttonColor: Colors.teal,
                  textColor: Colors.white,
                  text: 'Park Now!',
                  onTap: null)
              : ReusableParkingAvailableComp(
                  buttonColor: Colors.teal,
                  textColor: Colors.white,
                  text: 'Park Now!',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Booking(
                          pageNumber: 1,
                        ),
                      ),
                    );
                  },
                ),
          ((change == false) && (pageNum == 2))
              ? ReusableParkingAvailableComp(
                  buttonColor: Colors.teal,
                  textColor: Colors.white,
                  text: 'Park Now!',
                  onTap: null)
              : ReusableParkingAvailableComp(
                  buttonColor: Colors.teal,
                  textColor: Colors.white,
                  text: 'Park Now!',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Booking(
                          pageNumber: 2,
                        ),
                      ),
                    );
                  },
                ),
          ((change == false) && (pageNum == 3))
              ? ReusableParkingAvailableComp(
                  buttonColor: Colors.teal,
                  textColor: Colors.white,
                  text: 'Park Now!',
                  onTap: null)
              : ReusableParkingAvailableComp(
                  buttonColor: Colors.teal,
                  textColor: Colors.white,
                  text: 'Park Now!',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Booking(
                          pageNumber: 3,
                        ),
                      ),
                    );
                  },
                ),
          ((change == false) && (pageNum == 4))
              ? ReusableParkingAvailableComp(
                  buttonColor: Colors.teal,
                  textColor: Colors.white,
                  text: 'Park Now!',
                  onTap: null)
              : ReusableParkingAvailableComp(
                  buttonColor: Colors.teal,
                  textColor: Colors.white,
                  text: 'Park Now!',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Booking(
                          pageNumber: 4,
                        ),
                      ),
                    );
                  },
                ),
        ]),
      ),
    );
  }
}
