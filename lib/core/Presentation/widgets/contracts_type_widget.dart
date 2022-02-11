import 'package:deriv_app_sample/core/Presentation/states/AvailableContracts/available_contracts_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/states/AvailableContracts/available_contracts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/contract/models/available_contract_model.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

/// ContractsTypeWidget
class ContractsTypeWidget extends StatefulWidget {
  const ContractsTypeWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ContractsTypeWidgetState createState() => _ContractsTypeWidgetState();
}

class _ContractsTypeWidgetState extends State<ContractsTypeWidget> {
  late final AvailableContractsCubit _availableContractsCubit;

  @override
  void initState() {
    _availableContractsCubit =
        BlocManager.instance.fetch<AvailableContractsCubit>();

    super.initState();
  }

  @override
  void dispose() {
    BlocManager.instance.dispose<AvailableContractsCubit>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 5,
          child: BlocBuilder<AvailableContractsCubit, AvailableContractsState>(
            bloc: _availableContractsCubit,
            builder: (BuildContext context, AvailableContractsState state) {
              if (state is AvailableContractsLoaded) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.all(5),
                  itemCount: state.contracts!.availableContracts!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final AvailableContractModel contract =
                        state.contracts!.availableContracts![index]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "Category : ${contract.contractCategory!}",
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Name : ${contract.contractDisplay!}",
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Market : ${contract.market!}",
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Sub Market : ${contract.submarket!}",
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                );
              } else if (state is AvailableContractsError) {
                return Text(state.message ?? 'An error occurred');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
}
