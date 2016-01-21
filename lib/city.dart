library Dart_101.city;
import 'dart:html';

class City {
  String city;
  String latitude;
  String longitude;
  ImageBitmap photo;
  City(this.city, this.latitude, this.longitude, [this.photo]);
  String toString() => '$city ($latitude, $longitude)';
}