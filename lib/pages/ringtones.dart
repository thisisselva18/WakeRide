import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RingtonesPage extends StatefulWidget {
  const RingtonesPage({super.key});

  @override
  State<RingtonesPage> createState() => _RingtonesPageState();
}

class _RingtonesPageState extends State<RingtonesPage> {
  static const MethodChannel _channel = MethodChannel('flutter_channel');

  List _ringtones = [];
  bool _isLoading = true;
  String? _errorMessage;
  dynamic _selectedRingtone;

  @override
  void initState() {
    super.initState();
    _fetchRingtones();
  }

  void _playRingtone(dynamic ringtone) async {
    try {
      await _channel.invokeMethod('playRingtone', {
        'ringtone': ringtone,
        'durationSeconds': 5,
      });
      debugPrint('Playing ringtone: $ringtone for 5 seconds.');
    } on PlatformException catch (e) {
      debugPrint("Failed to play ringtone: '${e.message}'.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not play ringtone: ${e.message}')),
      );
    }
  }

  void _stopRingtone() async {
    try {
      await _channel.invokeMethod('stopRingtone');
      debugPrint('Stopped ringtone playback.');
    } on PlatformException catch (e) {
      debugPrint("Failed to stop ringtone: '${e.message}'.");
    }
  }

  @override
  void dispose() {
    _stopRingtone();
    super.dispose();
  }

  Future<void> _fetchRingtones() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final fetchedRingtones = await _channel.invokeMethod('getRingtones');
      setState(() {
        _ringtones = fetchedRingtones;
        _isLoading = false;
        if (_ringtones.isNotEmpty) {
          _selectedRingtone = _ringtones[0];
        }
      });
    } on PlatformException catch (e) {
      setState(() {
        _errorMessage = "Failed to get ringtones: '${e.message}'.";
        _isLoading = false;
      });
      debugPrint(_errorMessage);
    } catch (e) {
      setState(() {
        _errorMessage = "An unexpected error occurred: ${e.toString()}";
        _isLoading = false;
      });
      debugPrint(_errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select Ringtone"),
        surfaceTintColor: Colors.purple,
        elevation: 5.0,
        shadowColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_errorMessage!),
                  ElevatedButton(
                    onPressed: _fetchRingtones,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            )
          : _ringtones.isEmpty
          ? const Center(child: Text("No ringtones found."))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _ringtones.length,
                    itemBuilder: (context, index) {
                      final ringtone = _ringtones[index];
                      final ringtoneName = ringtone.toString();

                      return RadioListTile<dynamic>(
                        title: Text(ringtoneName),
                        value: ringtone,
                        groupValue: _selectedRingtone,
                        onChanged: (dynamic? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedRingtone = newValue;
                            });
                            _playRingtone(newValue);
                          }
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _selectedRingtone == null
                        ? null
                        : () {
                            _stopRingtone();
                            Navigator.pop(context, _selectedRingtone);
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text(
                      "Confirm Selection",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
