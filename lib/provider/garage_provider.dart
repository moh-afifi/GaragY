import 'package:flutter/material.dart';

class GarageProvider with ChangeNotifier{

int fromTime =12;
int toTime=12;
int pageNumber;

changeFromTime(double newVal){
fromTime=newVal.round();
notifyListeners();
}

changeToTime(double newVal){
  toTime=newVal.round();
  notifyListeners();
}

}