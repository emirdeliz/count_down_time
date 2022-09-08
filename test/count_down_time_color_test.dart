import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'count_down_time_utils.dart';

const retryLimit = 10;

void main() {
  group('have a count down with color', () {
    testWidgets('have a count down with color amber', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await makeApp(tester, color: Colors.amber);

      final result = await waitForTimeRender(() async {
        final el = find.byType(Text, skipOffstage: false).first.evaluate();
        return el.isNotEmpty &&
            (el.single.widget as Text).style?.color == Colors.amber;
      }, tester, 0);

      expect(result, true);
    });

    testWidgets('have a count down with color blueAccent', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await makeApp(tester, color: Colors.blueAccent);

      final result = await waitForTimeRender(() async {
        final el = find.byType(Text, skipOffstage: false).first.evaluate();
        return el.isNotEmpty &&
            (el.single.widget as Text).style?.color == Colors.blueAccent;
      }, tester, 0);

      expect(result, true);
    });

    testWidgets('have a count down with color red', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await makeApp(tester, color: Colors.red);

      final result = await waitForTimeRender(() async {
        final el = find.byType(Text, skipOffstage: false).first.evaluate();
        return el.isNotEmpty &&
            (el.single.widget as Text).style?.color == Colors.red;
      }, tester, 0);

      expect(result, true);
    });
  });
}
