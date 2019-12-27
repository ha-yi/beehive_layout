import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beehive_layout/beehive_layout.dart';

void main() {
  const MethodChannel channel = MethodChannel('beehive_layout');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
