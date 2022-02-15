import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';
import 'package:flutter_deriv_api/api/contract/models/available_contract_model.dart';

final ContractsForSymbol availableContracts = ContractsForSymbol(
  availableContracts: availableContractsList,
);

final List<AvailableContractModel> availableContractsList =
    <AvailableContractModel>[
  AvailableContractModel(
    barrierCategory: 'american',
    contractCategory: 'touchnotouch',
    contractCategoryDisplay: 'Touch/No Touch',
    contractDisplay: 'Touches',
    exchangeName: 'RANDOM',
    market: 'synthetic_index',
    submarket: 'random_index',
  ),
  AvailableContractModel(
    barrierCategory: 'american',
    contractCategory: 'touchnotouch',
    contractCategoryDisplay: 'Touch/No Touch',
    contractDisplay: 'Touches',
    exchangeName: 'RANDOM',
    market: 'synthetic_index',
    submarket: 'random_index',
  ),
];
