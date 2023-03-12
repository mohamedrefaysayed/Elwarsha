import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../../Helper/Location_helper.dart';
part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  static Position? position;


MapCubit() : super(MapInitial());


  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation();
    emit(MapInitial());
  }
}
