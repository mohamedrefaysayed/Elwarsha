import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/Presentation/Screens/profile/Elwarsha_profile.dart';
import 'package:elwarsha/global/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:meta/meta.dart';

import '../../../Helper/Location_helper.dart';
part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  static Position? position;
  static bool isloaded = true;
  static var availableMaps;
  static bool? isConnectedToInternet;
  List<LatLng> gasStaionCoordinates = [
    LatLng(30.614836, 32.288224),
    LatLng(30.614441, 32.270523),
    LatLng(30.615082, 32.281407),
    LatLng(30.62329693666872, 32.28353381564759),
    LatLng(30.62429693666872, 32.28253381564759),
    LatLng(30.62129693666872, 32.28753381564759),
    LatLng(30.61529693666872, 32.28853381564759),
    LatLng(30.61929693666872, 32.28153381564759),
  ];
  List<LatLng> WorkShopsCoordinates = [
    LatLng(30.625255, 32.281574),
    LatLng(30.624124863608962, 32.28276617408132),
    LatLng(30.62229693666872, 32.28853381564759),
    LatLng(30.623152, 32.285698),
    LatLng(30.616999, 32.277118),
    LatLng(30.616602, 32.295708),
    LatLng(30.617873, 32.286505),
    LatLng(30.616734, 32.283659),
    LatLng(30.616285, 32.288555),
    LatLng(30.608563, 32.285331),

  ];
  List<LatLng> SpearPartsCoordinates = [
    LatLng(30.613857, 32.294558),
    LatLng(30.616950, 32.270264),
    LatLng(30.611597, 32.272095),
    LatLng(30.606721, 32.275882),
    LatLng(30.608856, 32.290189),
    LatLng(30.608504, 32.296042),
    LatLng(30.617075, 32.294539),
    LatLng(30.614944, 32.286497),
    LatLng(30.614848, 32.281544),
    LatLng(30.608741, 32.300745),
    LatLng(30.615611, 32.279671),
    LatLng(30.617490, 32.294148),
    LatLng(30.611609, 32.276092),
  ];

  static Set<Marker> markers = {};


MapCubit() : super(MapInitial());


  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation();
    availableMaps = await MapLauncher.installedMaps;
    isConnectedToInternet = await myApplication.checkInternet();
    emit(MapInitial());
    print(availableMaps);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

   addGasSMarkers(BuildContext context) async {
    if(markers!={}) {
      removeMarkers();
    }
    if(gasStaionCoordinates!=null) {
      for (LatLng coordinate in gasStaionCoordinates) {
        final Uint8List markerIcon = await getBytesFromAsset(
            "assets/images/gasStaion.png", 100);
        final Marker marker = Marker(
          icon: BitmapDescriptor.fromBytes(markerIcon),
          markerId: MarkerId(coordinate.toString()),
          position: coordinate,
          infoWindow: InfoWindow(title: "محطة وقود", snippet: ""),
          onTap: () {
            myApplication.markerDialog(context,coordinate.latitude,coordinate.longitude,position!.latitude,position!.longitude,(){});
          },
        );
        markers.add(marker);

      }
      emit(MapInitial());
    }
  }
   addWorkSMarkers(BuildContext context) async {
     if(markers!={}) {
       removeMarkers();
     }

     final Uint8List markerIcon = await getBytesFromAsset(
         "assets/images/workstation.png", 100);

       await ffire.collection('Elwrash').get().then((value){

         GeoPoint? location;



         value.docs.forEach((element) async{




             location = element["warshalocation"];


             LatLng coordinate = LatLng(location!.latitude, location!.longitude);

             final Marker marker = Marker(
               icon: BitmapDescriptor.fromBytes(markerIcon),
               markerId: MarkerId(coordinate.toString()),
               position: LatLng(location!.latitude, location!.longitude),
               infoWindow: InfoWindow(title: "ورشة : "+element["warshaName"], snippet: ""),
               onTap: () {
                 myApplication.markerDialog(context,coordinate.latitude,coordinate.longitude,MapCubit.position!.latitude,MapCubit.position!.longitude,
                         (){
                       Navigator.pop(context);
                       myApplication.navigateTo(Elwarsha_profile(element["warshaKey"]), context);
                     }
                 );
               },
             );
             MapCubit.markers.add(marker);

           emit(MapInitial());

         });

       });


    //    for (LatLng coordinate in WorkShopsCoordinates) {
    //     final Uint8List markerIcon = await getBytesFromAsset(
    //         "assets/images/workstation.png", 100);
    //     final Marker marker = Marker(
    //       icon: BitmapDescriptor.fromBytes(markerIcon),
    //       markerId: MarkerId(coordinate.toString()),
    //       position: coordinate,
    //       infoWindow: InfoWindow(title: "ورشة", snippet: ""),
    //       onTap: () {
    //         myApplication.markerDialog(context,coordinate.latitude,coordinate.longitude,position!.latitude,position!.longitude,(){});
    //       },
    //     );
    //     markers.add(marker);
    //
    //   emit(MapInitial());
    // }
  }
   addSparePMarkers(BuildContext context) async {
    if(markers!={}) {
      removeMarkers();
    }
    if(SpearPartsCoordinates!=null) {
      for (LatLng coordinate in SpearPartsCoordinates) {
        final Uint8List markerIcon = await getBytesFromAsset(
            "assets/images/sparepartsWorkshop.png", 150);
        final Marker marker = Marker(
          icon: BitmapDescriptor.fromBytes(markerIcon),
          markerId: MarkerId(coordinate.toString()),
          position: coordinate,
          infoWindow: InfoWindow(title: "متجر قطع غيار", snippet: ""),
          onTap: () {
            myApplication.markerDialog(context,coordinate.latitude,coordinate.longitude,position!.latitude,position!.longitude,(){});
          },
        );
        markers.add(marker);

      }
      emit(MapInitial());
    }
  }
   removeMarkers(){
    markers = {};
    emit(MapInitial());
   }

  endloading(){
    isloaded = false;
    Future.delayed(Duration(milliseconds: 500)).whenComplete(() => emit(MapInitial()));
  }
}
