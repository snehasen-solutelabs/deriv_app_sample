import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbols_bloc.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/ticks/ticks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'active_symbols_list.dart';

/// ActiveSymbolsWidget
class ActiveSymbolsWidget extends StatefulWidget {
  const ActiveSymbolsWidget({Key? key}) : super(key: key);

  @override
  _ActiveSymbolsWidgetState createState() => _ActiveSymbolsWidgetState();
}

class _ActiveSymbolsWidgetState extends State<ActiveSymbolsWidget> {
  // ignore: close_sinks
  ActiveSymbolsBloc? _activeSymbolsBloc;

  TicksBloc? _ticksBloc;

  //double? _lastTickValue = 0;

  @override
  void initState() {
    super.initState();

    _activeSymbolsBloc = BlocProvider.of<ActiveSymbolsBloc>(context)
      ..add(FetchActiveSymbols());
    _ticksBloc = TicksBloc(_activeSymbolsBloc!);
  }

  @override
  void dispose() {
    _ticksBloc!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
          onTap: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  BlocProvider<ActiveSymbolsBloc>.value(
                value: _activeSymbolsBloc!,
                child: const ActiveSymbolsList(),
              ),
            );
          },
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 55,
                width: double.infinity,
                child:

                    // ignore: always_specify_types
                    BlocBuilder<ActiveSymbolsBloc, ActiveSymbolsState>(
                        bloc: _activeSymbolsBloc,
                        builder:
                            (BuildContext context, ActiveSymbolsState state) {
                          if (state is ActiveSymbolsLoaded) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '${state.selectedSymbol!.displayName}',
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down,
                                    size: 30, color: Colors.white),
                              ],
                            );
                          } else if (state is ActiveSymbolsError) {
                            return Text(state.message ?? 'An error occurred');
                          } else {
                            return const Center(child: Text("Connecting.."));
                          }
                        }),
              ),

              // Card(elevation: 10,child: Text("Symbol : ${sta}"),)
              // // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Padding(
              //     padding: const EdgeInsets.all(2),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: <Widget>[
              //         Flexible(
              //           child: BlocBuilder<TicksBloc, TicksState>(
              //               bloc: _ticksBloc,
              //               builder:
              //                   (BuildContext context, TicksState state) {
              //                 if (state is TicksLoaded) {
              //                   final Color tickColor =
              //                       state.tick!.ask! > _lastTickValue!
              //                           ? Colors.green
              //                           : state.tick!.ask == _lastTickValue
              //                               ? Colors.black
              //                               : Colors.red;

              //                   _lastTickValue = state.tick!.ask;

              //                   return Padding(
              //                     padding: const EdgeInsets.all(2),
              //                     child: Text(
              //                       '${state.tick?.ask?.toStringAsFixed(5)}',
              //                       style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: tickColor,
              //                       ),
              //                     ),
              //                   );
              //                 }

              //                 if (state is TicksError) {
              //                   return Text(
              //                     state.message!,
              //                     style: const TextStyle(
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.red,
              //                     ),
              //                   );
              //                 }
              //                 return const Text(
              //                   '---',
              //                   style: TextStyle(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 );
              //               }),
              //         ),
              //         const SizedBox(height: 12),
              //         const Icon(Icons.keyboard_arrow_down)
              //       ],
              //     ),
            ],
          )));
  // ),
  ///),
  // );
}
