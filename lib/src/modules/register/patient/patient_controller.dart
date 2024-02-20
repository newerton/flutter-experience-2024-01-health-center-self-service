import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/models/patient_model.dart';
import 'package:health_center_self_service/src/repositories/patients/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PatientController with MessageStateMixin {
  PatientController({required PatientRepository repository})
      : _repository = repository;

  final PatientRepository _repository;
  PatientModel? patient;

  final _nextStep = signal<bool>(false);
  bool get nextStep => _nextStep();

  void getNextStep() {
    _nextStep.value = true;
  }

  void updateAndNext(PatientModel model) async {
    final result = await _repository.update(model);

    switch (result) {
      case Left():
        showError('Error updating patient');
      case Right():
        showInfo('Patient updated');
        patient = model;
        getNextStep();
    }
  }

  Future<void> createAndNext(RegisterPatientModel model) async {
    final result = await _repository.create(model);

    switch (result) {
      case Left():
        showError('Error creating patient');
      case Right(value: final patient):
        showInfo('Patient created');
        this.patient = patient;
        getNextStep();
    }
  }
}
