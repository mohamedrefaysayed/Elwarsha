part of 'car_info_cubit.dart';

@immutable
abstract class CarInfoState {}

class CarInfoInitial extends CarInfoState {}
class CarInfoLoading extends CarInfoState {}
class CarInfoSucsses extends CarInfoState {}
class CarInfoFailuer extends CarInfoState {}

