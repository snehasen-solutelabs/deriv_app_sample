import 'package:bloc_test/bloc_test.dart';
import 'package:deriv_app_sample/core/Presentation/states/AvailableContracts/available_contracts_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/states/AvailableContracts/available_contracts_state.dart';

import 'package:flutter_deriv_api/api/api_initializer.dart';
import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../Sync/sync_time_cubit.dart';
import 'available_contract_data.dart';

class MockAvailableContractCubit extends MockCubit<AvailableContractsState>
    implements AvailableContractsCubit {}

class MockSyncTimeCubit extends MockCubit<SyncTimeState>
    implements SyncTimeCubit {
  @override
  DateTime get now => DateTime.now();
}

class FakeAvailableContractState extends Fake
    implements AvailableContractsState {}

class FakeSyncTimeState extends Fake implements SyncTimeState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAvailableContractState());
    registerFallbackValue(FakeSyncTimeState());

    BlocManager.instance.register<SyncTimeCubit>(MockSyncTimeCubit());
    APIInitializer().initialize(isMock: true);
  });

  group('Available contract cubit test =>', () {
    test('Available contract fetch', () async {
      final MockAvailableContractCubit activeSymbolCubit =
          MockAvailableContractCubit();

      whenListen(
          activeSymbolCubit,
          Stream<AvailableContractsState>.fromIterable(<
              AvailableContractsState>[
            AvailableContractsLoading(),
            AvailableContractsLoaded(contracts: availableContracts),
          ]));

      await expectLater(
          activeSymbolCubit.stream,
          emitsInOrder(<dynamic>[
            isA<AvailableContractsLoading>(),
            isA<AvailableContractsLoaded>(),
          ]));

      expect(activeSymbolCubit.state as AvailableContractsLoaded,
          isA<AvailableContractsLoaded>());
      expect((activeSymbolCubit.state as AvailableContractsLoaded).contracts,
          isNotNull);
      expect((activeSymbolCubit.state as AvailableContractsLoaded).contracts,
          isA<ContractsForSymbol>());
    });
  });
}
