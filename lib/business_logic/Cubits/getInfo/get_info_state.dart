part of 'get_info_cubit.dart';

@immutable
abstract class GetInfoState {}

class GetInfoLoading extends GetInfoState {}
class GetInfoSucsses extends GetInfoState {}
class GetInfoFailuer extends GetInfoState {}

