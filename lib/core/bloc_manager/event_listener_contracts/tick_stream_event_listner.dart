import 'package:flutter_deriv_api/api/common/tick/tick.dart';
import 'package:flutter_deriv_bloc_manager/manager.dart';

/// Interface for blocs that need Tick.
abstract class TickEventListener implements BaseEventListener {
  /// on Tick loaded event handler.
  void onTickLoaded(Tick? tick);

  /// on Tick loading event handler.
  void onTickLoading();

  /// On Contract error event handler.
  void onTickError(String error);

  void onTickInitial();
}
