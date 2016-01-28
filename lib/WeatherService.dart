library Dart_101.WeatherService;

import 'package:angular2/angular2.dart';
import 'dart:html';
import 'dart:async';
import 'package:json_object/json_object.dart';
import 'package:Dart_101/geo_location.dart';
import 'package:Dart_101/city.dart';
import 'package:crypto/crypto.dart';
import 'dart:typed_data';

@Injectable()
class WeatherService {

  Future loadData(country) async {
    var url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22"+ country +"%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
    return await HttpRequest.getString(url).then(onDataLoaded);
  }

  String fahrToCel(String temp){
    return ((int.parse(temp) - 32) * 5 /9).round().toString();
  }

  City onDataLoaded(String responseText) {
    int classIndex;
    JsonObject data = new JsonObject.fromJsonString(responseText);
    String info = data.query.results.channel.location.city + ',' +
        data.query.results.channel.location.country + ' | ' +
        fahrToCel(data.query.results.channel.item.condition.temp) + '°C';
    String status = data.query.results.channel.item.condition.text;
    //print(status);
    if (identical(status, "Partly Cloudy"))
      new DateTime.now().hour > 16 || new DateTime.now().hour < 6 ? classIndex = 4 : classIndex = 0;
    else if (identical(status, "Mostly Cloudy"))
      classIndex = 1;
    else if (identical(status, "Cloudy") || identical(status, "Fog") || identical(status, "Haze") || identical(status, "Mist"))
      classIndex = 1;
    else if (identical(status, "Rainy") || identical(status, "Light Drizzle"))
      classIndex = 2;
    else if (identical(status, "Fair"))
      new DateTime.now().hour > 16 || new DateTime.now().hour < 6 ? classIndex = 4 : classIndex = 0;
    else if (identical(status, "Clear"))
      new DateTime.now().hour > 16 || new DateTime.now().hour < 6 ? classIndex = 4 : classIndex = 0;
    else if (identical(status, "Light Snow") || identical(status, "Snow") || identical(status, "Drifting Snow"))
      classIndex = 6;
    else{
      print('Unknown status');
      classIndex = 0;
    }

    return new City(data.query.results.channel.location.city, info, classIndex ,null);
  }

  Future getLocation() async{
    GeoLocation geo = new GeoLocation();
    String country = await geo.getCoordinates();
    City city = await loadData(country);
    //loadData("Warsaw");
    return city;
  }

  Future findPlacePhoto(city) async{
    Completer completer = new Completer();
    city = city.toString().replaceAll(" ","+");
    String url = "https://crossorigin.me/http://loremflickr.com/600/400/"+city;
    completer.complete(await fetchImgAsBase64(url));
    return completer.future;
  }

  Future fetchImgAsBase64(url) async{
    return await HttpRequest.request(
        url,
        responseType: "arraybuffer").then((HttpRequest response){
      String contentType = response.getResponseHeader('Content-Type');

      String header = 'data:$contentType;base64,';
      // String base64 = CryptoUtils.bytesToBase64((response.response as ByteBuffer).asUint8List());

      var list = new Uint8List.view((response.response as ByteBuffer));
      String base64 = CryptoUtils.bytesToBase64(list);

      String image = "${header}${base64}";

      return image;
    });
}


  WeatherService(){}
}
