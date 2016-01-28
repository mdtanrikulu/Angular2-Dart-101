library Dart_101.city;
import 'dart:html';

class City {
  String city;
  String info;
  int condition;
  ImageBitmap photo;
  City(this.city, this.info, this.condition, [this.photo]);
  String toString() => '$city ($condition)';
}