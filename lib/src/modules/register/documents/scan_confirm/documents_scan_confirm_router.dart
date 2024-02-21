import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_self_service/src/modules/register/documents/scan_confirm/documents_scan_confirm_controller.dart';
import 'package:health_center_self_service/src/modules/register/documents/scan_confirm/documents_scan_confirm_page.dart';
import 'package:health_center_self_service/src/repositories/documents/documents_repository.dart';
import 'package:health_center_self_service/src/repositories/documents/documents_repository_impl.dart';

class DocumentsScanConfirmRouter extends FlutterGetItModulePageRouter {
  const DocumentsScanConfirmRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<DocumentsRepository>(
            (i) => DocumentsRepositoryImpl(restClient: i())),
        Bind.lazySingleton(
            (i) => DocumentsScanConfirmController(documentsRepository: i()))
      ];

  @override
  WidgetBuilder get view => (_) => const DocumentsScanConfirmPage();
}
