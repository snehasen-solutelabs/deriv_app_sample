import 'package:deriv_app_sample/core/Presentation/states/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/states/ActiveSymbols/active_symbols_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

import 'active_symbols_dropdown_widget.dart';

/// ActiveSymbolsWidget
class ActiveSymbolsWidget extends StatefulWidget {
  const ActiveSymbolsWidget({
    Key? key,
  }) : super(key: key);

  /// Market item to be shown along with its subscription cubit.

  @override
  _ActiveSymbolsWidgetState createState() => _ActiveSymbolsWidgetState();
}

class _ActiveSymbolsWidgetState extends State<ActiveSymbolsWidget> {
  late final ActiveSymbolCubit _activeSymbolsCubit;

  @override
  void initState() {
    _activeSymbolsCubit = BlocManager.instance.fetch<ActiveSymbolCubit>();

    _activeSymbolsCubit.fetchActiveSymbols();
    super.initState();
  }

  @override
  void dispose() {
    BlocManager.instance.dispose<ActiveSymbolCubit>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(10),
        child: BlocBuilder<ActiveSymbolCubit, ActiveSymbolsState>(
            bloc: _activeSymbolsCubit,
            builder: (BuildContext context, ActiveSymbolsState state) {
              if (state is ActiveSymbolsLoadedState) {
                return Column(
                  key: const Key('active_symbol'),
                  children: <Widget>[
                    ActiveSymbolDropdown(
                      key: const Key('drop_down'),
                      items: state.activeSymbols,
                      initialItem: state.activeSymbols![0],
                      onItemSelected: (ActiveSymbol item) {
                        //_selectedSymbolCubit.selectActiveSymbol(item);
                        _activeSymbolsCubit.onRefreshViews(
                            item, state.activeSymbols);
                      },
                    )
                  ],
                );
              } else if (state is ActiveSymbolsErrorState) {
                return Center(child: Text(state.errorMessage));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      );
}
