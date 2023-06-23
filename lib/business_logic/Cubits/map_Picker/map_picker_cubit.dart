import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Constents/colors.dart';
import 'package:elwarsha/business_logic/Cubits/elwarsha_Info/elwarsha_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:geocoding/geocoding.dart';
import '../Map/map_cubit.dart';

part 'map_picker_state.dart';

class MapPickerCubit extends Cubit<MapPickerState> {
  static var currentAddress;
  static GeoPoint? finalPosition = ElwarshaInfoCubit.warshaLocation!=null ? ElwarshaInfoCubit.warshaLocation : null;
  static LatLng? _markerPosition;
  Map<MarkerId, Marker> _markers = {};
  static bool isloading = false;


  MapPickerCubit() : super(MapPickerInitial());


  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(MapCubit.position!.latitude, MapCubit.position!.longitude),
    tilt: 0.0,
    zoom: 16,
  );

  void addMarker(LatLng position) async{
    _markerPosition = position;
    final markerId = MarkerId('marker_id');
    final marker = Marker(
      markerId: markerId,
      position: position,
    );
    _markers[markerId] = marker;
    emit(MapPickerInitial());
     placemarkFromCoordinates(position.latitude,position.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress =
      '${place.street}';
      print(currentAddress);
    });

  }

  mapPicker(context, onpressed) {
    final Completer<GoogleMapController> _Mapcontroller =
    Completer<GoogleMapController>();
    GoogleMapController? _GoogelMapController;
    String _mapDarkMood() {
      return '''

[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  }
]
                  ''';
    }


    AwesomeDialog(

      dialogType: DialogType.noHeader,
      dialogBackgroundColor: mycolors.popColor,
      body: Container(
        height: 450,
        width: 300,
        child: BlocBuilder<MapPickerCubit, MapPickerState>(
          builder: (context, state) {
            return Stack(
              children: [
                GoogleMap(
                  onTap: addMarker,
                  myLocationButtonEnabled: false,
                  mapToolbarEnabled: false,
                  minMaxZoomPreference: MinMaxZoomPreference(14, 17),
                  markers: Set<Marker>.of(_markers.values),
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: _myCurrentLocationCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    stoploading();
                    _Mapcontroller.complete(controller);
                    _GoogelMapController =
                    controller..setMapStyle(_mapDarkMood());
                  },
                ),
                Positioned(
                  top: 5,
                  right: 10,
                  child: Container(
                    child: Container(
                      width: 280,
                      child: Text(
                        currentAddress != null
                            ? currentAddress
                            : "",
                        style: TextStyle(

                          overflow: TextOverflow.ellipsis,
                            fontSize: 15,color: mycolors.secod_color
                        ),
                        textAlign: TextAlign.end
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 50,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 10),
                      child: FloatingActionButton.extended(
                        heroTag: "mylocation",
                        backgroundColor: mycolors.first_color,
                        onPressed: () async {
                          if (await Geolocator.isLocationServiceEnabled()) {
                            final GoogleMapController controller = await _Mapcontroller
                                .future;
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                    _myCurrentLocationCameraPosition));
                          } else {
                            // ignore: use_build_context_synchronously
                            BlocProvider.of<MapCubit>(context)
                                .getMyCurrentLocation();
                          }
                        },
                        label: const Icon(Icons.my_location),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),

      btnOkOnPress: (){
        ElwarshaInfoCubit.warshaLocation = GeoPoint(_markerPosition!.latitude, _markerPosition!.longitude)   ;
        emit(MapPickerInitial());
      },
      btnOkText: "تأكيد",
      btnOkColor: mycolors.secod_color,
      context: context,
    ).show();
  }

  changeState() {
    emit(MapPickerInitial());
  }

  loading() {
    isloading = true;
    emit(MapPickerInitial());
  }

  stoploading() {
    isloading = false;
    emit(MapPickerInitial());
  }
}
