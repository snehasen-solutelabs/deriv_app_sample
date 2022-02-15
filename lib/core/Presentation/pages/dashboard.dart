import 'package:deriv_app_sample/core/Presentation/widgets/active_symbol_widget.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/contracts_type_widget.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/tick_display_widget.dart';
import 'package:flutter/material.dart';

/// MainPage
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          // shows drop down with index 0 selected symbol
          ActiveSymbolsWidget(),
          // shows tick Stream for index 0 selected symbol
          TickDisplayWidget(),
          // shows contracts for index 0 selected symbol
          Expanded(child: ContractsTypeWidget()),
        ],
      );
}
