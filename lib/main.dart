import 'package:flutter/material.dart';

import 'app.dart';

void main() => runApp(const MyApp());

/// The main widget.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => const MaterialApp(home: App());
}


// import 'package:deriv_app_sample/pages/main_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_deriv_api/services/connection/api_manager/connection_information.dart';
// import 'package:flutter_deriv_api/state/connection/connection_cubit.dart';
// import 'package:flutter_deriv_bloc_manager/bloc_managers/base_bloc_manager.dart';
// import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';
// import 'package:flutter_deriv_bloc_manager/bloc_observer.dart';
// import 'package:flutter_deriv_bloc_manager/event_dispatcher.dart';
// import 'package:flutter_deriv_api/state/connection/connection_cubit.dart'
//     as api_connection;
// import 'core/bloc_manager/state_emitters/active_symbols_state_emitter.dart';
// import 'core/bloc_manager/state_emitters/connection_state_emitter.dart';
// import 'core/states/active_symbol/active_symbol_cubit.dart';

// void main() {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // Bloc.observer = CubitObserver();
//   // registerCoreBlocs();
//   // initializeEventDispatcher();
//   runApp(const App());
// }

// class App extends StatelessWidget {
//   const App({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MainPage(),
//     );
//   }
// }

// void initialize() {
//   _connectionCubit = api_connection.ConnectionCubit(
//       ConnectionInformation(
//         appId: '1089',
//         brand: 'binary',
//         endpoint: 'frontend.binaryws.com',
//       ),
//     );
// }
// void registerCoreBlocs() {
//   BlocManager.instance
//     ..register(
//       ConnectionCubit(
//         ConnectionInformation(
//             appId: '1089', brand: 'binary', endpoint: 'frontend.binaryws.com'),
//       ),
//     )
//     ..register(ActiveSymbolCubit());
// }

// /// Initializes event dispatcher.
// void initializeEventDispatcher() => EventDispatcher(BlocManager.instance)
//   ..register<ConnectionCubit, ConnectionStateEmitter>(
//     (BaseBlocManager blocManager) => ConnectionStateEmitter(blocManager),
//   )
//   ..register<ActiveSymbolCubit, ActiveSymbolsStateEmitter>(
//     (BaseBlocManager blocManager) => ActiveSymbolsStateEmitter(blocManager),
//   );
