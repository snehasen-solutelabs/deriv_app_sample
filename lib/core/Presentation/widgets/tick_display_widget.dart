import 'package:deriv_app_sample/core/state/TickStream/tick_stream_cubit.dart';
import 'package:flutter_deriv_api/api/common/tick/tick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

/// ActiveSymbolsWidget
class TickDisplayWidget extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TickDisplayWidget({
    Key? key,
  }) : super(key: key);

  @override
  _TickDisplayWidgetState createState() => _TickDisplayWidgetState();
}

class _TickDisplayWidgetState extends State<TickDisplayWidget> {
  late final TickStreamCubit _tickStreamCubit;
  @override
  void initState() {
    _tickStreamCubit = BlocManager.instance.fetch<TickStreamCubit>();

    super.initState();
  }

  @override
  void dispose() {
    BlocManager.instance.dispose<TickStreamCubit>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TickStreamCubit, TickStreamState>(
        bloc: _tickStreamCubit,
        builder: (BuildContext context, TickStreamState state) {
          if (state is TicksLoaded) {
            Tick? tick = state.tick;
            return Column(
              children: [
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
              ],
            );
          } else if (state is TicksError) {
            return Center(child: Text(state.message ?? 'An error occurred'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
