import 'package:flutter/material.dart';
import 'package:bus_app/pages/ringtones.dart';

class BusmetroPage extends StatefulWidget {
  const BusmetroPage({super.key});
  @override
  State<BusmetroPage> createState() => _BusmetroPageState();
}

class _BusmetroPageState extends State<BusmetroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bus/Metro"),
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
