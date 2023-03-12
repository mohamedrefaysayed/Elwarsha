import 'package:elwarsha/Presentation/Screens/Main_Screen/MainScreen.dart';
import 'package:elwarsha/business_logic/Cubits/carInfo/car_info_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../Constents/colors.dart';
import '../../../../Helper/MyApplication.dart';
import 'package:flutter/material.dart';
import '../../../Helper/MY_SnackBar.dart';

// ignore: constant_identifier_names
const List<String> Cars = <String>[" ", 'مرسيدس', 'bmw', 'هيونداى', 'هوندا'];
// ignore: constant_identifier_names
const List<String> ModelYears = <String>[" ", '2010', '2020', '2022', '2023'];
// ignore: constant_identifier_names
const List<String> EnginCapactys = <String>[
  " ",
  '1600',
  '2000',
  '2500',
  '3000',
  '1115',
  '41515',
  '15115',
  '2245'
];
// ignore: constant_identifier_names
const List<String> EnginPowers = <String>[" ", '500', '1000', '900', '300'];
// ignore: constant_identifier_names
const List<String> StructureTypes = <String>[" ", 'سيدان', 'هاتشباك'];

class CarInfo extends StatefulWidget { const CarInfo( {Key? key, this.isregerster,}) : super(key: key);

  final isregerster;

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  final formkey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  final BranchName = TextEditingController();

  // ignore: non_constant_identifier_names
  final BranchAddress = TextEditingController();

  // ignore: non_constant_identifier_names
  final BranchNumber = TextEditingController();

  saveCarInfo() async {
    if(!widget.isregerster){

      BlocProvider.of<CarInfoCubit>(context).updateInfo(
          Car: CarInfoCubit.Car,
          Model: CarInfoCubit.Model,
          EnginCap: CarInfoCubit.EnginCap,
          EnginPow: CarInfoCubit.EnginPow,
          StructType: CarInfoCubit.StructType,
          agency: CarInfoCubit.agency);
      BlocProvider.of<CarInfoCubit>(context).getInfo();

    }else{
      BlocProvider.of<CarInfoCubit>(context).setInfo(
          Car: CarInfoCubit.Car,
          Model: CarInfoCubit.Model,
          EnginCap: CarInfoCubit.EnginCap,
          EnginPow: CarInfoCubit.EnginPow,
          StructType: CarInfoCubit.StructType,
          agency: CarInfoCubit.agency);
      BlocProvider.of<CarInfoCubit>(context).getInfo();
    }


  }

  late String pic = "assets/images/car.png";

