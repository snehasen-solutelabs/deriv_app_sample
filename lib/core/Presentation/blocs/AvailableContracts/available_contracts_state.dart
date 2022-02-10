import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';
import 'package:flutter_deriv_api/api/contract/models/available_contract_model.dart';

/// AvailableContractsState
abstract class AvailableContractsState {
  /// Initializes
  AvailableContractsState();
}

/// AvailableContractsLoading
class AvailableContractsLoading extends AvailableContractsState {
  @override
  String toString() => 'AvailableContractsLoading...';
}

/// AvailableContractsError
class AvailableContractsError extends AvailableContractsState {
  /// Initializes
  AvailableContractsError(this.message);

  /// Error message
  final String? message;

  @override
  String toString() => 'AvailableContractsError';
}

/// AvailableContractsLoaded
class AvailableContractsLoaded extends AvailableContractsState {
  ///Initializes
  AvailableContractsLoaded({
    this.contracts,
    AvailableContractModel? selectedContract,
  }) : _selectedContract =
            selectedContract ?? contracts?.availableContracts?.first;

  /// Contracts
  final ContractsForSymbol? contracts;

  final AvailableContractModel? _selectedContract;

  /// Selected Contract
  AvailableContractModel? get selectedContract => _selectedContract;

  @override
  String toString() =>
      'AvailableContractsLoaded ${contracts!.availableContracts!.length} contracts';
}
