import 'package:deriv_app_sample/core/Presentation/states/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/states/AvailableContracts/available_contracts_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/active_symbol_widget.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/active_symbols_dropdown_widget.dart';
import 'package:deriv_app_sample/core/state/TickStream/tick_stream_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deriv_api/services/connection/api_manager/connection_information.dart';
import 'package:flutter_deriv_api/state/connection/connection_cubit.dart';
import 'package:flutter_deriv_bloc_manager/manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Active symbol widget tests', () {
    //Initializes cubits
    setUpAll(() {
      BlocManager.instance
        ..register(ConnectionCubit(
            ConnectionInformation(brand: '', appId: '', endpoint: ''),
            isMock: true))
        ..register(ActiveSymbolCubit())
        ..register(AvailableContractsCubit())
        ..register(TickStreamCubit());
    });

    tearDownAll(() {
      BlocManager.instance.dispose<ConnectionCubit>();
      BlocManager.instance.dispose<ActiveSymbolCubit>();
    });
    testWidgets('Active Symbol sWidget Loaded', (WidgetTester tester) async {
      await tester.pumpWidget(_TestApp());
      await tester.idle();
      await tester.pumpAndSettle();

      expect(find.byType(ActiveSymbolDropdown), findsOneWidget);
    });
  });
}

class _TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: Scaffold(body: ActiveSymbolsWidget()));
}
