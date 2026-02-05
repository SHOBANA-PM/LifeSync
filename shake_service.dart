import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class ShakeService {
  static StreamSubscription? _subscription;
  static DateTime _lastShake = DateTime.now();

  static void start(Function onShake) {
    _subscription = accelerometerEvents.listen((event) {
      double gForce =
          event.x.abs() + event.y.abs() + event.z.abs();

      if (gForce > 25) {
        final now = DateTime.now();
        if (now.difference(_lastShake).inSeconds > 2) {
          _lastShake = now;
          onShake();
        }
      }
    });
  }

  static void stop() {
    _subscription?.cancel();
  }
}
