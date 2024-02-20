import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:health_center_self_service/src/modules/register/register_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class WhoIAmPage extends StatefulWidget {
  const WhoIAmPage({super.key});

  @override
  State<WhoIAmPage> createState() => _WhoIAmPageState();
}

class _WhoIAmPageState extends State<WhoIAmPage> {
  final controller = Injector.get<RegisterController>();

  final formKey = GlobalKey<FormState>();
  final firstNameEC = TextEditingController();
  final lastNameEC = TextEditingController();

  @override
  void dispose() {
    firstNameEC.dispose();
    lastNameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    var focusNode = FocusNode();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        firstNameEC.clear();
        lastNameEC.clear();
        controller.clearForm();
        focusNode.requestFocus();
      },
      child: Scaffold(
        appBar: HealthCenterAppBar(automaticallyImplyLeading: false, actions: [
          PopupMenuButton(
            child: const IconPopupMenuWidget(),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                )
              ];
            },
            onSelected: (value) async {
              if (value == 'logout') {
                await SharedPreferences.getInstance().then((prefs) {
                  prefs.clear();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/auth/login', (router) => false);
                });
              }
            },
          )
        ]),
        body: LayoutBuilder(
          builder: (_, constrains) {
            return SingleChildScrollView(
                child: Container(
              constraints: BoxConstraints(minHeight: constrains.maxHeight),
              padding: const EdgeInsets.all(40),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_login.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                    constraints: BoxConstraints(maxWidth: sizeOf.width * 0.8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.all(40),
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: Column(
                      children: [
                        Image.asset('assets/images/logo_vertical.png'),
                        const SizedBox(
                          height: 48,
                        ),
                        const Text('Welcome!',
                            style: HealthCenterTheme.titleStyle),
                        const SizedBox(
                          height: 48,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: firstNameEC,
                                validator:
                                    Validatorless.required('Field required'),
                                decoration:
                                    const InputDecoration(label: Text('Nome')),
                                autofocus: true,
                                focusNode: focusNode,
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: lastNameEC,
                                validator:
                                    Validatorless.required('Field required'),
                                decoration: const InputDecoration(
                                  label: Text('Sobrenome'),
                                ),
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                width: sizeOf.width * 0.8,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final valid =
                                        formKey.currentState?.validate() ??
                                            false;

                                    if (valid) {
                                      controller.setWhoIAmDataStepAndNext(
                                          firstNameEC.text, lastNameEC.text);
                                    }
                                  },
                                  child: const Text('Continuar'),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ));
          },
        ),
      ),
    );
  }
}
