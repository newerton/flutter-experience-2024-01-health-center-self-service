import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_self_service/src/modules/register/documents/documents_page.dart';
import 'package:health_center_self_service/src/modules/register/documents/scan/documents_scan_page.dart';
import 'package:health_center_self_service/src/modules/register/documents/scan_confirm/documents_scan_confirm_router.dart';
import 'package:health_center_self_service/src/modules/register/done/done_page.dart';
import 'package:health_center_self_service/src/modules/register/find_patient/find_patient_router.dart';
import 'package:health_center_self_service/src/modules/register/patient/patient_router.dart';
import 'package:health_center_self_service/src/modules/register/register_controller.dart';
import 'package:health_center_self_service/src/modules/register/register_page.dart';
import 'package:health_center_self_service/src/modules/register/who_i_am/who_i_am_page.dart';
import 'package:health_center_self_service/src/repositories/patients/patient_repository.dart';
import 'package:health_center_self_service/src/repositories/patients/patient_repository_impl.dart';
import 'package:health_center_self_service/src/repositories/register/register_form_repository.dart';
import 'package:health_center_self_service/src/repositories/register/register_form_repository_impl.dart';

class RegisterModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<RegisterFormRepository>(
            (i) => RegisterFormRepositoryImpl(restClient: i())),
        Bind.lazySingleton((i) => RegisterController(repository: i())),
        Bind.lazySingleton<PatientRepository>(
            (i) => PatientRepositoryImpl(restClient: i()))
      ];

  @override
  String get moduleRouteName => '/register';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const RegisterPage(),
        '/whoIAm': (context) => const WhoIAmPage(),
        '/findPatient': (context) => const FindPatientRouter(),
        '/patient': (context) => const PatientRouter(),
        '/documents': (context) => const DocumentsPage(),
        '/documents/scan': (context) => const DocumentsScanPage(),
        '/documents/scan/confirm': (context) =>
            const DocumentsScanConfirmRouter(),
        '/done': (context) => DonePage(),
      };
}
