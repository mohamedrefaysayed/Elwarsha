import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pass_op_state.dart';

class PassOpCubit extends Cubit<PassOpState> {
  PassOpCubit() : super(PassOpInitial());
  static bool passwordVisible = true;

  void changstate(){
    passwordVisible = !passwordVisible;
    emit(PassOpInitial());
  }
  void scure(){
    passwordVisible = true;
    emit(PassOpInitial());
  }
}
