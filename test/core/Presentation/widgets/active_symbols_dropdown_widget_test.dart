import 'package:deriv_app_sample/core/Presentation/states/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/active_symbols_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/services/connection/api_manager/connection_information.dart';
import 'package:flutter_deriv_api/state/connection/connection_cubit.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';
import 'package:flutter_test/flutter_test.dart';

import '../states/ActiveSymbols/active_symbol_cubit_data.dart';

void main() {
  group('ActiveSymbolDropDown widget tests', () {
    setUpAll(() {
      BlocManager.instance
        ..register(ConnectionCubit(
            ConnectionInformation(brand: '', appId: '', endpoint: ''),
            isMock: true))
        ..register(ActiveSymbolCubit());
    });

    tearDownAll(() {
      BlocManager.instance.dispose<ConnectionCubit>();
      BlocManager.instance.dispose<ActiveSymbolCubit>();
    });

    testWidgets('Widget exists', (WidgetTester tester) async {
      ActiveSymbol? activeSymbol = activeSymbols.first;

      await tester.pumpWidget(_TestApp(
          child: ActiveSymbolDropdown(
              items: activeSymbols,
              initialItem: activeSymbol,
              onItemSelected: (ActiveSymbol? newValue) {
                activeSymbol = newValue;
              },
              key: const Key('dropdown'))));

      final Finder dropdown = find.byKey(const Key('dropdown'));
      expect(dropdown, findsOneWidget);

      expect(
          (tester.widget(find.byKey(const Key('dropdown')))
                  as ActiveSymbolDropdown)
              .initialItem,
          activeSymbol);
      // Here before the menu is open we have one widget with text 'Lesser'
      await tester.tap(find.text('AUD Index'));
      // Calling pump twice once complete the the action and
      // again to finish the animation of closing the menu.
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // after opening the menu we have two widgets with text 'Greater'
      // one in index stack of the dropdown button and one in the menu .
      // apparently the last one is from the menu.
      await tester.tap(find.text('AUD/USD').last);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      /// We directly verify the value updated in the onchanged function.
      expect(activeSymbol, activeSymbols.last);
    });
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      MaterialApp(home: Scaffold(bottomSheet: child));
}
