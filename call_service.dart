import 'package:url_launcher/url_launcher.dart';

class CallService {

  // Used by Old Age Care
  static Future<void> callNumber(String phoneNumber) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not call $phoneNumber';
    }
  }

  // Used by Maternity Safety
  static Future<void> makeCall(String phoneNumber) async {
    await callNumber(phoneNumber);
  }
}
