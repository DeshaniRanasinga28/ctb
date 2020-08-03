
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:passenger/model/news.dart';

class NewsBloc with ChangeNotifier {
  var _newsList = [];
  var _isLoading = false;

  getLoading() => _isLoading;
  getList() => _newsList;

  NewsBloc(){
    getData();
  }

  getData() async{

    String url = 'https://gg2cukknk1.execute-api.ap-southeast-1.amazonaws.com/prod/bus-app/news';
    print("AmenitiesBloc url == ${url}");

    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("news body == ${response.body}");
      var jsonResponse = convert.jsonDecode(response.body)['data']['news'];
      jsonResponse.forEach((i)=>_newsList.add(News.fromJson(i)));
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
    _isLoading = false;
    notifyListeners();
  }
  void setLoading(){
    _isLoading = true;
    notifyListeners();
  }
}