import 'dart:typed_data';

import 'package:health_center_core/health_center_core.dart';

abstract interface class DocumentsRepository {
  Future<Either<RepositoryException, String>> uploadImage(
      Uint8List imageBytes, String filename);
}
