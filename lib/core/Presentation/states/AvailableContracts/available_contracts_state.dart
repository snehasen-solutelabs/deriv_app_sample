// AvailableContractsState
import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';

abstract class AvailableContractsState {}

/// Loading state for available contracts
class AvailableContractsLoading extends AvailableContractsState {}

/// Error state for available contracts
class AvailableContractsError extends AvailableContractsState {
  /// Initializes
  AvailableContractsError(this.errorMessage);

  /// Error message
  final String errorMessage;
}

///Loaded state for available contracts
class AvailableContractsLoaded extends AvailableContractsState {
  /// Initializes
  AvailableContractsLoaded({
    this.contracts,
  });

  /// Contracts
  final ContractsForSymbol? contracts;
}
