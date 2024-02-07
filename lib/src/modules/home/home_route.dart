import 'package:flutter/material.dart';
import 'package:flutter_experience_medical_laboratory_pdv/src/modules/home/home_page.dart';
import 'package:flutter_getit/flutter_getit.dart';

class HomeRouter extends FlutterGetItModulePageRouter {
  const HomeRouter({super.key});

  @override
  WidgetBuilder get view => (_) => const HomePage();
}
