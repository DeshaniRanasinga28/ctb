import 'package:flutter/material.dart';
import 'package:passenger/screen/setting.dart';
import 'package:passenger/screen/tickets.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

import 'news.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  double deviceWidth, deviceHeight;

  @override
  void initState() {
    // TODO: implement initState
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            NewsScreen(),
            SettingScreen(),
            TicketsScreen(),
          ],
          controller: controller,
        ),
        bottomNavigationBar: Material(
          shadowColor: Colors.black,
          elevation: 50.0,
          color: Color(0xFF0065C4),
          child: TabBar(
            tabs: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Tab(
                  icon: new Image.asset('assets/images/news.png',
                      width: 20.0, height: 20.0),
                  child: Text(
                    "News",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "OpenSans",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Tab(
                  icon: new Image.asset("assets/images/map.png",
                      width: 20.0, height: 20.0),
//                  icon: new Icon(FeatherIcons.settings),
                  child: Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "OpenSans",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Tab(
                  icon: new Image.asset("assets/images/schedule.png",
                      width: 20.0, height: 20.0),
                  child: Text(
                    "Ticket",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "OpenSans",
                    ),
                  ),
                ),
              ),
            ],
            controller: controller,
          ),
        ),
      ),
    );
  }
}
