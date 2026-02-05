import 'package:flutter/material.dart';
import '../../services/call_service.dart';
import '../../services/pregnancy_storage_service.dart';

class PregnancyDetailsPage extends StatefulWidget {
  const PregnancyDetailsPage({super.key});

  @override
  State<PregnancyDetailsPage> createState() =>
      _PregnancyDetailsPageState();
}

class _PregnancyDetailsPageState
    extends State<PregnancyDetailsPage> {

  final _nameController = TextEditingController();
  final _monthController = TextEditingController();
  final _hospitalController = TextEditingController();
  final _bpController = TextEditingController();
  final _sugarController = TextEditingController();
  final _weightController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🤰 Monthly Pregnancy Health Records"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _field(_nameController, "Patient Name"),
              _field(_monthController, "Pregnancy Month (1–9)", isNum: true),
              _field(_hospitalController, "Hospital Name"),
              _field(_bpController, "Blood Pressure (e.g. 120/80)"),
              _field(_sugarController, "Sugar Level (mg/dL)", isNum: true),
              _field(_weightController, "Weight (kg)", isNum: true),
              _field(_notesController, "Doctor Notes / Symptoms"),

              const SizedBox(height: 20),

              // ✅ SAVE MONTH RECORD
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: _saveRecord,
                child: const Text("Save Monthly Health Record"),
              ),

              const SizedBox(height: 12),

              // 📋 VIEW ALL RECORDS
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: _viewRecords,
                child: const Text("View All Monthly Records"),
              ),

              const SizedBox(height: 20),

              // 🚨 EMERGENCY CALL
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  CallService.callNumber("108");
                },
                child: const Text("🚨 Emergency Contact Hospital"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= LOGIC =================

  Future<void> _saveRecord() async {
    final month = int.tryParse(_monthController.text);

    if (month == null || month < 1 || month > 9) {
      _show("Enter valid pregnancy month (1–9)");
      return;
    }

    await PregnancyStorageService.saveMonthlyRecord(
      name: _nameController.text,
      month: month,
      hospital: _hospitalController.text,
      bp: _bpController.text,
      sugar: _sugarController.text,
      weight: _weightController.text,
      notes: _notesController.text,
    );

    _show("Month $month medical record saved ✅");
  }

  Future<void> _viewRecords() async {
    final records =
    await PregnancyStorageService.getAllRecords();

    if (records.isEmpty) {
      _show("No records saved");
      return;
    }

    final keys = records.keys.toList()
      ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("📋 Monthly Medical Records"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: keys.map((k) {
              final r = records[k];
              return Card(
                child: ListTile(
                  title: Text("Month ${r['month']}"),
                  subtitle: Text(
                    "BP: ${r['bp']}\n"
                        "Sugar: ${r['sugar']}\n"
                        "Weight: ${r['weight']} kg\n"
                        "Notes: ${r['notes']}",
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"))
        ],
      ),
    );
  }

  // ================= UI HELPERS =================

  Widget _field(TextEditingController c, String label,
      {bool isNum = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType:
        isNum ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _show(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
