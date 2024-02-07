import 'package:flutter_experience_medical_laboratory_core/flutter_experience_medical_laboratory_core.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}
