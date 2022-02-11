import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbols_state.dart';
import 'package:deriv_app_sample/core/bloc_manager/event_listener_contracts/active_symbols_event_listener.dart';
import 'package:flutter_deriv_bloc_manager/manager.dart';

/// Active symbols state emitter.
class ActiveSymbolsStateEmitter
    extends BaseStateEmitter<ActiveSymbolsEventListener, ActiveSymbolCubit> {
  /// Initializes Active symbols state emitter.
  ActiveSymbolsStateEmitter(BaseBlocManager blocManager) : super(blocManager);

  @override
  void handleStates({
    required ActiveSymbolsEventListener eventListener,
    required Object state,
  }) {
    if (state is ActiveSymbolsLoadedState) {
      eventListener.onActiveSymbolsLoaded(state.activeSymbols);
    } else if (state is ActiveSymbolsLoadingState) {
      eventListener.onActiveSymbolsLoading();
    } else if (state is ActiveSymbolsErrorState) {
      eventListener.onActiveSymbolsError(state.errorMessage.toString());
    }
  }
}