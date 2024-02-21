import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/models/register_model.dart';
import 'package:health_center_self_service/src/modules/register/documents/widgets/documents_box_widget.dart';
import 'package:health_center_self_service/src/modules/register/register_controller.dart';
import 'package:health_center_self_service/src/modules/register/widgets/register_app_bar.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> with MessagesViewMixin {
  final controller = Injector.get<RegisterController>();

  @override
  void initState() {
    messageListener(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final documents = controller.model.documents;

    final totalHealthInsuranceCard =
        documents?[DocumentType.healthInsuranceCard]?.length ?? 0;
    final totalMedicalOrder =
        documents?[DocumentType.medicalOrder]?.length ?? 0;

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
                          'Add documents',
                          style: HealthCenterTheme.titleSmallStyle,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'Select the document',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: HealthCenterTheme.blueColor,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: sizeOf.width * 0.85,
                          height: 160,
                          child: Row(
                            children: [
                              DocumentsBoxWidget(
                                  uploaded: totalHealthInsuranceCard > 0,
                                  icon:
                                      Image.asset('assets/images/id_card.png'),
                                  title: 'ID Card',
                                  count: totalHealthInsuranceCard,
                                  onTap: () async {
                                    final filePath = await Navigator.of(context)
                                        .pushNamed('/register/documents/scan');

                                    if (filePath != null && filePath != '') {
                                      controller.registerDocument(
                                          DocumentType.healthInsuranceCard,
                                          filePath.toString());
                                      setState(() {});
                                    }
                                  }),
                              const SizedBox(
                                width: 16,
                              ),
                              DocumentsBoxWidget(
                                  uploaded: totalMedicalOrder > 0,
                                  icon:
                                      Image.asset('assets/images/document.png'),
                                  title: 'Document',
                                  count: totalMedicalOrder,
                                  onTap: () async {
                                    final filePath = await Navigator.of(context)
                                        .pushNamed('/register/documents/scan');

                                    if (filePath != null && filePath != '') {
                                      controller.registerDocument(
                                          DocumentType.medicalOrder,
                                          filePath.toString());
                                      setState(() {});
                                    }
                                  }),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: totalHealthInsuranceCard > 0 &&
                              totalMedicalOrder > 0,
                          replacement: const SizedBox.shrink(),
                          child: Column(children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.red,
                                          side: const BorderSide(
                                              color: Colors.red)),
                                      onPressed: () {
                                        controller.clearDocuments();
                                        setState(() {});
                                      },
                                      child: const Text('Delete all')),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          HealthCenterTheme.orangeColor),
                                  onPressed: () async {
                                    await controller.done();
                                  },
                                  child: const Text('Finish'),
                                ))
                              ],
                            ),
                          ]),
                        )
                      ],
                    )))));
  }
}
