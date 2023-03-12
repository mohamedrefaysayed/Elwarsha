part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPassowrdState {}

class ResetPasswordInitial extends ResetPassowrdState {}
class ResetPasswordSuccess extends ResetPassowrdState {}
class ResetPasswordFailure extends ResetPassowrdState {
  String errormessage;
  ResetPasswordFailure({required this.errormessage});
}


