// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:angular2/bootstrap.dart';

import 'package:angular2/angular2.dart';
import 'package:Dart_101/app_component.dart';
import 'package:Dart_101/app_weather_component.dart';

@View (directives: const [NgClass])
main() {
  bootstrap(AppComponent);
  bootstrap(AppWeatherComponent);
}
