import 'package:flutter/material.dart';
import 'package:restaurantui/src/Screens/checkout.dart';
import 'package:restaurantui/src/Screens/homescreen.dart';
import 'package:restaurantui/src/Screens/myCard.dart';
import 'package:restaurantui/src/Screens/myNotifications.dart';
import 'package:restaurantui/src/Screens/myOrders.dart';
import 'package:restaurantui/src/Screens/myProfile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'RalewayMedium',
          scaffoldBackgroundColor: Colors.grey[50]),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/mycard': (context) => MyCard(),
        '/checkout': (context) => CheckOut(),
        '/myorders': (context) => MyOrders(),
        '/myprofile': (context) => MyProfile(),
        '/mynotifications': (context) => MyNotifications()
      },
    );
  }
}
