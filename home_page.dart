import 'package:flutter/material.dart';
import '../../widgets/feature_card.dart';
import '../old_age_care/old_age_care_page.dart';
import '../maternity/maternity_page.dart';

class HomePage extends StatelessWidget {
  final String userType;
  final String? caretakerNumber;

  const HomePage({
    super.key,
    required this.userType,
    this.caretakerNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LifeSync Home")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (userType == "old_age")
              FeatureCard(
                title: "Old Age Care",
                subtitle: "Shake phone to alert caretaker",
                icon: Icons.elderly,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OldAgeCarePage(
                        caretakerNumber: caretakerNumber!,
                      ),
                    ),
                  );
                },
              ),

            if (userType == "pregnant")
              FeatureCard(
                title: "Maternity Care",
                subtitle: "Track pregnancy & emergency",
                icon: Icons.child_friendly,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MaternityPage(),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
