library Dart_101.geolocation;

import 'package:angular2/angular2.dart';
import 'dart:html';
import 'dart:math';
import 'dart:async';
import 'package:json_object/json_object.dart';

@Injectable()
class GeoLocation {
  num calculateDistance(num lat1, num lon1, num lat2, num lon2) {
    const EARTH_RADIUS = 6371; // km
    num latDiff = lat2 - lat1;
    num lonDiff = lon2 - lon1;

    // a is the square of half the chord length between the points.
    var a = pow(sin(latDiff / 2), 2) +
        cos(lat1) * cos(lat2) *
            pow(sin(lonDiff / 2), 2);

    var angularDistance = 2 * atan2(sqrt(a), sqrt(1 - a));
    return EARTH_RADIUS * angularDistance;
  }

// Don't use alert() in real code ;)
  void alertError(PositionError error) {
    window.alert("Error occurred. Error code: ${error.code}");
  }

  Future getCoordinates() async {
    var completer = new Completer();
    Geoposition startPosition;
    String country;

    window.navigator.geolocation.getCurrentPosition()
        .then((Geoposition position) async {
      startPosition = position;
      print(startPosition.coords.latitude.toString() + ',' +
          startPosition.coords.longitude.toString());
      country = await findLocation(
          startPosition.coords.latitude, startPosition.coords.longitude);
      completer.complete(country);
    }, onError: (error) => alertError(error));

    window.navigator.geolocation.watchPosition().listen((Geoposition position) {
      print(position.coords.latitude.toString() + ',' +
          position.coords.longitude.toString());
      num distance = calculateDistance(
          startPosition.coords.latitude,
          startPosition.coords.longitude,
          position.coords.latitude,
          position.coords.longitude);
      print(distance.toString());
    }, onError: (error) => alertError(error));
    return completer.future;
  }

  Future findLocation(x, y) async {
    String reverse_geocoding = "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=en&latlng=" +
        x.toString() + ',' +
        y.toString();
    JsonObject geoJson = new JsonObject.fromJsonString(
        await HttpRequest.getString(reverse_geocoding));
    print(geoJson.results[1].address_components[2].long_name);
    return geoJson.results[1].address_components[2].long_name;
  }
}
