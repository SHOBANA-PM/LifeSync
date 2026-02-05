import 'package:flutter/material.dart';
import 'pregnancy_details_page.dart';

class MaternityPage extends StatelessWidget {
  const MaternityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maternity Safety"),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            padding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PregnancyDetailsPage(),
              ),
            );
          },
          child: const Text(
            "Open Pregnancy Records",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
