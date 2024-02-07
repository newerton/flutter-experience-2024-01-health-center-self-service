import 'package:flutter_experience_medical_laboratory_core/flutter_experience_medical_laboratory_core.dart';
import 'package:flutter_experience_medical_laboratory_pdv/src/repositories/user/user_repository.dart';
import 'package:flutter_experience_medical_laboratory_pdv/src/services/user/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements UserLoginService {
  UserLoginServiceImpl({required this.userRepository});

  final UserRepository userRepository;

  @override
  Future<Either<ServiceException, Unit>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Left(value: AuthError()):
        return Left(ServiceException(message: 'Login error'));
      case Left(value: AuthUnauthorizedException()):
        return Left(ServiceException(message: 'Unauthorized'));
      case Right(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageConstants.accessToken, accessToken);
        return Right(unit);
    }
  }
}
