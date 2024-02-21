import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/models/register_model.dart';
import 'package:health_center_self_service/src/modules/register/patient/patient_controller.dart';
import 'package:health_center_self_service/src/modules/register/patient/patient_form_controller.dart';
import 'package:health_center_self_service/src/modules/register/register_controller.dart';
import 'package:health_center_self_service/src/modules/register/widgets/register_app_bar.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage>
    with PatienFormController, MessagesViewMixin {
  final formKey = GlobalKey<FormState>();
  final registerController = Injector.get<RegisterController>();
  final PatientController controller = Injector.get<PatientController>();

  late bool patientFound;
  late bool enableForm;

  @override
  void dispose() {
    disposeForm();
    super.dispose();
  }

  @override
  void initState() {
    messageListener(controller);
    final RegisterModel(:patient) = registerController.model;
    patientFound = patient != null;
    enableForm = !patientFound;
    initializeForm(patient);

    effect(() {
      if (controller.nextStep) {
        registerController.updatePatientAndGoDocument(controller.patient);
      }
    });
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Visibility(
                            visible: patientFound,
                            replacement:
                                Image.asset('assets/images/lupa_icon.png'),
                            child: Image.asset('assets/images/check_icon.png'),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Visibility(
                            visible: patientFound,
                            replacement: const Text(
                              'Registration not found',
                              style: HealthCenterTheme.titleSmallStyle,
                            ),
                            child: const Text(
                              'Registration found',
                              style: HealthCenterTheme.titleSmallStyle,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Visibility(
                            visible: patientFound,
                            replacement: const Text(
                              'Please, fill in the fields below to complete your registration',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: HealthCenterTheme.blueColor,
                              ),
                            ),
                            child: const Text(
                              'Confirm your registration details',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: HealthCenterTheme.blueColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: nameEC,
                            readOnly: !enableForm,
                            decoration:
                                const InputDecoration(label: Text('Name')),
                            validator: Validatorless.required('Field required'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: emailEC,
                            readOnly: !enableForm,
                            decoration:
                                const InputDecoration(label: Text('E-mail')),
                            keyboardType: TextInputType.emailAddress,
                            validator: Validatorless.multiple([
                              Validatorless.required('Field required'),
                              Validatorless.email('Invalid e-mail'),
                            ]),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: phoneEC,
                            readOnly: !enableForm,
                            decoration:
                                const InputDecoration(label: Text('Phone')),
                            validator: Validatorless.required('Field required'),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter()
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: documentEC,
                            readOnly: !enableForm,
                            decoration:
                                const InputDecoration(label: Text('Document')),
                            validator: Validatorless.required('Field required'),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfInputFormatter()
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: zipCodeEC,
                            readOnly: !enableForm,
                            decoration:
                                const InputDecoration(label: Text('Zipcode')),
                            validator: Validatorless.required('Field required'),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter()
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: TextFormField(
                                  controller: streetEC,
                                  readOnly: !enableForm,
                                  decoration: const InputDecoration(
                                      label: Text('Street')),
                                  validator:
                                      Validatorless.required('Field required'),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  controller: numberEC,
                                  readOnly: !enableForm,
                                  decoration:
                                      const InputDecoration(label: Text('Nº')),
                                  validator:
                                      Validatorless.required('Field required'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: complementEC,
                                  readOnly: !enableForm,
                                  decoration: const InputDecoration(
                                      label: Text('Complement')),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: neighborhoodEC,
                                  readOnly: !enableForm,
                                  decoration: const InputDecoration(
                                      label: Text('Neighborhood')),
                                  validator:
                                      Validatorless.required('Field required'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: cityEC,
                                  readOnly: !enableForm,
                                  decoration: const InputDecoration(
                                      label: Text('City')),
                                  validator:
                                      Validatorless.required('Field required'),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: stateEC,
                                  readOnly: !enableForm,
                                  decoration: const InputDecoration(
                                      label: Text('State')),
                                  validator:
                                      Validatorless.required('Field required'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: guardianEC,
                            readOnly: !enableForm,
                            decoration: const InputDecoration(
                                label: Text('Responsible')),
                            validator: Validatorless.required('Field required'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: guardianIdentificationNumberEC,
                            readOnly: !enableForm,
                            decoration: const InputDecoration(
                                label: Text('Identification Document')),
                            validator: Validatorless.required('Field required'),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Visibility(
                            visible: !enableForm,
                            replacement: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  final valid =
                                      formKey.currentState?.validate() ?? false;

                                  if (valid) {
                                    if (!patientFound) {
                                      controller.createAndNext(createPatient());
                                    } else {
                                      controller.updateAndNext(updatePatient(
                                          registerController.model.patient!));
                                    }
                                  }
                                },
                                child: Visibility(
                                  visible: patientFound,
                                  replacement: const Text('Edit and continue'),
                                  child: const Text('Continue'),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        enableForm = true;
                                      });
                                    },
                                    child: const Text('Edit'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final valid =
                                          formKey.currentState?.validate() ??
                                              false;

                                      if (valid) {
                                        controller.patient =
                                            registerController.model.patient;
                                        controller.getNextStep();
                                      }
                                    },
                                    child: const Text('Continue'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )))));
  }
}
