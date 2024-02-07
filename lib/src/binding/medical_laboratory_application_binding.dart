import 'package:flutter_experience_medical_laboratory_core/flutter_experience_medical_laboratory_core.dart';
import 'package:flutter_experience_medical_laboratory_pdv/src/core/env.dart';
import 'package:flutter_getit/flutter_getit.dart';

class MedicalLaboratoryApplicationBinding extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton<RestClient>((i) => RestClient(Env.backendBaseUrl)),
      ];
}
