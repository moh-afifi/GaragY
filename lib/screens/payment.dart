// a screen to perform fictional payment and saves data to database and fires scheduled notification
//---------------------------------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:mygarage/reusables/reusable_button.dart';
import 'package:mygarage/screens/find_parking.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:mygarage/provider/garage_provider.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {

  // a constructor which takes values from the cost screen
  Payment({this.pageNumber});
  final int pageNumber;
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final _firestore = Firestore.instance;

  // a method used to schedule a notification:
  Future notifySchedule(String payload) async{
    var scheduledNotificationDateTime = new DateTime.now().add(new Duration(seconds: 10));
    var android1 = new AndroidNotificationDetails('channel id',
        'channel NAME', 'CHANNEL DESCRIPTION');
    var iOS1 = new IOSNotificationDetails();
    NotificationDetails platform = new NotificationDetails(android1, iOS1);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Garage',
        'you are about 30 minutes off !',
        scheduledNotificationDateTime, platform,payload:payload );
  }

  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,onSelectNotification: notifySchedule);

  }
  //-----------------------------------------------------------------------------
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<GarageProvider>(context);
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
        centerTitle: true,
        title: Text(
          'Payment',
          style: TextStyle(
              fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body:Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(15.0),
            child: ListView(
              children: <Widget>[
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                ),
                CreditCardForm(
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
                ReusableButton(
                  title: 'Pay',
                  colour: Colors.teal,
                  onPressed: () async{
                    await _firestore
                        .collection('booking')
                        .getDocuments()
                        .then((snapshot) {
                      for (DocumentSnapshot doc in snapshot.documents) {
                        doc.reference.delete();
                      }
                    });
//-------------------------------------------------------------------------------
                    _firestore.collection('booking').add({
                      'fromTime': myProvider.fromTime,
                      'toTime': myProvider.toTime,

                    });
//-------------------------------------------------------------------------------
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Center(
                            child: Text(
                              'Great!',
                              style: TextStyle(color: Colors.teal),
                            )),
                        content: Text(
                          'Your payment is done!',
                          style: TextStyle(fontSize: 15),
                        ),
                        elevation: 8.0,
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FindParking(check: false,pageNumber: widget.pageNumber,),
                                ),
                              );
                            },
                            child: Text(
                              'OK !',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    );
                    notifySchedule('you are about 30 minutes off !');
                  },
                )
              ],
            ),
          );
        },
      )
    );
  }
}
