import 'package:asyncstate/asyncstate.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/models/patient_model.dart';
import 'package:health_center_self_service/src/models/register_model.dart';
import 'package:health_center_self_service/src/repositories/register/register_form_repository.dart';
import 'package:health_center_self_service/src/repositories/register/register_form_repository_impl.dart';
import 'package:signals_flutter/signals_flutter.dart';

enum FormSteps {
  none,
  whoIAm,
  findPatient,
  patient,
  documents,
  done,
  restart,
}

class RegisterController with MessageStateMixin {
  RegisterController({
    required this.repository,
  });

  final RegisterFormRepository repository;

  final _step = ValueSignal(FormSteps.none);

  var _model = const RegisterModel();
  var password = '';

  RegisterModel get model => _model;
  FormSteps get step => _step();

  void startProcess() {
    _step.forceUpdate(FormSteps.whoIAm);
  }

  void clearForm() {
    _model = _model.clear();
  }

  void setWhoIAmDataStepAndNext(String firstName, String lastName) {
    _model = _model.copyWith(
      firstName: () => firstName,
      lastName: () => lastName,
    );
    _step.forceUpdate(FormSteps.findPatient);
  }

  void goToFormPatient(PatientModel? patient) {
    _model = _model.copyWith(patient: () => patient);
    _step.forceUpdate(FormSteps.patient);
  }

  void restartProcess() {
    _step.forceUpdate(FormSteps.restart);
    clearForm();
  }

  void updatePatientAndGoDocument(PatientModel? patient) {
    _model = _model.copyWith(patient: () => patient);
    _step.forceUpdate(FormSteps.documents);
  }

  void registerDocument(DocumentType type, String filePath) {
    final documents = _model.documents ?? {};
    if (type == DocumentType.healthInsuranceCard) {
      documents[type]?.clear();
    }

    final values = documents[type] ?? [];
    values.add(filePath);
    documents[type] = values;

    _model = _model.copyWith(documents: () => documents);
  }

  void clearDocuments() {
    _model = _model.copyWith(documents: () => {});
  }

  Future<void> done() async {
    final result = await repository.register(model).asyncLoader();

    switch (result) {
      case Left():
        showError('Error on register');
      case Right():
        password = '${_model.firstName} ${_model.lastName}';
        _step.forceUpdate(FormSteps.done);
    }
  }
}
