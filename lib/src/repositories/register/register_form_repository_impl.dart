import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/models/patient_model.dart';
import 'package:health_center_self_service/src/models/register_model.dart';

import './register_form_repository.dart';

class RegisterFormRepositoryImpl implements RegisterFormRepository {
  RegisterFormRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, Unit>> register(
      RegisterModel model) async {
    try {
      final RegisterModel(
        :firstName!,
        :lastName!,
        patient: PatientModel(id: patientId)!,
        documents: {
          DocumentType.healthInsuranceCard: List(first: healthInsuranceCardDoc),
          DocumentType.medicalOrder: medicalOrderDocs,
        }!
      ) = model;

      await restClient.auth.post('/patientInformationForm', data: {
        'patient_id': patientId,
        'health_insurence_card': healthInsuranceCardDoc,
        'medical_order': medicalOrderDocs,
        'password': '$firstName $lastName',
        'date_created': DateTime.now().toIso8601String(),
        'status': 'Waiting',
        'tests': []
      });

      return Right(unit);
    } on DioException catch (e, s) {
      log('Error on register', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
