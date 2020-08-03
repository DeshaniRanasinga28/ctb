import 'package:flutter/material.dart';
import 'package:passenger/block/news_block.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewsScreenState();
  }
}

class _NewsScreenState extends State<NewsScreen> {
  double deviceWidth, deviceHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    var newsBloc = Provider.of<NewsBloc>(context);
    print("newsBloc == " + newsBloc.getList().length.toString());
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: WillPopScope(
        onWillPop: () async {
          return Future.value(
              false); //return a `Future` with false value so this route cant be popped or closed.
        },
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 40.0),
                  width: deviceWidth,
                  height: deviceHeight / 6.0,
                  color: Color(0xFF0065C4),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50.0,
                          padding: EdgeInsets.only(right: 20.0, left: 20.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            autofocus: false,
                            style: TextStyle(
                                fontSize: 22.0, color: Color(0xFFbdc6cf)),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter city',
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                              ),
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color(0xFF06539D),
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: newsBloc.getList().length != null ? newsBloc.getList().length : 0,
                        itemBuilder: (context, index) {
                          return new Column(
                            children: <Widget>[
                              Card(
                                  elevation: 3.0,
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: 20.0, top: 20.0),
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "Just now",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: Image.asset(
                                                  "assets/bus.jpeg",
                                                  width: 100.0,
                                                  height: 100.0,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                  child: Text(newsBloc.getList()[index].title == null ?
                                                    "${newsBloc.getList()[index].title} km" : "",
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20.0,
                                              right: 20.0,
                                              bottom: 20.0),
                                          child: Text(
                                            "${newsBloc.getList()[index].description}",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          );
                        }),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
