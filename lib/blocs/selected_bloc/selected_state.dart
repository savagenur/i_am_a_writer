part of 'selected_bloc.dart';

 class SelectedState extends Equatable {
   bool selectMode;
   bool isZoomIn;

   SelectedState(
    {this.selectMode=false,this.isZoomIn=false}
  );

  @override
  List<Object> get props => [selectMode,];
}


