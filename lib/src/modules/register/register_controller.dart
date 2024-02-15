import 'package:health_center_core/health_center_core.dart';
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
  final _step = ValueSignal(FormSteps.none);

  FormSteps get step => _step();

  void startProcess() {
    _step.forceUpdate(FormSteps.whoIAm);
  }
}
