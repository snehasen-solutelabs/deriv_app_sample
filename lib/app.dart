import 'package:deriv_app_sample/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_deriv_api/services/connection/api_manager/connection_information.dart';
import 'package:flutter_deriv_api/state/connection/connection_cubit.dart'
    as api_connection;

/// Sample App main widget
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late api_connection.ConnectionCubit _connectionCubit;

  @override
  void initState() {
    super.initState();

    _connectionCubit = api_connection.ConnectionCubit(
      ConnectionInformation(
        appId: '1089',
        brand: 'binary',
        endpoint: 'frontend.binaryws.com',
      ),
    );
  }

  @override
  void dispose() {
    _connectionCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<api_connection.ConnectionCubit>.value(
            value: _connectionCubit,
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Deriv Example App'),
          ),
          body: BlocBuilder<api_connection.ConnectionCubit,
              api_connection.ConnectionState>(
            builder: (
              BuildContext context,
              api_connection.ConnectionState state,
            ) {
              if (state is api_connection.ConnectionConnectedState) {
                return const MainPage();
              } else if (state is api_connection.ConnectionInitialState ||
                  state is api_connection.ConnectionConnectingState) {
                return _buildCenterCircularIndicator('Connecting...');
              } else if (state is api_connection.ConnectionErrorState) {
                return _buildCenterCircularIndicator(
                    'Connection Error\n${state.error}');
              } else if (state is api_connection.ConnectionDisconnectedState) {
                return _buildCenterCircularIndicator(
                  'Connection is down, trying to reconnect...',
                );
              }

              return Container();
            },
          ),
        ),
      );

  Widget _buildCenterCircularIndicator(String text) => Center(
        child: CircularProgressIndicator(
            color: Colors.black, semanticsLabel: text),
      );
}
