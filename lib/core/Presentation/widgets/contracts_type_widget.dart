import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_bloc.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/contract/models/available_contract_model.dart';

/// ContractsTypeWidget
class ContractsTypeWidget extends StatefulWidget {
  const ContractsTypeWidget({Key? key}) : super(key: key);

  @override
  _ContractsTypeWidgetState createState() => _ContractsTypeWidgetState();
}

class _ContractsTypeWidgetState extends State<ContractsTypeWidget> {
  // ignore: close_sinks
  AvailableContractsBloc? _availableContractsBloc;

  @override
  void initState() {
    super.initState();

    _availableContractsBloc = BlocProvider.of<AvailableContractsBloc>(context);
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          elevation: 4,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: BlocBuilder<AvailableContractsBloc,
                      AvailableContractsState>(
                    bloc: _availableContractsBloc,
                    builder:
                        (BuildContext context, AvailableContractsState state) {
                      if (state is AvailableContractsLoaded) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(5),
                          itemCount:
                              state.contracts!.availableContracts!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final AvailableContractModel contract =
                                state.contracts!.availableContracts![index]!;

                            return Card(
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    "Category : ${contract.contractCategory!}",
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Name : ${contract.contractDisplay!}",
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Market : ${contract.market!}",
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Sub Market : ${contract.submarket!}",
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (state is AvailableContractsError) {
                        return Text(state.message ?? 'An error occurred');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        // ),
      );
}
