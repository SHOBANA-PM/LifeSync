import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PregnancyStorageService {
  static const String _key = "pregnancy_records";

  static Future<void> saveMonthlyRecord({
    required String name,
    required int month,
    required String hospital,
    required String bp,
    required String sugar,
    required String weight,
    required String notes,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> records = {};

    final existingData = prefs.getString(_key);
    if (existingData != null) {
      records = jsonDecode(existingData);
    }

    records[month.toString()] = {
      "name": name,
      "month": month,
      "hospital": hospital,
      "bp": bp,
      "sugar": sugar,
      "weight": weight,
      "notes": notes,
      "savedAt": DateTime.now().toIso8601String(),
    };

    await prefs.setString(_key, jsonEncode(records));
  }

  static Future<Map<String, dynamic>> getAllRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return {};
    return jsonDecode(data);
  }
}
