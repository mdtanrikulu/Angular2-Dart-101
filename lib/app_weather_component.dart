library Dart_101.app_weather_component;

import 'package:angular2/angular2.dart';
import 'package:Dart_101/WeatherService.dart';
import 'dart:html';


@Component(selector: 'my-weather-app', viewProviders: const [WeatherService])
@View (templateUrl:'app_weather_component.html', directives: const [NgFor, NgIf, NgClass])
class AppWeatherComponent{

  List<String> friendNames = [];
  String status;
  List<String> classList = ['sunny', 'cloudy', 'rainy', 'rainbow', 'starry', 'stormy', 'snowy'];
  List<int> classIndex;


  AppWeatherComponent(WeatherService weatherService) {
    friendNames = weatherService.wordlist;
    classIndex = weatherService.classIndex;
  }
}