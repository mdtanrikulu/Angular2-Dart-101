library Dart_101.app_weather_component;

import 'package:angular2/angular2.dart';
import 'package:Dart_101/WeatherService.dart';
import 'dart:html';
import 'package:Dart_101/city.dart';
import 'dart:async';

const List<String> _cities = const [
  "Warsaw",
  "Istanbul",
  "Ankara",
  "London",
  "Moscow",
  "Saint Petersburg",
  "Berlin",
  "Madrid",
  "Rome",
  "Kiev",
  "Paris",
  "Minsk",
  "Bucharest",
  "Vienna",
  "Hamburg",
  "Budapest",
  "Barcelona",
  "Kharkiv",
  "Munich",
  "Milan",
  "Nizhny Novgorod",
  "Prague",
  "Sofia",
  "Kazan",
  "Samara",
  "Belgrade",
  "Brussels",
  "Rostov-on-Don",
  "Birmingham",
  "Ufa",
  "Cologne",
  "Volgograd",
  "Perm",
  "Naples",
  "Dnipropetrovsk"
];

const List<String> _classList = const [
  'sunny',
  'cloudy',
  'rainy',
  'rainbow',
  'starry',
  'stormy',
  'snowy'
];

@Component(selector: 'my-weather-app', viewProviders: const [WeatherService])
@View (templateUrl: 'app_weather_component.html',
    directives: const [NgFor, NgIf, NgClass, NgModel, NgControl])
class AppWeatherComponent {

  int classIndex;
  String weatherInfo = '';
  String status;
  String curItemCheck;
  WeatherService service;

  List<String> get classList => _classList;

  List<String> get cities => _cities;

  getCities($event) async {
    print(_cities[int.parse($event.target.value)]);
    weatherInfo = '';
    City city = await service.loadData(_cities[int.parse($event.target.value)]);
    weatherInfo = city.info;
    status = classList[city.condition];
    querySelector('.city-background').style.backgroundImage = "url("+ await service.findPlacePhoto(city.city)+")";
  }

  init(weatherService) async{
    this.service = weatherService;
    City city = await weatherService.getLocation();
    weatherInfo = city.info;
    try {
      status = classList[city.condition];
      querySelector('.city-background').style.backgroundImage = "url("+ await weatherService.findPlacePhoto(city.city)+")";
    } catch(exception, stackTrace) {
      print(exception);
      print(stackTrace);
    }
  }

  AppWeatherComponent(WeatherService weatherService){
    init(weatherService);
  }
}
