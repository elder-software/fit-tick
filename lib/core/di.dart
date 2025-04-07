import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_tick_mobile/data/auth_service.dart'; // Adjust the import path if necessary

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
