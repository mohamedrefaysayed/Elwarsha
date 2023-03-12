import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  static int selectedIndex = 2;
  static TabController? tabController;
  BottomNavBarCubit() : super(BottomNavBarInitial());

  void onItemclicked(int index) {
    selectedIndex = index;
    tabController!.index = index;
    if(index==0){
      emit(BottomNavBarInitial());
    }
    else if(index==1){
      emit(BottomNavBarInitial());
    }
    else{
      emit(BottomNavBarInitial());

    }

  }

}
