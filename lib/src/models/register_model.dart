import 'package:flutter/material.dart';

import 'package:health_center_self_service/src/models/patient_model.dart';

final class RegisterModel {
  const RegisterModel({
    this.firstName,
    this.lastName,
    this.patient,
  });

  final String? firstName;
  final String? lastName;
  final PatientModel? patient;

  RegisterModel clear() {
    return copyWith(
      firstName: () => null,
      lastName: () => null,
      patient: () => null,
    );
  }

  RegisterModel copyWith({
    ValueGetter<String?>? firstName,
    ValueGetter<String?>? lastName,
    ValueGetter<PatientModel?>? patient,
  }) {
    return RegisterModel(
      firstName: firstName != null ? firstName() : this.firstName,
      lastName: lastName != null ? lastName() : this.lastName,
      patient: patient != null ? patient() : this.patient,
    );
  }
}
