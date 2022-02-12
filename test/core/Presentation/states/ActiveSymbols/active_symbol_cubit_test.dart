import 'package:bloc_test/bloc_test.dart';
import 'package:deriv_app_sample/core/Presentation/states/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/states/ActiveSymbols/active_symbols_state.dart';
import 'package:deriv_app_sample/core/Presentation/states/AvailableContracts/available_contracts_cubit.dart';
import 'package:flutter_deriv_api/api/api_initializer.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'active_symbol_cubit_data.dart';

class MockActiveSymbolCubit extends MockCubit<ActiveSymbolsState>
    implements ActiveSymbolCubit {}

class FakeActiveSymbolState extends Fake implements ActiveSymbolsState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeActiveSymbolState());

    APIInitializer().initialize(isMock: true);
  });

  group('active symbols test =>', () {
    test('should fetch active symbols.', () async {
      final MockActiveSymbolCubit activeSymbolCubit = MockActiveSymbolCubit();

      whenListen(
          activeSymbolCubit,
          Stream<ActiveSymbolsState>.fromIterable(<ActiveSymbolsState>[
            ActiveSymbolsInitialState(),
            ActiveSymbolsLoadingState(),
            ActiveSymbolsLoadedState(
                activeSymbols: activeSymbols,
                selectedSymbol: activeSymbols.first)
          ]));

      await expectLater(
          activeSymbolCubit.stream,
          emitsInOrder(<dynamic>[
            isA<ActiveSymbolsInitialState>(),
            isA<ActiveSymbolsLoadingState>(),
            isA<ActiveSymbolsLoadedState>(),
          ]));

      final ActiveSymbolsLoadedState currentState =
          activeSymbolCubit.state as ActiveSymbolsLoadedState;
      expect(currentState, isA<ActiveSymbolsLoadedState>());

      expect(currentState.activeSymbols, isNotNull);
      expect(currentState.activeSymbols, isA<List<ActiveSymbol>>());

      expect(currentState.selectedSymbol, isNotNull);
      expect(currentState.selectedSymbol, isA<ActiveSymbol>());
    });

    final Exception exception = Exception('active symbol cubit exception.');
    blocTest<ActiveSymbolCubit, ActiveSymbolsState>(
        'captures exceptions => (active_symbols_cubit).',
        build: () => ActiveSymbolCubit(),
        act: (ActiveSymbolCubit cubit) => cubit.addError(exception),
        errors: () => <Matcher>[equals(exception)]);
  });
}
