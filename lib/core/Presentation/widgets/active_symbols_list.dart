import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbols_state.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

/// ActiveSymbolsListDialog
class ActiveSymbolsList extends StatelessWidget {
  const ActiveSymbolsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ActiveSymbolCubit, ActiveSymbolsState>(
        builder: (
          BuildContext context,
          ActiveSymbolsState state,
        ) {
          if (state is ActiveSymbolsLoadedState) {
            return Material(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: state.activeSymbols!.length,
                itemBuilder: (BuildContext context, int index) {
                  final ActiveSymbol activeSymbol = state.activeSymbols![index];

                  return ListTile(
                    title: Text(activeSymbol.displayName!),
                    onTap: () {
                      //on select active symbol from list
                      BlocManager.instance
                          .fetch<ActiveSymbolCubit>()
                          .onSelectActiveSymbols(
                              activeSymbol, state.activeSymbols);
                      // on load contract from selected symbol
                      BlocManager.instance
                          .fetch<AvailableContractsCubit>()
                          .onLoadedSymbol(activeSymbol);

                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
