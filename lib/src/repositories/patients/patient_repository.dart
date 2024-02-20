import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/models/patient_model.dart';

typedef FindPatientAddressModel = ({
  String zipCode,
  String street,
  String number,
  String complement,
  String neighborhood,
  String city,
  String state,
});

typedef RegisterPatientModel = ({
  String name,
  String email,
  String phoneNumber,
  String document,
  String guardian,
  String guardianIdNumber,
  FindPatientAddressModel address,
});

abstract interface class PatientRepository {
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(
      String document);

  Future<Either<RepositoryException, PatientModel>> create(
      RegisterPatientModel patient);
  Future<Either<RepositoryException, Unit>> update(PatientModel patient);
}
