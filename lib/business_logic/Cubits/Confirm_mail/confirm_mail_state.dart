part of 'confirm_mail_cubit.dart';

@immutable
abstract class ConfirmMailState {}

class ConfirmMailInitial extends ConfirmMailState {}
class ConfirmMailLoading extends ConfirmMailState {}
class ConfirmMailSuccess extends ConfirmMailState {}
class ConfirmMailFailure extends ConfirmMailState {
  String errormessage;
  ConfirmMailFailure({required this.errormessage});
}

