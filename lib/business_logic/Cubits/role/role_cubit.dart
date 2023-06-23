
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'role_state.dart';

class RoleCubit extends Cubit<RoleState> {
  static String? role;

  RoleCubit() : super(RoleInitial());

  changestate(val){
    role = val;
    emit(RoleInitial());
  }
}
