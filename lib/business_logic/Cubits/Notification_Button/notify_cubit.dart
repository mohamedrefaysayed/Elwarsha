import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notify_state.dart';

class NotifyCubit extends Cubit<NotifyState> {
  static bool notify = true;

  NotifyCubit() : super(NotifyInitial());

  void setnotify(){
    notify = !notify;
    emit(NotifyInitial());
  }
}
