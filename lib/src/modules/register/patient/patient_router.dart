import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'package:health_center_self_service/src/modules/register/patient/patient_controller.dart';
import 'package:health_center_self_service/src/modules/register/patient/patient_page.dart';

class PatientRouter extends FlutterGetItModulePageRouter {
  const PatientRouter({super.key});

  @override
  List<Bind<Object>> get bindings =>
      [Bind.lazySingleton((i) => PatientController(repository: i()))];

  @override
  WidgetBuilder get view => (_) => const PatientPage();
}
