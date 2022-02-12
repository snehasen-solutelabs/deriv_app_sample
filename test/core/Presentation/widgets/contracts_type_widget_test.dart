import 'package:deriv_app_sample/core/Presentation/states/AvailableContracts/available_contracts_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/contracts_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deriv_bloc_manager/manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Available contract list widget tests', () {
    //Initializes cubits
    setUpAll(() {
      BlocManager.instance.register(AvailableContractsCubit());
    });

    tearDownAll(() {
      BlocManager.instance.dispose<AvailableContractsCubit>();
    });

    testWidgets('Contract List Builder Widget working',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ContractsTypeWidget(),
        ),
      );

      await tester.idle();
      expect(find.byKey(const Key('builder')), findsOneWidget);
    });
  });
}
