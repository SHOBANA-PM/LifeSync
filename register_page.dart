import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../maternity/pregnancy_details_page.dart';
import '../old_age_care/old_age_form_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String category = "Old Age";
  final TextEditingController caretakerController = TextEditingController();

  void _register() {
    if (category == "Old Age") {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Caretaker Number"),
          content: TextField(
            controller: caretakerController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: "Enter caretaker phone number",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OldAgeFormPage(
                      caretakerNumber: caretakerController.text,
                    ),
                  ),
                );
              },
              child: const Text("Continue"),
            )
          ],
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const PregnancyDetailsPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: category,
              items: const [
                DropdownMenuItem(value: "Old Age", child: Text("Old Age")),
                DropdownMenuItem(value: "Pregnant", child: Text("Pregnant Woman")),
              ],
              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
              decoration: const InputDecoration(labelText: "Category"),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _register,
                child: const Text("Register"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
