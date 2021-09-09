//-------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:mygarage/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'provider/garage_provider.dart';
//-------------------------------------------------------------
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GarageProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
