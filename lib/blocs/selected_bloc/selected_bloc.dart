import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_event.dart';
part 'selected_state.dart';

class SelectedBloc extends Bloc<SelectedEvent, SelectedState> {
  SelectedBloc() : super(SelectedState()) {
    on<ToggleSelectModeEvent>(_onToggleSelectionMode);
    on<ZoomInEvent>(_onZoomIn);
  }

  void _onToggleSelectionMode(
      ToggleSelectModeEvent event, Emitter<SelectedState> emit) {
    final state = this.state;

    emit(SelectedState(selectMode: event.toggle));
  }

  void _onZoomIn(ZoomInEvent event, Emitter<SelectedState> emit) {
    final state = this.state;
    

    emit(SelectedState(isZoomIn: event.toggle));
  }
}
