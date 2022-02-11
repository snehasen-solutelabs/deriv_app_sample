import 'package:deriv_app_sample/core/bloc_manager/event_listener_contracts/tick_stream_event_listner.dart';
import 'package:deriv_app_sample/core/state/TickStream/tick_stream_cubit.dart';
import 'package:flutter_deriv_bloc_manager/manager.dart';

/// Tick state emitter.
class TickStateEmitter
    extends BaseStateEmitter<TickEventListener, TickStreamCubit> {
  /// Initializes Tick state emitter.
  TickStateEmitter(BaseBlocManager blocManager) : super(blocManager);

  @override
  void handleStates({
    required TickEventListener eventListener,
    required Object state,
  }) {
    if (state is TicksLoaded) {
      eventListener.onTickLoaded(state.tick);
    } else if (state is TicksLoading) {
      eventListener.onTickLoading();
    } else if (state is TicksInitial) {
      eventListener.onTickInitial();
    } else if (state is TicksError) {
      eventListener.onTickError(state.message.toString());
    }
  }
}
