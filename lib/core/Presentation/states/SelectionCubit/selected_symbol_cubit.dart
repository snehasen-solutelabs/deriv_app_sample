import 'package:bloc/bloc.dart';
import 'package:deriv_app_sample/core/Presentation/states/selectionCubit/selected_symbol_state.dart';
import 'package:deriv_app_sample/core/bloc_manager/event_listener_contracts/active_symbols_event_listener.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';

//// Selected symbol cubit for managing selected symbol state.
///SelectSymbolCubit
class SelectSymbolCubit extends Cubit<SelectedSymbolState>
    implements ActiveSymbolsEventListener {
  /// Initializes selected symbol state.
  SelectSymbolCubit() : super(SelectedSymbolInitialState());

  /// selected symbol states change
  void selectActiveSymbol(ActiveSymbol symbol) {
    emit(SelectSymbolChangeState(selectedActiveSymbol: symbol));
  }

  @override
  void onActiveSymbolsError(String error) {}

  @override
  void onActiveSymbolsLoaded(List<ActiveSymbol>? activeSymbols) {
    selectActiveSymbol(activeSymbols![0]);
  }

  @override
  void onActiveSymbolsLoading() {}
}
