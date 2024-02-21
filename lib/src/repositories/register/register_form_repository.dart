import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/models/register_model.dart';

abstract interface class RegisterFormRepository {
  Future<Either<RepositoryException, Unit>> register(RegisterModel model);
}
