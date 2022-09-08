import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'count_down_time_utils.dart';

void main() {
  group('have a count down with correct count down', () {
    testWidgets('have a count down with thirty seconds', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await makeApp(tester, timeStartInSeconds: 30);

      final result = await waitForTimeRender(() async {
        final el = find.byType(Text, skipOffstage: false).first.evaluate();
        return el.isNotEmpty && (el.single.widget as Text).data == '25';
      }, tester, 0);

      expect(result, true);
    });

    testWidgets('have a count down with two minutes', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await makeApp(tester, timeStartInMinutes: 2);

      final result = await waitForTimeRender(() async {
        final el = find.byType(Text, skipOffstage: false).first.evaluate();
        return el.isNotEmpty && (el.single.widget as Text).data == '01:55';
      }, tester, 0);

      expect(result, true);
    });

    testWidgets('have a count down with two hours', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await makeApp(tester, timeStartInHours: 2);

      final result = await waitForTimeRender(() async {
        final el = find.byType(Text, skipOffstage: false).first.evaluate();
        return el.isNotEmpty && (el.single.widget as Text).data == '01:59:55';
      }, tester, 0);

      expect(result, true);
    });
  });
}