  @override
  void initState() {
    BlocProvider.of<CarInfoCubit>(context).getInfo();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          myApplication.keyboardFocus(context);
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: mycolors.first_color,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: mycolors.secod_color,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              'الورشة',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<CarInfoCubit, CarInfoState>(
            builder: (context, state) {
              if (state is CarInfoLoading) {
                return Container(
                  color: mycolors.first_color,
                  child: Center(
                    child: myApplication.myloading(context),
                  ),
                );
              } else if (state is CarInfoFailuer) {
                return Center(
                  child: Text("ther is a problem !"),
                );
              } else {
                pic = CarInfoCubit.Car == "bmw"
                    ? "assets/images/bmw.png"
                    : CarInfoCubit.Car == "مرسيدس"
                    ? "assets/images/marcedec.png"
                    : "assets/images/car.png";
                return Form(
                  key: formkey,
                  child: Container(
                    color: mycolors.first_color,
                    child: ListView(
                      children: [
                        Container(
                          margin:
                          const EdgeInsets.only(left: 30, right: 30, top: 25),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 190,
                                  width: 340,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(pic),
                                  )),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          dropdownColor: mycolors.popColor,
                                          alignment: Alignment.centerRight,
                                          menuMaxHeight: 300,
                                          value: CarInfoCubit.Car,
                                          iconSize: 25,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: mycolors.secod_color,
                                          ),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                          elevation: 16,
                                          underline: Container(
                                            height: 2,
                                            color: Colors.white,
                                          ),
                                          onChanged: (String? value) {
                                            // This is called when the user selects an item.
                                            BlocProvider.of<CarInfoCubit>(context).settype(value!);
                                            if (CarInfoCubit.Car == "bmw") {
                                              pic = "assets/images/bmw.png";
                                            } else if (CarInfoCubit.Car == "مرسيدس") {
                                              pic =
                                              "assets/images/marcedec.png";
                                            } else {
                                              pic = "assets/images/car.png";
                                            }
                                          },
                                          items:
                                          Cars.map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  alignment: Alignment.center,
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 35,
                                      ),
                                      const Text(
                                        'ماركة السيارة',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          dropdownColor: mycolors.popColor,
                                          alignment: Alignment.centerRight,
                                          menuMaxHeight: 300,
                                          value: CarInfoCubit.Model,
                                          iconSize: 25,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: mycolors.secod_color,
                                          ),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                          elevation: 16,
                                          underline: Container(
                                            height: 2,
                                            color: Colors.white,
                                          ),
                                          onChanged: (String? value) {
                                            // This is called when the user selects an item.
                                            BlocProvider.of<CarInfoCubit>(context).setmodle(value!);
                                          },
                                          items: ModelYears.map<
                                              DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  alignment: Alignment.center,
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 52,
                                      ),
                                      const Text(
                                        'موديل عام',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          dropdownColor: mycolors.popColor,
                                          alignment: Alignment.centerRight,
                                          menuMaxHeight: 300,
                                          value: CarInfoCubit.EnginCap,
                                          iconSize: 25,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: mycolors.secod_color,
                                          ),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                          elevation: 16,
                                          underline: Container(
                                            height: 2,
                                            color: Colors.white,
                                          ),
                                          onChanged: (String? value) {
                                            // This is called when the user selects an item.
                                            BlocProvider.of<CarInfoCubit>(context).setcap(value!);
                                          },
                                          items: EnginCapactys.map<
                                              DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  alignment: Alignment.center,
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      const Text(
                                        ' سعة المحرك',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          dropdownColor: mycolors.popColor,
                                          alignment: Alignment.centerRight,
                                          menuMaxHeight: 300,
                                          value: CarInfoCubit.EnginPow,
                                          iconSize: 25,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: mycolors.secod_color,
                                          ),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                          elevation: 16,
                                          underline: Container(
                                            height: 2,
                                            color: Colors.white,
                                          ),
                                          onChanged: (String? value) {
                                            // This is called when the user selects an item.
                                            BlocProvider.of<CarInfoCubit>(context).setpow(value!);
                                          },
                                          items: EnginPowers.map<
                                              DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  alignment: Alignment.center,
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 46,
                                      ),
                                      const Text(
                                        'قوة المحرك',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          dropdownColor: mycolors.popColor,
                                          alignment: Alignment.centerRight,
                                          menuMaxHeight: 300,
                                          value: CarInfoCubit.StructType,
                                          iconSize: 25,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: mycolors.secod_color,
                                          ),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                          elevation: 16,
                                          underline: Container(
                                            height: 2,
                                            color: Colors.white,
                                          ),
                                          onChanged: (String? value) {
                                            // This is called when the user selects an item.
                                            BlocProvider.of<CarInfoCubit>(context).setstruct(value!);
                                          },
                                          items: StructureTypes.map<
                                              DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  alignment: Alignment.center,
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 53,
                                      ),
                                       const Text(
                                        'نوع الهيكل',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 28,
                                  ),
                                  InkWell(
                                    onTap: () => myApplication.agencydialog(
                                      context,
                                      CarInfoCubit.Info!= null
                                          ? CarInfoCubit.Info!["agencyName"]
                                          : "",
                                      CarInfoCubit.Info!= null
                                          ? CarInfoCubit.Info!["agencyAddress"]
                                          : "",
                                      CarInfoCubit.Info!= null
                                          ? CarInfoCubit.Info!["agencyPhone"]
                                          : "",
                                      CarInfoCubit.agency,
                                    ),
                                    child:  Text(
                                      'تابعة للتوكيل ؟',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: mycolors.secod_color,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'لا',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Radio(
                                          value: "n",
                                          groupValue: CarInfoCubit.agency,
                                          fillColor:
                                          MaterialStateColor.resolveWith(
                                                  (states) =>
                                              mycolors.secod_color),
                                          onChanged: (val) {
                                            BlocProvider.of<CarInfoCubit>(context).setagency(val!);
                                          }),
                                      const SizedBox(
                                        width: 80,
                                      ),
                                      const Text(
                                        'نعم',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Radio(
                                          value: "y",
                                          groupValue: CarInfoCubit.agency,
                                          fillColor:
                                          MaterialStateColor.resolveWith(
                                                  (states) =>
                                              mycolors.secod_color),
                                          onChanged: (val) {
                                            myApplication.agencydialog(
                                                context,
                                                CarInfoCubit.Info!= null
                                                  ? CarInfoCubit.Info!["agencyName"]
                                                  : "",
                                                CarInfoCubit.Info!= null
                                                  ? CarInfoCubit.Info!["agencyAddress"]
                                                  : "",
                                                CarInfoCubit.Info!= null
                                                  ? CarInfoCubit.Info!["agencyPhone"]
                                                  : "",
                                                val,
                                            );
                                            BlocProvider.of<CarInfoCubit>(context).setagency(val!);
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              saveCarInfo();
                              myApplication.keyboardFocus(context);
                             if(!widget.isregerster){
                                showTopSnackBar(Overlay.of(context),
                                    MySnackBar.success(message: "تم الحفظ"));

                              }else{
                                myApplication.navigateToRemove(
                                    context, const MainScreen());
                              }
                            },
                            child: const Text(
                              'حفظ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ));
  }
}
