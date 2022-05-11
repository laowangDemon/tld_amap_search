import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tld_amapsearch/tld_amapsearch.dart';

void main() {
  const MethodChannel channel = MethodChannel('tld_amapsearch');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TldAmapSearch.platformVersion, '42');
  });
}
