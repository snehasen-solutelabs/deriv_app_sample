// ignore_for_file: deprecated_member_use

import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbols_state.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/ticks/ticks_stream_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/exceptions/active_symbols_exception.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/api/common/forget/forget_all.dart';
import 'package:flutter_deriv_api/api/common/tick/exceptions/tick_exception.dart';
import 'package:flutter_deriv_api/api/common/tick/tick.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';

/// TicksBloc
class TickCubit extends Cubit<TickStreamState> {
  /// Initializes
  TickCubit(ActiveSymbolCubit activeSymbolsCubit)
      : super(TickStreamInitialState) {
    if (activeSymbolsCubit.state is ActiveSymbolsLoadedState) {
      // add(SubscribeTicks(activeSymbolsState.selectedSymbol));

    }
  }

  Future<void> onLoadedSymbol(ActiveSymbol? selectedSymbol) async {
    final Tick contracts = await fetchAvailableContracts(selectedSymbol);
    emit(
      AvailableContractsLoaded(contracts: contracts),
    );
  }

  Stream<Tick> fetchAvailableContracts(
    ActiveSymbol selectedSymbol,
  ) async =>
      _subscribeTick(selectedSymbol);

  Stream<Tick?> _subscribeTick(ActiveSymbol selectedSymbol) =>
      Tick.subscribeTick(
        TicksRequest(ticks: selectedSymbol.symbol),
      );
}
