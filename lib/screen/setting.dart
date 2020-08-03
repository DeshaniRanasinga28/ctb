import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SettingScreenState();
  }
}

class _SettingScreenState extends State<SettingScreen> {
  // Default Drop Down Item.
  String dropdownValue = 'Colombo';

  // To show Selected Item in Text.
  String holder = '';


  List <String> actorsName = [
  'Colombo',
  'Makubura/Kottawa',
  'Galle'
  ];

  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }

  double deviceWidth, deviceHeight;
  CameraPosition _currentLoc;
  Completer<GoogleMapController> _controller = Completer();
  final PolylinePoints polylinePoints = PolylinePoints();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
  );

  final Position busHalt = Position(longitude: 79.976668, latitude: 6.839600);
  final Set<Polyline> _polyline = {};
  final Set<Marker> _markers = {};
  int _currentTime = 11;
  Timer timer;

  @override
  void initState() {
    super.initState();
    loadMyLocation();
    loadPolys();
    loadMarkers();
    timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        if (_currentTime > 0) {
          _currentTime -= 1;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
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
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 40.0),
                    width: deviceWidth,
                    height: deviceHeight / 6.0,
                    color: Color(0xFF0065C4),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: deviceWidth - 100.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            underline: Container(
                              height: 2,
                            ),
                            onChanged: (String data) {
                              setState(() {
                                dropdownValue = data;
                              });
                            },
                            items: actorsName.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    )
//                  Row(
//                    children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.only(left: 20.0),
//                        child: Icon(
//                          Icons.search,
//                          color: Colors.white,
//                        ),
//                      ),
//                      Expanded(
//                        child: Container(
//                          height: 50.0,
//                          padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                          child: TextField(
//                            textAlign: TextAlign.center,
//                            autofocus: false,
//                            style: TextStyle(
//                                fontSize: 22.0, color: Color(0xFFbdc6cf)),
//                            decoration: InputDecoration(
//                              filled: true,
//                              fillColor: Colors.white,
//                              hintText: 'Enter city',
//                              hintStyle: TextStyle(
//                                fontSize: 14.0,
//                              ),
//                              contentPadding: const EdgeInsets.only(
//                                  left: 14.0, bottom: 8.0, top: 8.0),
//                              focusedBorder: OutlineInputBorder(
//                                borderSide: BorderSide(color: Colors.white),
//                                borderRadius: BorderRadius.circular(25.7),
//                              ),
//                              enabledBorder: UnderlineInputBorder(
//                                borderSide: BorderSide(color: Colors.white),
//                                borderRadius: BorderRadius.circular(25.7),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
                    ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      GoogleMap(
                        mapType: MapType.normal,
                        polylines: _polyline,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        markers: _markers,
                        initialCameraPosition:
                            _currentLoc != null ? _currentLoc : _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                      PlayAnimation<double>(
                        tween: Tween<double>(begin: 0, end: 200),
                        duration: Duration(milliseconds: 600),
                        delay: Duration(seconds: 2),
                        curve: Curves.elasticOut,
                        builder: (context, child, value) {
                          return Container(
                            child: Container(
                                height: value,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.0),
                                        topLeft: Radius.circular(20.0))),
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 20.0, right: 20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "$_currentTime ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "mins",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Until next bus",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Makumbura Highway Bus Stand",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Fare: LKR 250",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                )),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> loadMyLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("Loading my location");
    _loadMapToLocation(busHalt);
  }

  void loadMarkers() async {
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(10, 10)), "assets/red_bus.png");
    final Marker marker = Marker(
        markerId: MarkerId("ii"),
        position: LatLng(busHalt.latitude, busHalt.longitude),
        infoWindow: InfoWindow(title: "makumbura highway bus stand"),
        icon: icon);
    setState(() {
      _markers.add(marker);
    });
  }

  void _loadMapToLocation(Position position) async {
    CameraPosition _currentLocVal = CameraPosition(
      zoom: 14,
      target: LatLng(
        position.latitude,
        position.longitude,
      ),
    );
    setState(() {
      _currentLoc = _currentLocVal;
    });
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(_currentLocVal));
  }

  void loadPolys() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Polyline route = await getRouteLine(position, busHalt);

    setState(() {
      _polyline.add(route);
      print(route.points.length);
      print("Length of polylines: ${_polyline.length}");
    });

    print("Polylines loaded");
  }

  Future<Polyline> getRouteLine(
      Position startPosition, Position destPosition) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyA-oGFP7FUpmLWCcMTjSXHKQdzJO-5Yd3k",
        PointLatLng(startPosition.latitude, startPosition.longitude),
        PointLatLng(destPosition.latitude, destPosition.longitude));

    List<LatLng> points = List();
    result.points.forEach((element) {
      print("result found");
      points.add(LatLng(element.latitude, element.longitude));
    });
    return Polyline(
      width: 4,
      polylineId: PolylineId("1"),
      //a fixed polyline id, each route is replaced when a new one is made
      visible: true,
      points: points,
      color: Colors.blue,
    );
  }
}
