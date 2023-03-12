import 'dart:async';
import 'package:elwarsha/business_logic/Cubits/Map/map_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../Constents/colors.dart';
import '../../../../Constents/fontsize.dart';
import '../../../../Helper/MyApplication.dart';
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
  MapController OSMMapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    areaLimit: BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west: 5.9559113,
    ),
  );

  bool? checkinternet;

  @override
  initState() {
    super.initState();
    BlocProvider.of<MapCubit>(context).getMyCurrentLocation();
  }

  // ignore: non_constant_identifier_names
  final Completer<GoogleMapController> _Mapcontroller =
      Completer<GoogleMapController>();

  final searchcontroller = TextEditingController();

  

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(MapCubit.position!.latitude, MapCubit.position!.longitude),
    tilt: 0.0,
    zoom: 17,
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

  GoogleMapController? newGoogelMapContriller;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        myApplication.keyboardFocus(context);
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: SizedBox(
              height: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: mycolors.popColor,
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: mycolors.secod_color,
                            size: 30,
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: mycolors.popColor,
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: TextButton(
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: CustomSearchDelegate());
                          },
                          child: Icon(
                            Icons.search,
                            color: mycolors.secod_color,
                            size: 30,
                          )),
                    ),
                    // MyAnimSearchBar(
                    //   helpText: "..... البحث",
                    //   rtl: true,
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //   ),
                    //   textFieldIconColor: mycolors.secod_color,
                    //   textFieldColor: mycolors.popColor,
                    //   color: mycolors.popColor,
                    //   autoFocus: true,
                    //   searchIconColor: mycolors.secod_color,
                    //   boxShadow: true,
                    //   prefixIcon: Icon(
                    //     Icons.search,
                    //     color: mycolors.secod_color,
                    //     size: 30,
                    //   ),
                    //   closeSearchOnSuffixTap: true,
                    //   width: 290,
                    //   textController: searchcontroller,
                    //   onSuffixTap: () {
                    //     setState(() {
                    //       searchcontroller.clear();
                    //     });
                    //   },
                    //   onSubmitted: (value) {
                    //
                    //   },
                    // ),
                  ]),
            )),
        body: BlocBuilder<MapCubit, MapState>(
  builder: (context, state) {
    return MapCubit.position != null
        ? Stack(
            children: [
              // FlutterMap(
              //     options: MapOptions(
              //       center: latlng.LatLng(30.613559, 32.270719),
              //       zoom: 9.2,
              //     ),
              //     children: [
              //       TileLayer(
              //         minZoom: 1,
              //         maxZoom: 18,
              //         backgroundColor: Colors.black,
              //         urlTemplate:
              //         'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              //         subdomains: ['a', 'b', 'c'],
              //       ),
              //     ]),
              // OSMFlutter(
              //   onGeoPointClicked: (GeoPoint geo){
              //     if (geo == GeoPoint(
              //         latitude: 30.613559,
              //         longitude: 32.270719)){
              //       print("object");
              //     }
              //   },
              //   androidHotReloadSupport: true,
              //   controller: OSMMapController,
              //   trackMyPosition: true,
              //   initZoom: 17,
              //   minZoomLevel: 2,
              //   maxZoomLevel: 19,
              //   stepZoom: 10.0,
              //   userLocationMarker: UserLocationMaker(
              //     personMarker: MarkerIcon(
              //       icon: Icon(
              //         myicons.directions_car,
              //         color: mycolors.secod_color,
              //         size: 80,
              //       ),
              //     ),
              //     directionArrowMarker: MarkerIcon(
              //       icon: Icon(
              //         Icons.double_arrow,
              //         size: 48,
              //       ),
              //     ),
              //   ),
              //   roadConfiguration: RoadOption(
              //     roadColor: mycolors.popColor,
              //   ),
              //   markerOption: MarkerOption(
              //       defaultMarker: MarkerIcon(
              //     icon: Icon(
              //       Icons.scale,
              //       color: Colors.blue,
              //       size: 500,
              //     ),
              //   )),
              // ),
              GoogleMap(
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: _myCurrentLocationCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _Mapcontroller.complete(controller);
                    newGoogelMapContriller = controller..setMapStyle('''
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
                  ''');
                  },
                ),
              isinrequestmode
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: 105.0, left: 20),
                        child: FloatingActionButton.extended(
                          heroTag: "repairrequest",

                          backgroundColor: mycolors.Floatcolor,
                          onPressed: () {
                            OSMMapController.addMarker(
                              GeoPoint(
                                  latitude: 30.613559,
                                  longitude: 32.270719),
                              markerIcon: const MarkerIcon(
                                icon: Icon(
                                  Icons.apartment,
                                  size: 100,
                                ),
                              ),

                            );
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
                    ),
            ],
          )
        : Center(
            child: CircularProgressIndicator(
              color: mycolors.secod_color,
            ),
          );
  },
),
        floatingActionButton: Padding(
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
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
