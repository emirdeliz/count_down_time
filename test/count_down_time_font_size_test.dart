import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'count_down_time_utils.dart';

void main() {
  group('have a count down with fontSize', () {
    testWidgets('have a count down with fontSize 12', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await makeApp(tester, fontSize: 12);

      final result = await waitForTimeRender(() async {
        final el = find.byType(Text, skipOffstage: false).first.evaluate();
        return el.isNotEmpty &&
            (el.single.widget as Text).style?.fontSize == 12;
      }, tester, 0);

      expect(result, true);
    });

    testWidgets('have a count down with fontSize 15.2', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await makeApp(tester, fontSize: 15.2);

      final result = await waitForTimeRender(() async {
        final el = find.byType(Text, skipOffstage: false).first.evaluate();
        return el.isNotEmpty &&
            (el.single.widget as Text).style?.fontSize == 15.2;
      }, tester, 0);

      expect(result, true);
    });

    testWidgets('have a count down with fontSize 17.5', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await makeApp(tester, fontSize: 17.5);

      final result = await waitForTimeRender(() async {
        final el = find.byType(Text, skipOffstage: false).first.evaluate();
        return el.isNotEmpty &&
            (el.single.widget as Text).style?.fontSize == 17.5;
      }, tester, 0);

      expect(result, true);
    });
  });
}
