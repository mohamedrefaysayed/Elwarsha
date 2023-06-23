part of 'elwarsha_info_cubit.dart';

@immutable
abstract class ElwarshaInfoState {}

class ElwarshaInfoInitial extends ElwarshaInfoState {}
class ElwarshaInfoLoading extends ElwarshaInfoState {}
class ElwarshaInfoSuccess extends ElwarshaInfoState {}
class ElwarshaInfoFailuer extends ElwarshaInfoState {}

