import 'package:flutter/material.dart';
import 'package:passenger/provider_config.dart';
import 'package:passenger/screen/home.dart';
import 'package:provider/provider.dart';

//void main(){
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return MaterialApp(
//      title: "Smart Voucher",
//      debugShowCheckedModeBanner: false,
//      routes: <String, WidgetBuilder>{
//      },
//      theme: ThemeData(
//          primaryColor: Colors.white,
//          primarySwatch: Colors.blue),
//      home: HomeScreen(),
//    );
//  }
//}



void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: "Smart Voucher",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
        },
        theme: ThemeData(
            primaryColor: Colors.white,
            primarySwatch: Colors.blue),
        home: HomeScreen(),
      ),
    );
  }
}