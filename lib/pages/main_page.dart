import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbols_bloc.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_bloc.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/active_symbol_widget.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/contracts_type_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

/// MainPage
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ActiveSymbolsBloc _activeSymbolsBloc;
  late AvailableContractsBloc _availableContractsBloc;

  @override
  void initState() {
    super.initState();

    _activeSymbolsBloc = ActiveSymbolsBloc();
    _availableContractsBloc = AvailableContractsBloc(_activeSymbolsBloc);
  }

  @override
  void dispose() {
    _availableContractsBloc.close();
    _activeSymbolsBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<ActiveSymbolsBloc>.value(
            value: _activeSymbolsBloc,
          ),
          BlocProvider<AvailableContractsBloc>.value(
            value: _availableContractsBloc,
          ),
        ],
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Expanded(child: ActiveSymbolsWidget()),
            const Expanded(child: ContractsTypeWidget()),
          ],
        ),
      );
}
