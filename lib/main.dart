import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_experience_medical_laboratory_core/flutter_experience_medical_laboratory_core.dart';
import 'package:flutter_experience_medical_laboratory_pdv/src/binding/medical_laboratory_application_binding.dart';
import 'package:flutter_experience_medical_laboratory_pdv/src/modules/auth/auth_module.dart';
import 'package:flutter_experience_medical_laboratory_pdv/src/modules/home/home_module.dart';
import 'package:flutter_experience_medical_laboratory_pdv/src/pages/splash_screen/page.dart';
import 'package:flutter_getit/flutter_getit.dart';

void main() {
  runZonedGuarded(() {
    runApp(const MedicalLaboratoryPDVApp());
  }, (error, stackTrace) {
    log('runZonedGuardedError', error: error, stackTrace: stackTrace);
    throw error;
  });
}

class MedicalLaboratoryPDVApp extends StatelessWidget {
  const MedicalLaboratoryPDVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MedicalLaboratoryAppCore(
      title: 'Medical Laboratory PDV',
      bindings: MedicalLaboratoryApplicationBinding(),
      pagesBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/')
      ],
      modules: [AuthModule(), HomeModule()],
    );
  }
}
