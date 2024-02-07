import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_experience_medical_laboratory_core/flutter_experience_medical_laboratory_core.dart';
import 'package:flutter_experience_medical_laboratory_pdv/src/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(data: {'access_token': accessToken}) =
          await restClient.post(
        '/auth',
        data: {'email': email, 'password': password, 'admin': true},
      );

      return Right(accessToken);
    } on DioException catch (e, s) {
      log('Login error', error: e, stackTrace: s);
      return switch (e) {
        DioException(response: Response(statusCode: HttpStatus.forbidden)?) =>
          Left(AuthUnauthorizedException()),
        _ => Left(AuthError(message: 'Login error. Please try again.')),
      };
    }
  }
}