import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwarsha/Helper/MY_SnackBar.dart';
import 'package:elwarsha/Presentation/Screens/Map/requests.dart';
import 'package:elwarsha/Presentation/Screens/profile/Elwarsha_profile.dart';
import 'package:elwarsha/business_logic/Cubits/Map/map_cubit.dart';
import 'package:elwarsha/Ai/imageLabeling.dart';
import 'package:elwarsha/business_logic/Cubits/elwarsha_Info/elwarsha_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/getInfo/get_info_cubit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../Constents/colors.dart';
import '../../../../Constents/fontsize.dart';
import '../../../../Helper/MyApplication.dart';
import '../../../shared/anim_search_bar.dart';
import 'repair%20request.dart';
import '../../../../global/global.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();


}

class _MyMapState extends State<MyMap>
    with AutomaticKeepAliveClientMixin<MyMap> {
  // ignore: non_constant_identifier_names

  bool? checkinternet;

  bool searchR = false;


  @override
  initState() {
    super.initState();
    MapCubit.isloaded = true;
    BlocProvider.of<MapCubit>(context).getMyCurrentLocation();
    BlocProvider.of<GetInfoCubit>(context).getInfo();
  }

  // ignore: non_constant_identifier_names
  final Completer<GoogleMapController> _Mapcontroller =
      Completer<GoogleMapController>();

  final searchcontroller = TextEditingController();

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


  static CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(MapCubit.position!.latitude, MapCubit.position!.longitude),
    tilt: 0.0,
    zoom: 16,
  );

  Future<void> _goToMyCurrentLocation() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      final GoogleMapController controller = await _Mapcontroller.future;
      controller.animateCamera(
          CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
    } else {
      // ignore: use_build_context_synchronously
      BlocProvider.of<MapCubit>(context).getMyCurrentLocation();
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  GoogleMapController? _GoogelMapController;

  bool gasSFlag = false;
  bool WorkSFlag = false;
  bool sparePFlag = false;

  _MarkerCatBuilder(title, icon, ontap) {
    return Row(
      children: [
        Container(
          child: TextButton.icon(
            onPressed: ontap,
            icon: Icon(
              icon,
              color: mycolors.secod_color,
            ),
            label: Text(
              title,
              style: TextStyle(color: mycolors.secod_color),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        myApplication.keyboardFocus(context);
      },
      child: BlocBuilder<MapCubit, MapState>(
  builder: (context, state) {
    return Scaffold(
        backgroundColor: mycolors.first_color,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Role == "سائق سيارة"
              ? SizedBox(
                  height: myApplication.hightClc(70, context),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: myApplication.hightClc(10, context)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: mycolors.popColor,
                              borderRadius: BorderRadius.circular(45),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  myApplication.navigateTo(
                                      imagelabeling(), context);
                                },
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: mycolors.secod_color,
                                  size: 30,
                                )),
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.grey.withOpacity(0.2),
                          //         spreadRadius: 5,
                          //         blurRadius: 7,
                          //         offset: const Offset(0, 3), // changes position of shadow
                          //       ),
                          //     ],
                          //     color: mycolors.popColor,
                          //     borderRadius: BorderRadius.circular(45),
                          //   ),
                          //   child: TextButton(
                          //       onPressed: () {
                          //         showSearch(
                          //             context: context,
                          //             delegate: CustomSearchDelegate());
                          //       },
                          //       child: Icon(
                          //         Icons.search,
                          //         color: mycolors.secod_color,
                          //         size: 30,
                          //       )),
                          // ),
                          MyAnimSearchBar(
                            helpText: "..... البحث",
                            rtl: true,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textFieldIconColor: mycolors.secod_color,
                            textFieldColor: mycolors.popColor,
                            color: mycolors.popColor,
                            autoFocus: true,
                            searchIconColor: mycolors.secod_color,
                            boxShadow: true,
                            prefixIcon: Icon(
                              Icons.search,
                              color: mycolors.secod_color,
                              size: myApplication.widthClc(30, context),
                            ),
                            closeSearchOnSuffixTap: true,
                            width: myApplication.widthClc(290, context),
                            textController: searchcontroller,
                            onSuffixTap: () {
                                searchcontroller.clear();
                                BlocProvider.of<MapCubit>(context).emit(MapInitial());
                            },
                            onSubmitted: (searchvalue) async {

                              final Uint8List markerIcon = await getBytesFromAsset(
                                  "assets/images/workstation.png", 100);

                              await ffire.collection('Elwrash').get().then((value){

                                GeoPoint? location;



                                value.docs.forEach((element) async{

                                  if(element["warshaName"] == searchvalue){
                                    searchR = true;

                                    location = element["warshalocation"];
                                    _GoogelMapController!.animateCamera(CameraUpdate.newLatLng(
                                        LatLng(location!.latitude, location!.longitude)
                                    ));


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
                                              myApplication.navigateTo(Elwarsha_profile( warshaKey: element["warshaKey"]), context);
                                            }
                                        );
                                      },
                                    );
                                    MapCubit.markers.add(marker);
                                  }
                                });

                              });

                              if(searchR){
                                print("موجود");

                              }else{
                                print("مش موجود");

                                myApplication.showToast(text: "لا يوجد نتيجة", color: mycolors.secod_color);
                              }
                              searchR = false;
                              BlocProvider.of<MapCubit>(context).emit(MapInitial());
                            },
                          ),
                        ]),
                  ),
                )
              : SizedBox(
                      height: myApplication.hightClc(70, context),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: myApplication.hightClc(10, context)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: elwarshaState!
                                      ? mycolors.Floatcolor
                                      : mycolors.popColor,
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      elwarshaState = !elwarshaState!;
                                      BlocProvider.of<ElwarshaInfoCubit>(context).setState();
                                      if(ElwarshaInfoCubit.Info![""]) {
                                        showTopSnackBar(
                                            Overlay.of(context),
                                            MySnackBar.success(
                                                message: "تم فتح الورشة وبدء البث"));
                                      }else{
                                        showTopSnackBar(
                                            Overlay.of(context),
                                            MySnackBar.error(
                                                message: "تم قفل الورشة وإيقاف البث"));
                                      }
                                      BlocProvider.of<MapCubit>(context).emit(MapInitial());
                                    },
                                    child: Icon(
                                      Icons.online_prediction_sharp,
                                      color: elwarshaState!
                                          ? mycolors.first_color
                                          : Colors.grey,
                                      size: 30,
                                    )),
                              ),
                            ]),
                      ),
                    ),

        ),

        body: MapCubit.position != null
                ? MapCubit.isConnectedToInternet!
                    ? Stack(
                        children: [
                          GoogleMap(
                            mapToolbarEnabled: false,
                            minMaxZoomPreference: MinMaxZoomPreference(14, 17),
                            markers: MapCubit.markers,
                            compassEnabled: false,
                            zoomControlsEnabled: false,
                            mapType: MapType.normal,
                            myLocationButtonEnabled: false,
                            myLocationEnabled: true,
                            initialCameraPosition:
                                _myCurrentLocationCameraPosition,
                            onMapCreated: (GoogleMapController controller) {
                              _Mapcontroller.complete(controller);
                              _GoogelMapController = controller
                                ..setMapStyle(_mapDarkMood());
                              BlocProvider.of<MapCubit>(context).endloading();
                            },
                          ) ,
                          Role == "سائق سيارة"
                              ? Container(
                                  padding: EdgeInsets.only(
                                      top: 100, left: 20, right: 20),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: IconButton(
                                              onPressed: () {
                                                _goToMyCurrentLocation();

                                                BlocProvider.of<MapCubit>(
                                                        context)
                                                    .removeMarkers();
                                                WorkSFlag = false;
                                                gasSFlag = false;
                                                sparePFlag = false;
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                color: mycolors.secod_color,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        _MarkerCatBuilder("الورش", Icons.build,
                                            () {
                                          _GoogelMapController!.animateCamera(
                                              CameraUpdate.zoomTo(14));

                                          WorkSFlag
                                              ? null
                                              : BlocProvider.of<MapCubit>(
                                                      context)
                                                  .addWorkSMarkers(context);
                                          WorkSFlag = true;
                                          gasSFlag = false;
                                          sparePFlag = false;
                                        }),
                                        _MarkerCatBuilder(
                                            "قطع الغيار", Icons.car_repair, () {
                                          _GoogelMapController!.animateCamera(
                                              CameraUpdate.zoomTo(14));

                                          sparePFlag
                                              ? null
                                              : BlocProvider.of<MapCubit>(
                                                      context)
                                                  .addSparePMarkers(context);
                                          sparePFlag = true;
                                          gasSFlag = false;
                                          WorkSFlag = false;
                                        }),
                                        _MarkerCatBuilder("محطات الوقود",
                                            Icons.local_gas_station, () {
                                          _GoogelMapController!.animateCamera(
                                              CameraUpdate.zoomTo(14));

                                          gasSFlag
                                              ? null
                                              : BlocProvider.of<MapCubit>(
                                                      context)
                                                  .addGasSMarkers(context);
                                          gasSFlag = true;
                                          WorkSFlag = false;
                                          sparePFlag = false;
                                        }),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),

                          Role == "سائق سيارة"
                          ? isinrequestmode
                              ? const SizedBox()
                              : Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 105.0, left: 20),
                                    child: FloatingActionButton.extended(
                                      heroTag: "repairrequest",
                                      backgroundColor: mycolors.Floatcolor,
                                      onPressed: () {
                                        myApplication.navigateTo(
                                            const Repair_Request(), context);
                                      },
                                      label: Row(
                                        children: [
                                          Text(
                                            "طلب تصليح",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: myfonts.mediumfont),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: ClipRect(
                                              clipBehavior: Clip.antiAlias,
                                              child: Image.asset(
                                                  "assets/images/screw.png"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                          : Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding:  EdgeInsets.only(
                                  bottom: myApplication.hightClc(105, context), left: myApplication.widthClc(20, context)),
                              child: FloatingActionButton.extended(
                                heroTag: "repairrequest",
                                backgroundColor: elwarshaState! ? mycolors.Floatcolor : mycolors.popColor,
                                onPressed: () {

                                  showModalBottomSheet(
                                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                      shape: RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(20),
                                      ),

                                      context: context,
                                      builder: (BuildContext context){
                                        return requests();
                                      });
                                },

                                label: Row(
                                  children: [
                                    Text(
                                      "طلبات التصليح",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: myfonts.mediumfont),
                                    ),
                                    SizedBox(
                                      height: myApplication.hightClc(40, context),
                                      width: myApplication.widthClc(40, context),
                                      child: ClipRect(
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.asset(
                                            "assets/images/screw.png"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),


                          MapCubit.isloaded
                              ? Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  color: mycolors.first_color,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      myApplication.myloading(context),
                                    ],
                                  ),
                                )
                              : SizedBox(),

                          (elwarshaState! || Role == "سائق سيارة") ? Container() : myApplication.elwarshaOffline(context)
                        ],
                      )
                    : myApplication.noInternet(context)
                : Container(
                    color: mycolors.first_color,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: "الورشة",
                          child: Stack(
                            children: [
                              SizedBox(
                                height: myApplication.hightClc(255, context),
                                width: myApplication.widthClc(255, context),
                                child: Image.asset(
                                  "assets/images/Icon.png",
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: myApplication.hightClc(250, context),
                                width: myApplication.widthClc(250, context),
                                child: Image.asset(
                                  "assets/images/Icon.png",
                                  color: mycolors.popColor,
                                ),
                              ),
                              SizedBox(
                                height: myApplication.hightClc(245, context),
                                width: myApplication.widthClc(245, context),
                                child: Image.asset(
                                  "assets/images/Icon.png",
                                  color: mycolors.secod_color,
                                ),
                              ),
                              SizedBox(
                                height: myApplication.hightClc(245, context),
                                width: myApplication.widthClc(245, context),
                                child: Image.asset(
                                  "assets/images/blackScrew.png",
                                  color: mycolors.popColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(child: myApplication.myloading(context)),
                      ],
                    ),
                  ),
        floatingActionButton: (elwarshaState! || Role == "سائق سيارة") ? Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                SizedBox(
                  width: myApplication.widthClc(100, context),
                ),
                FloatingActionButton.extended(
                  heroTag: "mylocation",
                  backgroundColor: mycolors.first_color,
                  onPressed: () {
                    _goToMyCurrentLocation();
                  },
                  label: const Icon(Icons.my_location),
                ),
              ]),
              SizedBox(height: myApplication.hightClc(90, context)),
            ],
          ),
        ) : SizedBox(),
      );
  },
),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
