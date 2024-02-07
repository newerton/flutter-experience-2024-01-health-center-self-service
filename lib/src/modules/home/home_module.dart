import 'package:flutter/material.dart';
import 'package:flutter_experience_medical_laboratory_pdv/src/modules/home/home_route.dart';

import 'package:flutter_getit/flutter_getit.dart';

class HomeModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/home';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const HomeRouter(),
      };
}
