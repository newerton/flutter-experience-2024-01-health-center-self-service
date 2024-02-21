import 'dart:typed_data';

import 'package:asyncstate/asyncstate.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/repositories/documents/documents_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DocumentsScanConfirmController with MessageStateMixin {
  DocumentsScanConfirmController({
    required this.documentsRepository,
  });

  final DocumentsRepository documentsRepository;

  final pathRemoteStorage = signal<String?>(null);

  Future<void> uploadImage(Uint8List imageBytes, String filename) async {
    final result = await documentsRepository
        .uploadImage(imageBytes, filename)
        .asyncLoader();

    switch (result) {
      case Left():
        showError('Error on upload image');
      case Right(value: final pathFile):
        pathRemoteStorage.value = pathFile;
    }
  }
}
