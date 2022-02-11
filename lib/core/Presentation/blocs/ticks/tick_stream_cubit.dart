import 'package:flutter_deriv_api/api/common/forget/forget_all.dart';
import 'package:flutter_deriv_api/api/common/tick/tick.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';
part 'tick_stream_state.dart';

/// TicksBloc
class TickStreamCubit extends Cubit<TickStreamState> {
  TickStreamCubit() : super(TicksLoading());

  Future<void> onLoadedSymbolTickView(ActiveSymbol? selectedSymbol) async {
    final Tick? tick = await _subscribeTick(selectedSymbol).first;
    emit(
      TicksLoaded(tick),
    );
  }

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
}
