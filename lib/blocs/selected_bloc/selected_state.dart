part of 'selected_bloc.dart';

 class SelectedState extends Equatable {
   bool selectMode;

   SelectedState(
    {this.selectMode=false,}
  );

  @override
  List<Object> get props => [selectMode];
}


