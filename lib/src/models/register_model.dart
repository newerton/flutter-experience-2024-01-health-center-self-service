import 'package:flutter/material.dart';
import 'package:health_center_self_service/src/models/patient_model.dart';

enum DocumentType {
  healthInsuranceCard,
  medicalOrder,
}

final class RegisterModel {
  const RegisterModel({
    this.firstName,
    this.lastName,
    this.patient,
    this.documents,
  });

  final String? firstName;
  final String? lastName;
  final PatientModel? patient;
  final Map<DocumentType, List<String>>? documents;

  RegisterModel clear() {
    return copyWith(
      firstName: () => null,
      lastName: () => null,
      patient: () => null,
      documents: () => null,
    );
  }

  RegisterModel copyWith({
    ValueGetter<String?>? firstName,
    ValueGetter<String?>? lastName,
    ValueGetter<PatientModel?>? patient,
    ValueGetter<Map<DocumentType, List<String>>?>? documents,
  }) {
    return RegisterModel(
      firstName: firstName != null ? firstName() : this.firstName,
      lastName: lastName != null ? lastName() : this.lastName,
      patient: patient != null ? patient() : this.patient,
      documents: documents != null ? documents() : this.documents,
    );
  }
}
