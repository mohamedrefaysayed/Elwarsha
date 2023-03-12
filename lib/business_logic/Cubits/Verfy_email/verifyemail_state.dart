part of 'verifyemail_cubit.dart';

@immutable
abstract class VerifyemailState {}

class VerifyemailInitial extends VerifyemailState {}
class VerifyemailFailure extends VerifyemailState {
  String errormessage;
  VerifyemailFailure({required this.errormessage});
}

