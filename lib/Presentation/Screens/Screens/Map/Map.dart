import 'dart:async';
import '../../../../Constents/colors.dart';
import '../../../../Constents/fontsize.dart';
import '../../../../Helper/MyApplication.dart';
import '../../Map/repair request.dart';
import '../../../../global/global.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../Helper/Location_helper.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap>
    with AutomaticKeepAliveClientMixin<MyMap> {
  @override
  initState() {
    super.initState();
    getMyCurrentLocation();
  }

  final Completer<GoogleMapController> _Mapcontroller =
      Completer<GoogleMapController>();

  final searchcontroller = TextEditingController();
  static Position? position;

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _Mapcontroller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  GoogleMapController? newGoogelMapContriller;

  Widget build(BuildContext context) {
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
            title: Container(
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
                            offset: Offset(0, 3), // changes position of shadow
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
                            offset: Offset(0, 3), // changes position of shadow
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
        body: position != null
            ? GoogleMap(
                compassEnabled: false,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                initialCameraPosition: _myCurrentLocationCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _Mapcontroller.complete(controller);
                  newGoogelMapContriller = controller;
                },
              )
            : Center(
                child: Container(
                  child: CircularProgressIndicator(
                    color: mycolors.secod_color,
                  ),
                ),
              ),
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                isinrequestmode
                    ? SizedBox()
                    : FloatingActionButton.extended(
                        backgroundColor: mycolors.Floatcolor,
                        onPressed: () {
                          myApplication.navigateTo(Repair_Request(), context);
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
                            Container(
                              height: 40,
                              width: 40,
                              child: ClipRect(
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset("assets/images/screw.png"),
                              ),
                            )
                          ],
                        ),
                      ),
                SizedBox(
                  width: myApplication.widthClc(100, context),
                ),
                FloatingActionButton.extended(
                  backgroundColor: mycolors.first_color,
                  onPressed: _goToMyCurrentLocation,
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
