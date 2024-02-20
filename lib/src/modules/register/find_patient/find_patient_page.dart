import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/modules/register/find_patient/find_patient_controller.dart';
import 'package:health_center_self_service/src/modules/register/register_controller.dart';
import 'package:health_center_self_service/src/modules/register/widgets/register_app_bar.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class FindPatientPage extends StatefulWidget {
  const FindPatientPage({super.key});

  @override
  State<FindPatientPage> createState() => _FindPatientPageState();
}

class _FindPatientPageState extends State<FindPatientPage>
    with MessagesViewMixin {
  final controller = Injector.get<FindPatientController>();

  final formKey = GlobalKey<FormState>();
  final documentEC = TextEditingController();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      final FindPatientController(:patient, :patientNotFound) = controller;

      if (patient != null || patientNotFound != null) {
        Injector.get<RegisterController>().goToFormPatient(patient);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    documentEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    var focusNode = FocusNode();

    return Scaffold(
      appBar: RegisterAppBar(),
      body: LayoutBuilder(
        builder: (_, constrains) {
          return SingleChildScrollView(
              child: Container(
            constraints: BoxConstraints(minHeight: constrains.maxHeight),
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_login.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                  constraints: BoxConstraints(maxWidth: sizeOf.width * 0.8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.all(40),
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo_vertical.png'),
                      const SizedBox(
                        height: 48,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: documentEC,
                              validator:
                                  Validatorless.required('Field required'),
                              decoration:
                                  const InputDecoration(label: Text('CPF')),
                              autofocus: true,
                              focusNode: focusNode,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CpfInputFormatter()
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Text(
                                  'Não sabe o CPF?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: HealthCenterTheme.blueColor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    controller.continueWithoutDocument();
                                  },
                                  child: const Text(
                                    'Clique aqui',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: HealthCenterTheme.orangeColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: sizeOf.width * 0.8,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  final valid =
                                      formKey.currentState?.validate() ?? false;

                                  if (valid) {
                                    controller
                                        .findPatientByDocument(documentEC.text);
                                  }
                                },
                                child: const Text('Continue'),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ));
        },
      ),
    );
  }
}
