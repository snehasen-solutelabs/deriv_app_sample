import 'package:deriv_app_sample/core/Presentation/widgets/active_symbol_widget.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/contracts_type_widget.dart';
import 'package:deriv_app_sample/core/Presentation/widgets/tick_display_widget.dart';
import 'package:flutter/material.dart';

/// MainPage
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
          ActiveSymbolsWidget(),
          TickDisplayWidget(),
          Expanded(child: ContractsTypeWidget()),
        ],
      );
}
