import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/modules/register/register_controller.dart';
import 'package:health_center_self_service/src/modules/register/widgets/register_app_bar.dart';

class DonePage extends StatelessWidget {
  final controller = Injector.get<RegisterController>();

  DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: RegisterAppBar(),
        body: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Container(
                    width: sizeOf.width * 0.85,
                    margin: const EdgeInsets.only(top: 18),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: HealthCenterTheme.orangeColor),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/stroke_check.png'),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'Your password is',
                          style: HealthCenterTheme.titleSmallStyle,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          width: sizeOf.width * 0.8,
                          height: 48,
                          decoration: BoxDecoration(
                            color: HealthCenterTheme.orangeColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              controller.password,
                              style: HealthCenterTheme.subTitleSmallStyle
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'PLEASE WAIT!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: HealthCenterTheme.blueColor,
                          ),
                        ),
                        const Text(
                          'Your password will be called up on the panel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: HealthCenterTheme.blueColor,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Print password'),
                            )),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: OutlinedButton(
                                  onPressed: () {},
                                  child: const Text('Send to SMS')),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: HealthCenterTheme.orangeColor),
                            onPressed: () {
                              controller.restartProcess();
                            },
                            child: const Text('Done'),
                          ),
                        )
                      ],
                    )))));
  }
}
