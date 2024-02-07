import 'package:flutter/material.dart';
import 'package:flutter_experience_medical_laboratory_core/flutter_experience_medical_laboratory_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: MedicalLaboratoryAppBar(
        actions: [
          PopupMenuButton(
            child: const IconPopupMenuWidget(),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Start Terminal'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Logout'),
              )
            ],
          )
        ],
      ),
      body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: sizeOf.width * 0.8,
            padding: const EdgeInsets.all(40),
            margin: const EdgeInsets.only(top: 100),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MedicalLaboratoryTheme.orangeColor)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Welcome!',
                    style: MedicalLaboratoryTheme.titleStyle),
                const SizedBox(height: 32),
                SizedBox(
                  width: sizeOf.width * 0.8,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text('Start Terminal')),
                )
              ],
            ),
          )),
    );
  }
}
