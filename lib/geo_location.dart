library Dart_101.geolocation;

import 'package:angular2/angular2.dart';
import 'dart:html';
import 'dart:async';
import 'package:json_object/json_object.dart';

@Injectable()
class GeoLocation{
  JsonObject data;
  String location = "";

  Future findLocation() async{
    var ipUrl = 'https://api.ipify.org/?format=json';
    String data = await HttpRequest.getString(ipUrl);
    JsonObject dataJS = new JsonObject.fromJsonString(data);
    //print(dataJS.ip);
    var url = 'http://www.freegeoip.net/json/' + dataJS.ip;
    //HttpRequest.getString(url).then(onDataLoaded);
    return (await HttpRequest.getString(url));
  }

//  String onDataLoaded(String responseText) {
//    print(responseText);
//    return responseText;
//  }


  GeoLocation(){

  }
}