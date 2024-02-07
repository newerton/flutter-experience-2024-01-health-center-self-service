import 'package:flutter/material.dart';

import 'package:flutter_experience_medical_laboratory_pdv/src/modules/auth/login/login_route.dart';
import 'package:flutter_experience_medical_laboratory_pdv/src/repositories/user/user_repository.dart';
import 'package:flutter_experience_medical_laboratory_pdv/src/repositories/user/user_repository_impl.dart';
import 'package:flutter_getit/flutter_getit.dart';

class AuthModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<UserRepository>(
            (i) => UserRepositoryImpl(restClient: i()))
      ];

  @override
  String get moduleRouteName => '/auth';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/login': (_) => const LoginRouter(),
      };
}
