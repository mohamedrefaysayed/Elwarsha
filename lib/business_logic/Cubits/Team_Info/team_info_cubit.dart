import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'team_info_state.dart';

class TeamInfoCubit extends Cubit<TeamInfoState> {
  static bool appinfo = false;
  static bool uiinfo = false;
  static bool flutterinfo = false;
  static bool frontinfo = false;
  static bool backinfo = false;

  TeamInfoCubit() : super(TeamInfoInitial());
  void reversappinfo(){
    appinfo = !appinfo;
    emit(TeamInfoInitial());
  }
  void reversuiinfo(){
    uiinfo = !uiinfo;
    emit(TeamInfoInitial());
  }
  void reversflutterinfo(){
    flutterinfo = !flutterinfo;
    emit(TeamInfoInitial());
  }
  void reversfrontinfo(){
    frontinfo = !frontinfo;
    emit(TeamInfoInitial());
  }
  void reversbackinfo(){
    backinfo = !backinfo;
    emit(TeamInfoInitial());
  }
}
