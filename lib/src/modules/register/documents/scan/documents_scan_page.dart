import 'package:asyncstate/asyncstate.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/modules/register/widgets/register_app_bar.dart';

class DocumentsScanPage extends StatefulWidget {
  const DocumentsScanPage({super.key});

  @override
  State<DocumentsScanPage> createState() => _DocumentsScanPageState();
}

class _DocumentsScanPageState extends State<DocumentsScanPage> {
  late CameraController cameraController;

  @override
  void initState() {
    cameraController = CameraController(
      Injector.get<List<CameraDescription>>().first,
      ResolutionPreset.ultraHigh,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
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
                Image.asset('assets/images/folder.png'),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Take a photo',
                  style: HealthCenterTheme.titleSmallStyle,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Position the document in the frame and take a photo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: HealthCenterTheme.blueColor,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                FutureBuilder(
                    future: cameraController.initialize(),
                    builder: (context, snapshot) {
                      switch (snapshot) {
                        case AsyncSnapshot(
                            connectionState: ConnectionState.waiting ||
                                ConnectionState.active
                          ):
                          return const Center(
                              child: CircularProgressIndicator());
                        case AsyncSnapshot(
                            connectionState: ConnectionState.done
                          ):
                          if (cameraController.value.isInitialized) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                width: sizeOf.width * 0.55,
                                child: CameraPreview(
                                  cameraController,
                                  child: DottedBorder(
                                      dashPattern: const [1, 10, 2, 3],
                                      borderType: BorderType.RRect,
                                      strokeWidth: 4,
                                      color: HealthCenterTheme.orangeColor,
                                      strokeCap: StrokeCap.square,
                                      child: const SizedBox.expand()),
                                ),
                              ),
                            );
                          }
                      }

                      return const Center(
                          child: Text('Error to initialize the camera'));
                    }),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                    width: sizeOf.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        final nav = Navigator.of(context);
                        final photo =
                            await cameraController.takePicture().asyncLoader();

                        nav.pushNamed('/register/documents/scan/confirm',
                            arguments: photo);
                      },
                      child: const Text('Take a photo'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
