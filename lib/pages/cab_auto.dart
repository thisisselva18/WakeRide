import 'package:flutter/material.dart';
import 'ringtones.dart';

class CabautoPage extends StatefulWidget {
  const CabautoPage({super.key});

  @override
  State<CabautoPage> createState() => _CabautoPageState();
}

class _CabautoPageState extends State<CabautoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cab/Auto Rickshaw"),
        surfaceTintColor: Colors.purple,
        elevation: 5.0,
        shadowColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OutlinedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                ),
                onPressed: () async {
                  final selectedRingtone = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RingtonesPage(),
                    ),
                  );
                  if (selectedRingtone != null) {
                    debugPrint('Selected Ringtone: $selectedRingtone');
                  }
                },
                child: Text(
                  "Select Ringtone",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    decorationColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
