import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/modules/register/register_controller.dart';

class RegisterAppBar extends HealthCenterAppBar {
  RegisterAppBar({super.key})
      : super(automaticallyImplyLeading: false, actions: [
          PopupMenuButton(
            child: const IconPopupMenuWidget(),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'restart',
                  child: Text('Start process'),
                )
              ];
            },
            onSelected: (value) async {
              Injector.get<RegisterController>().restartProcess();
            },
          )
        ]);
}
