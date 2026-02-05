import 'package:flutter/material.dart';
import '../home/home_page.dart';

class OldAgeFormPage extends StatefulWidget {
  final String caretakerNumber;

  const OldAgeFormPage({super.key, required this.caretakerNumber});

  @override
  State<OldAgeFormPage> createState() => _OldAgeFormPageState();
}

class _OldAgeFormPageState extends State<OldAgeFormPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final medicalController = TextEditingController();

  void _submit() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(
          userType: "old_age",
          caretakerNumber: widget.caretakerNumber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Old Age Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age"),
            ),
            TextField(
              controller: medicalController,
              decoration: const InputDecoration(
                labelText: "Medical Conditions",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submit,
              child: const Text("Save & Continue"),
            )
          ],
        ),
      ),
    );
  }
}
