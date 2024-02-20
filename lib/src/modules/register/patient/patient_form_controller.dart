import 'package:flutter/material.dart';
import 'package:health_center_self_service/src/models/patient_model.dart';
import 'package:health_center_self_service/src/modules/register/patient/patient_page.dart';
import 'package:health_center_self_service/src/repositories/patients/patient_repository.dart';

mixin PatienFormController on State<PatientPage> {
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final phoneEC = TextEditingController();
  final documentEC = TextEditingController();
  final zipCodeEC = TextEditingController();
  final streetEC = TextEditingController();
  final numberEC = TextEditingController();
  final complementEC = TextEditingController();
  final neighborhoodEC = TextEditingController();
  final cityEC = TextEditingController();
  final stateEC = TextEditingController();
  final guardianEC = TextEditingController();
  final guardianIdentificationNumberEC = TextEditingController();

  void disposeForm() {
    nameEC.dispose();
    emailEC.dispose();
    phoneEC.dispose();
    documentEC.dispose();
    zipCodeEC.dispose();
    streetEC.dispose();
    numberEC.dispose();
    complementEC.dispose();
    neighborhoodEC.dispose();
    cityEC.dispose();
    stateEC.dispose();
    guardianEC.dispose();
    guardianIdentificationNumberEC.dispose();
  }

  void initializeForm(final PatientModel? patient) {
    if (patient != null) {
      nameEC.text = patient.name;
      emailEC.text = patient.email;
      phoneEC.text = patient.phoneNumber;
      documentEC.text = patient.document;
      zipCodeEC.text = patient.address.cep;
      streetEC.text = patient.address.streetAddress;
      numberEC.text = patient.address.number;
      complementEC.text = patient.address.complement;
      neighborhoodEC.text = patient.address.district;
      cityEC.text = patient.address.city;
      stateEC.text = patient.address.state;
      guardianEC.text = patient.guardian;
      guardianIdentificationNumberEC.text = patient.guardianIdNumber;
    }
  }

  PatientModel updatePatient(PatientModel patient) {
    return patient.copyWith(
      name: nameEC.text,
      email: emailEC.text,
      phoneNumber: phoneEC.text,
      document: documentEC.text,
      address: patient.address.copyWith(
        cep: zipCodeEC.text,
        streetAddress: streetEC.text,
        number: numberEC.text,
        complement: complementEC.text,
        district: neighborhoodEC.text,
        city: cityEC.text,
        state: stateEC.text,
      ),
      guardian: guardianEC.text,
      guardianIdNumber: guardianIdentificationNumberEC.text,
    );
  }

  RegisterPatientModel createPatient() {
    return (
      name: nameEC.text,
      email: emailEC.text,
      phoneNumber: phoneEC.text,
      document: documentEC.text,
      guardian: guardianEC.text,
      guardianIdNumber: guardianIdentificationNumberEC.text,
      address: (
        zipCode: zipCodeEC.text,
        street: streetEC.text,
        number: numberEC.text,
        complement: complementEC.text,
        neighborhood: neighborhoodEC.text,
        city: cityEC.text,
        state: stateEC.text,
      ),
    );
  }
}
