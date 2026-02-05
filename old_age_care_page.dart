import 'package:flutter/material.dart';
import '../../services/shake_service.dart';
import '../../services/call_service.dart';

class OldAgeCarePage extends StatefulWidget {
  final String caretakerNumber;

  const OldAgeCarePage({super.key, required this.caretakerNumber});

  @override
  State<OldAgeCarePage> createState() => _OldAgeCarePageState();
}

class _OldAgeCarePageState extends State<OldAgeCarePage> {
  @override
  void initState() {
    super.initState();
    ShakeService.start(() {
      CallService.callNumber(widget.caretakerNumber);
    });
  }

  @override
  void dispose() {
    ShakeService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Shake the phone to alert caretaker",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
