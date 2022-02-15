import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_bloc_manager/manager.dart';

/// Interface for blocs that need  current selected active symbol.
abstract class SelectActiveSymbolEventListener implements BaseEventListener {
  /// On active symbol selection change event handler.
  void onSelectActiveSymbol(final ActiveSymbol selectedSymbol);
}
