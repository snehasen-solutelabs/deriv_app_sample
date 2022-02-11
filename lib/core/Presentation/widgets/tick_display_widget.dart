import 'package:deriv_app_sample/core/Presentation/blocs/ticks/tick_stream_cubit.dart';
import 'package:flutter_deriv_api/api/common/tick/tick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_bloc_manager/manager.dart';

/// ActiveSymbolsWidget
class TickDisplayWidget extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TickDisplayWidget({
    required this.tickSymbolCubit,
    required this.activeSymbol,
    Key? key,
  }) : super(key: key);

  /// Market item to be shown along with its subscription cubit.

  final TickStreamCubit tickSymbolCubit;
  final ActiveSymbol? activeSymbol;

  @override
  _TickDisplayWidgetState createState() => _TickDisplayWidgetState();
}

class _TickDisplayWidgetState extends State<TickDisplayWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          elevation: 5,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: BlocBuilder<TickStreamCubit, TickStreamState>(
                    bloc: widget.tickSymbolCubit,
                    builder: (BuildContext context, TickStreamState state) {
                      if (state is TicksLoaded) {
                        Tick? tick = state.tick;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Symbol : ${tick?.symbol}",
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Price : ${tick?.quote}",
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        );
                      } else if (state is TicksError) {
                        return Text(state.message ?? 'An error occurred');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        // ),
      );
}
