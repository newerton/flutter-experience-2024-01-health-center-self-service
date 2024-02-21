import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/modules/register/documents/scan_confirm/documents_scan_confirm_controller.dart';
import 'package:health_center_self_service/src/modules/register/widgets/register_app_bar.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DocumentsScanConfirmPage extends StatefulWidget {
  const DocumentsScanConfirmPage({super.key});

  @override
  State<DocumentsScanConfirmPage> createState() =>
      _DocumentsScanConfirmPageState();
}

class _DocumentsScanConfirmPageState extends State<DocumentsScanConfirmPage> {
  final controller = Injector.get<DocumentsScanConfirmController>();

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final photo = ModalRoute.of(context)!.settings.arguments as XFile;

    controller.pathRemoteStorage.listen(context, () {
      Navigator.of(context).pop();
      Navigator.of(context).pop(controller.pathRemoteStorage.value);
    });

    return Scaffold(
      appBar: RegisterAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: sizeOf.width * 0.85,
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: HealthCenterTheme.orangeColor),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/foto_confirm_icon.png'),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Confirm the photo',
                  style: HealthCenterTheme.titleSmallStyle,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                    width: sizeOf.width * 0.55,
                    child: DottedBorder(
                        dashPattern: const [1, 10, 2, 3],
                        borderType: BorderType.RRect,
                        strokeWidth: 4,
                        color: HealthCenterTheme.orangeColor,
                        strokeCap: StrokeCap.square,
                        child: Image.file(File(photo.path)))),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Take another'),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final imageBytes = await photo.readAsBytes();
                          final fileName = photo.name;
                          await controller.uploadImage(imageBytes, fileName);
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
