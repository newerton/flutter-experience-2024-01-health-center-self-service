import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:health_center_core/health_center_core.dart';

import './documents_repository.dart';

class DocumentsRepositoryImpl implements DocumentsRepository {
  DocumentsRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, String>> uploadImage(
      Uint8List imageBytes, String filename) async {
    try {
      final formData = FormData.fromMap(
          {"file": MultipartFile.fromBytes(imageBytes, filename: filename)});

      final Response(data: {'url': pathImage}) =
          await restClient.auth.post('/uploads', data: formData);

      return Right(pathImage);
    } on DioException catch (e, s) {
      log('Error on uploadImage', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
