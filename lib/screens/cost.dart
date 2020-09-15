// this is the page to which you navigate from the four booking screens
//----------------------------------------------------------------------
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../reusables/reusable_button.dart';
import '../components/constants.dart';
import 'package:mygarage/screens/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:mygarage/provider/garage_provider.dart';
import 'package:provider/provider.dart';

class Cost extends StatefulWidget {
  // a constructor which takes values from the booking screens
  Cost({this.pageNumber});
  final int pageNumber;
  //---------------------------------------------------------------
  @override
  _CostState createState() => _CostState();
}

class _CostState extends State<Cost> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<GarageProvider>(context);
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
            'Cost',
            style: TextStyle(
                fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        //---------------------------------------------------------------
        body: Padding(
          padding:  EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Cost Per Hour: ', style: kGarageTextStyle1),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '10 KWD',
                    style: kGarageTextStyle2,
                  ),
                ),
                elevation: 10,
              ),
              Text('Number Of Hours: ', style: kGarageTextStyle1),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '${myProvider.toTime - myProvider.fromTime} H',
                    style: kGarageTextStyle2,
                  ),
                ),
                elevation: 10,
              ),
              Text('Total Cost: ', style: kGarageTextStyle1),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '${(myProvider.toTime - myProvider.fromTime) * 10} KWD ',
                    style: kGarageTextStyle2,
                  ),
                ),
                elevation: 10,
              ),
              //---------------------------------------------------------------
              Center(
                child: ReusableButton(
                  colour: Colors.teal,
                  title: 'Pay',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Payment(
                          pageNumber: widget.pageNumber,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )
    );
  }
}
