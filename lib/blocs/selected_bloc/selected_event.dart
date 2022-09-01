part of 'selected_bloc.dart';

abstract class SelectedEvent extends Equatable {
  const SelectedEvent();

  @override
  List<Object> get props => [];
}

class ToggleSelectModeEvent extends SelectedEvent {
  final bool toggle;
  const ToggleSelectModeEvent({
    required this.toggle,
  });

  @override
  List<Object> get props => [
        toggle,
      ];
}
