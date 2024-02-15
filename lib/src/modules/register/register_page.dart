import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/modules/register/register_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with MessagesViewMixin {
  final controller = Injector.get<RegisterController>();

  @override
  void initState() {
    messageListener(controller);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startProcess();
      effect(() {
        var baseRoute = '/register/';
        final step = controller.step;

        switch (step) {
          case FormSteps.none:
            return;
          case FormSteps.whoIAm:
            baseRoute += 'whoIAm';
          case FormSteps.findPatient:
            baseRoute += 'findPatient';
          case FormSteps.patient:
            baseRoute += 'patient';
          case FormSteps.documents:
            baseRoute += 'documents';
          case FormSteps.done:
            baseRoute += 'done';
          case FormSteps.restart:
            baseRoute += 'restart';
            return;
        }

        Navigator.of(context).pushNamed(baseRoute);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
