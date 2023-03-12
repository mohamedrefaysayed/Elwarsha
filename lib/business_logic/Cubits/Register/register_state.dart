part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {}
class RegisterFailuer extends RegisterState {
  String errormessage;
  RegisterFailuer({required this.errormessage});
}

