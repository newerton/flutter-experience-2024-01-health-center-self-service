import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/binding/health_center_application_binding.dart';
import 'package:health_center_self_service/src/modules/auth/auth_module.dart';
import 'package:health_center_self_service/src/modules/home/home_module.dart';
import 'package:health_center_self_service/src/modules/register/register_module.dart';
import 'package:health_center_self_service/src/pages/splash_screen/page.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> _cameras;

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();

    runApp(const HealthCenterSelfServiceApp());
  }, (error, stackTrace) {
    log('runZonedGuardedError', error: error, stackTrace: stackTrace);
    throw error;
  });
}

class HealthCenterSelfServiceApp extends StatelessWidget {
  const HealthCenterSelfServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthCenterAppCore(
      title: 'Health Center',
      bindings: HealthCenterApplicationBinding(),
      pagesBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/')
      ],
      modules: [AuthModule(), HomeModule(), RegisterModule()],
      onInit: () {
        FlutterGetItBindingRegister.registerPermanentBinding(
            'CAMERAS', [Bind.lazySingleton((i) => _cameras)]);
      },
    );
  }
}
