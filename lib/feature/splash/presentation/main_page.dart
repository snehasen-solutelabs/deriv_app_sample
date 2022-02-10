import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbols_state.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/active_symbol_widget.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/contracts_type_widget.dart';
import 'package:deriv_app_sample/core/widgets/drop_down_menu.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

/// MainPage
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final ActiveSymbolCubit _activeSymbolsCubit;
  late final AvailableContractsCubit _availableContractsCubit;

  @override
  void initState() {
    super.initState();

    _activeSymbolsCubit = BlocManager.instance.fetch<ActiveSymbolCubit>();

    _activeSymbolsCubit.fetchActiveSymbols(showLoadingIndicator: false);

    _availableContractsCubit =
        BlocManager.instance.fetch<AvailableContractsCubit>();

    _availableContractsCubit
        .fetchAvailableContracts(_activeSymbolsCubit.state.selectedSymbol);
  }

  @override
  void dispose() {
    _availableContractsCubit.close();
    _activeSymbolsCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<ActiveSymbolCubit>.value(
            value: _activeSymbolsCubit,
          ),
          BlocProvider<AvailableContractsCubit>.value(
            value: _availableContractsCubit,
          ),
        ],
        child: Column(
          children: <Widget>[
            Expanded(
                child: ActiveSymbolsWidget(
                    activeSymbolCubit: _activeSymbolsCubit)),
            Expanded(
                child: ContractsTypeWidget(
              availableContractsCubit: _availableContractsCubit,
            )),
            // Expanded(flex: 2, child: PriceProposalWidget()),
          ],
        ),
      );
  //       body: Column(
  //         children: <Widget>[dropDownWidget(context)],
  //       ),
  //     );
//   Widget dropDownWidget(BuildContext context) =>
//       BlocBuilder<ActiveSymbolCubit, ActiveSymbolsState>(
//           bloc: _activeSymbolsCubit,
//           builder: (BuildContext context, ActiveSymbolsState state) {
//             if (state is ActiveSymbolsLoadedState) {
//               return Column(children: [
//                 DropDownMenu(
//                   items: ,
//                   initialItem: state.activeSymbols!.first.displayName,
//                   onItemSelected: <ActiveSymbol>(dynamic item) {},
//                 ),
//               ]);
//             } else if (state is ActiveSymbolsLoadedState) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           });
// }

}
