import 'package:flutter/material.dart';
import 'package:health_center_core/health_center_core.dart';

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
      appBar: HealthCenterAppBar(
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
                border: Border.all(color: HealthCenterTheme.orangeColor)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Welcome!', style: HealthCenterTheme.titleStyle),
                const SizedBox(height: 32),
                SizedBox(
                  width: sizeOf.width * 0.8,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                      child: const Text('Start Terminal')),
                )
              ],
            ),
          )),
    );
  }
}
