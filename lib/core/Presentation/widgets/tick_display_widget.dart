import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbols_state.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/ticks/ticks_stream_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_bloc_manager/manager.dart';

import 'active_symbols_list.dart';

/// ActiveSymbolsWidget
class ActiveSymbolsWidget extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ActiveSymbolsWidget({
    required this.activeSymbolCubit,
    Key? key,
  }) : super(key: key);

  /// Market item to be shown along with its subscription cubit.

  final ActiveSymbolCubit activeSymbolCubit;

  @override
  _ActiveSymbolsWidgetState createState() => _ActiveSymbolsWidgetState();
}

class _ActiveSymbolsWidgetState extends State<ActiveSymbolsWidget> {
  // ignore: close_sinks

  //double? _lastTickValue = 0;

  @override
  void initState() {
    BlocManager.instance
        .fetch<TickStreamCubit>()
        .isSubscribed(widget.activeSymbolCubit.state.selectedSymbol);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(children: <Widget>[Text("data"), Text("")]));
  //     Container(
  //       padding: const EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         color: Colors.black,
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       height: 55,
  //       width: double.infinity,
  //       child: BlocBuilder<ActiveSymbolCubit, ActiveSymbolsState>(
  //           bloc: widget.activeSymbolCubit,
  //           builder: (BuildContext context, ActiveSymbolsState state) {
  //             if (state is ActiveSymbolsLoadedState) {
  //               return Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Expanded(
  //                     child: Text(
  //                       '${state.selectedSymbol!.displayName}',
  //                       style: const TextStyle(
  //                           fontSize: 18, color: Colors.white),
  //                       textAlign: TextAlign.left,
  //                     ),
  //                   ),
  //                   const Icon(Icons.arrow_drop_down,
  //                       size: 30, color: Colors.white),
  //                 ],
  //               );
  //             } else if (state is ActiveSymbolsErrorState) {
  //               return Text(state.errorMessage);
  //             } else {
  //               return const Center(child: Text("Connecting.."));
  //             }
  //           }),
  //     ),
  //   ],
  // ));
}
