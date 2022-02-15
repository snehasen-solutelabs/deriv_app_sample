import 'package:deriv_app_sample/core/bloc_manager/event_listener_contracts/select_symbol_event_listner.dart';
import 'package:flutter_deriv_api/api/common/forget/forget_all.dart';
import 'package:flutter_deriv_api/api/common/tick/tick.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';
part 'tick_state.dart';

/// TicksCubit
class TickCubit extends Cubit<TickStreamState>
    implements SelectActiveSymbolEventListener {
  // initial loading state
  TickCubit() : super(TicksLoading());

//subscribe for ticks
  Future<void> subscribeTicks({required ActiveSymbol selectedSymbol}) async {
    try {
      emit(TicksLoading());

      await _unsubscribeTick();

// listen in each and every call when updates from server
      _subscribeTick(selectedSymbol).listen((Tick? tick) {
        emit(TicksLoaded(tick: tick));
      });
    } on Exception catch (e) {
      emit(TicksError('$e'));
    }
  }

// streaming tick in each time  when refrtesh
  Stream<Tick?> _subscribeTick(ActiveSymbol? selectedSymbol) =>
      Tick.subscribeTick(
        TicksRequest(ticks: selectedSymbol?.symbol),
      );

  Future<ForgetAll> _unsubscribeTick() => Tick.unsubscribeAllTicks();

  @override
  Future<void> close() async {
    await _unsubscribeTick();

    await super.close();
  }

  @override
  void onSelectActiveSymbol(ActiveSymbol selectedSymbol) {
    subscribeTicks(selectedSymbol: selectedSymbol);
  }
}
