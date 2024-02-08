import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/core/env.dart';
import 'package:flutter_getit/flutter_getit.dart';

class HealthCenterApplicationBinding extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton<RestClient>((i) => RestClient(Env.backendBaseUrl)),
      ];
}
