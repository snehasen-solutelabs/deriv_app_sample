import 'package:deriv_app_sample/core/Presentation/states/selectionCubit/selected_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/states/selectionCubit/selected_symbol_state.dart';
import 'package:deriv_app_sample/core/bloc_manager/event_listener_contracts/select_symbol_event_listner.dart';

import 'package:flutter_deriv_bloc_manager/manager.dart';

/// Select symbols state emitter.
class SelectSymbolsStateEmitter extends BaseStateEmitter<
    SelectActiveSymbolEventListener, SelectSymbolCubit> {
  /// Initializes Select symbols state emitter.
  SelectSymbolsStateEmitter(BaseBlocManager blocManager) : super(blocManager);

  @override
  void handleStates(
      {required SelectActiveSymbolEventListener eventListener,
      required Object state}) {
    if (state is SelectSymbolChangeState) {
      eventListener.onSelectActiveSymbol(state.selectedActiveSymbol);
    }
  }
}
