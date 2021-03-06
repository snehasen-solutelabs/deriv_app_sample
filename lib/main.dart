import 'package:deriv_app_sample/core/Presentation/states/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/states/AvailableContracts/available_contracts_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/states/TickStream/tick_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/states/selectionCubit/selected_symbol_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/services/connection/api_manager/connection_information.dart';
import 'package:flutter_deriv_api/state/connection/connection_cubit.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/base_bloc_manager.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';
import 'package:flutter_deriv_bloc_manager/bloc_observer.dart';
import 'package:flutter_deriv_bloc_manager/event_dispatcher.dart';

import 'package:deriv_app_sample/core/bloc_manager/state_emitters/active_symbols_state_emitter.dart';
import 'package:deriv_app_sample/core/bloc_manager/state_emitters/select_symbol_state_emitter.dart';
import 'package:deriv_app_sample/core/bloc_manager/state_emitters/connection_state_emitter.dart';

import 'core/Presentation/pages/connection_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CubitObserver();
  registerCoreBlocs();
  initializeEventDispatcher();
  runApp(const MyApp());
}

/// The main widget.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => const MaterialApp(home: AppScreen());
}

void registerCoreBlocs() {
  BlocManager.instance
    ..register(
      ConnectionCubit(
        ConnectionInformation(
          appId: '1089',
          brand: 'binary',
          endpoint: 'frontend.binaryws.com',
        ),
      ),
    )
    ..register(ActiveSymbolCubit())
    ..register(SelectSymbolCubit())
    ..register(TickCubit())
    ..register(AvailableContractsCubit());
}

/// Initializes event dispatcher.
void initializeEventDispatcher() => EventDispatcher(BlocManager.instance)
  ..register<ConnectionCubit, ConnectionStateEmitter>(
    (BaseBlocManager blocManager) => ConnectionStateEmitter(blocManager),
  )
  ..register<ActiveSymbolCubit, ActiveSymbolsStateEmitter>(
    (BaseBlocManager blocManager) => ActiveSymbolsStateEmitter(blocManager),
  )
  ..register<SelectSymbolCubit, SelectSymbolsStateEmitter>(
    (BaseBlocManager blocManager) => SelectSymbolsStateEmitter(blocManager),
  );
