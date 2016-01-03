library Dart_101.WeatherService;

import 'package:angular2/angular2.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'package:json_object/json_object.dart';
import 'package:Dart_101/geo_location.dart';

@Injectable()
class WeatherService {
  JsonObject data;
  List<int> classIndex = [];
  List<String> wordlist = [];

  Future loadData(country) async {
    var url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22"+ country +"%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
    await HttpRequest.getString(url).then(onDataLoaded);
  }

  void onDataLoaded(String responseText) {
    data = new JsonObject.fromJsonString(responseText);
    wordlist.add(data.query.results.channel.location.city + ',' +
        data.query.results.channel.location.country + ' | ' +
        ((int.parse(data.query.results.channel.item.condition.temp) - 32) * 5 /
            9).round().toString() + '°C');
    String status = data.query.results.channel.item.condition.text;
    //print(status);
    if (identical(status, "Partly Cloudy"))
      new DateTime.now().hour > 16 || new DateTime.now().hour < 6 ? classIndex.add(4) : classIndex.add(0);
    else if (identical(status, "Mostly Cloudy"))
      classIndex.add(1);
    else if (identical(status, "Cloudy") || identical(status, "Fog") || identical(status, "Haze"))
      classIndex.add(1);
    else if (identical(status, "Rainy"))
      classIndex.add(2);
    else if (identical(status, "Fair"))
      new DateTime.now().hour > 16 || new DateTime.now().hour < 6 ? classIndex.add(4) : classIndex.add(0);
    else if (identical(status, "Clear"))
      new DateTime.now().hour > 16 || new DateTime.now().hour < 6 ? classIndex.add(4) : classIndex.add(0);
    else if (identical(status, "Light Snow") || identical(status, "Snow"))
      classIndex.add(6);
    else
      print('Unknown status');
  }

  Future<String> getLocation() async{
    GeoLocation geo = new GeoLocation();
    String country = await geo.getCoordinates();
    //String country = await geo.findLocation(coord.coords.latitude,coord.coords.longitude);
    await loadData(country);
    //loadData("Izmir");
  }


  WeatherService(){
     getLocation();
  }
}