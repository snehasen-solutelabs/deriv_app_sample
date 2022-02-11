import 'package:deriv_app_sample/core/Presentation/widgets/active_symbol_widget.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/contracts_type_widget.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/tick_display_widget.dart';
import 'package:deriv_app_sample/core/state/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/state/AvailableContracts/available_contracts_cubit.dart';
import 'package:deriv_app_sample/core/state/TickStream/tick_stream_cubit.dart';
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
  late final TickStreamCubit _tickStreamCubit;
  late final AvailableContractsCubit _availableContractsCubit;

  @override
  void initState() {
    super.initState();

    _setupCubit();
  }

  void _setupCubit() {
    _activeSymbolsCubit = BlocManager.instance.fetch<ActiveSymbolCubit>();

    _activeSymbolsCubit.fetchSymbols(showLoadingIndicator: false);

    _tickStreamCubit = BlocManager.instance.fetch<TickStreamCubit>();

    _availableContractsCubit =
        BlocManager.instance.fetch<AvailableContractsCubit>();
  }

  @override
  void dispose() {
    _availableContractsCubit.close();
    _activeSymbolsCubit.close();
    _tickStreamCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<ActiveSymbolCubit>.value(
            value: _activeSymbolsCubit,
          ),
          BlocProvider<TickStreamCubit>.value(
            value: _tickStreamCubit,
          ),
          BlocProvider<AvailableContractsCubit>.value(
            value: _availableContractsCubit,
          ),
        ],
        child: Column(
          children: <Widget>[
            ActiveSymbolsWidget(activeSymbolCubit: _activeSymbolsCubit),
            TickDisplayWidget(
              tickSymbolCubit: _tickStreamCubit,
              activeSymbol: _activeSymbolsCubit.state.selectedSymbol,
            ),
            Expanded(
                child: ContractsTypeWidget(
              availableContractsCubit: _availableContractsCubit,
              activeSymbol: _activeSymbolsCubit.state.selectedSymbol,
            )),
          ],
        ),
      );
}
