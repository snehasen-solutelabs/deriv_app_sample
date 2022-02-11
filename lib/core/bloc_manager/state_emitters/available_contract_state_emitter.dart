import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_state.dart';
import 'package:deriv_app_sample/core/bloc_manager/event_listener_contracts/available_contract_event_listner.dart';
import 'package:flutter_deriv_bloc_manager/manager.dart';

/// Contract state emitter.
class AvailableContractStateEmitter extends BaseStateEmitter<
    AvailableContractEventListener, AvailableContractsCubit> {
  /// Initializes Contract state emitter.
  AvailableContractStateEmitter(BaseBlocManager blocManager)
      : super(blocManager);

  @override
  void handleStates({
    required AvailableContractEventListener eventListener,
    required Object state,
  }) {
    if (state is AvailableContractsLoaded) {
      eventListener.onContractLoaded(state.contracts);
    } else if (state is AvailableContractsLoading) {
      eventListener.onContractLoading();
    } else if (state is AvailableContractsError) {
      eventListener.onContractError(state.message.toString());
    }
  }
}
