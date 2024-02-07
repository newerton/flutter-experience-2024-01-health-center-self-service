import 'package:flutter_experience_medical_laboratory_core/flutter_experience_medical_laboratory_core.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException, Unit>> execute(String email, String password);
}
