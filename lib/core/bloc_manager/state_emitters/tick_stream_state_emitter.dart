import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbols_state.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_state.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/ticks/ticks_stream_cubit.dart';
import 'package:deriv_app_sample/core/bloc_manager/event_listener_contracts/active_symbols_event_listener.dart';
import 'package:deriv_app_sample/core/bloc_manager/event_listener_contracts/available_contract_event_listner.dart';
import 'package:deriv_app_sample/core/bloc_manager/event_listener_contracts/tick_event_listner.dart';
import 'package:flutter_deriv_bloc_manager/manager.dart';
import 'package:flutter_deriv_bloc_manager/base_event_listener.dart';

/// Tick state emitter.
class TickStateEmitter extends BaseStateEmitter<TickEventListener, TickCubit> {
  /// Initializes Tick state emitter.
  TickStateEmitter(BaseBlocManager blocManager) : super(blocManager);

  @override
  void handleStates({
    required TickEventListener eventListener,
    required Object state,
  }) {
    if (state is TickLoaded) {
      eventListener.onTickLoaded(state);
    } else if (state is AvailableContractsLoading) {
      eventListener.onTickLoading();
    } else if (state is AvailableContractsError) {
      eventListener.onTickError(state.message.toString());
    }
  }
}
