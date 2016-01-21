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
  String weatherList = '';
  String status;
  String curItemCheck;
  WeatherService service;

  List<String> get classList => _classList;

  List<String> get cities => _cities;
  City model = new City(_cities[2], "", "", null);

  getCities($event) async {
    print(_cities[int.parse($event.target.value)]);
    weatherList = '';
    await service.loadData(_cities[int.parse($event.target.value)]);
    weatherList = service.wordlist;
    status = classList[service.classIndex];
  }

  init(weatherService) async{
    this.service = weatherService;
    await weatherService.getLocation();
    weatherList = weatherService.wordlist;
    try {
      status = classList[weatherService.classIndex];
    } catch(exception, stackTrace) {
      print(exception);
      print(stackTrace);
    }
  }

  AppWeatherComponent(WeatherService weatherService){
    init(weatherService);
  }
}
