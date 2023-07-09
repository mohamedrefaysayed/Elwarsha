import 'package:elwarsha/Helper/MY_SnackBar.dart';
import 'package:elwarsha/business_logic/Cubits/Payment/payment_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/archive/archive_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../Constents/colors.dart';
import '../../../../Helper/MyApplication.dart';

// ignore: camel_case_types
class Payment_method extends StatelessWidget {

  _RadioBulder(BuildContext context, method) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text("$method",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold)),
      Radio(
          value: "$method",
          groupValue: PaymentCubit.payment,
          fillColor: MaterialStateColor.resolveWith(
                  (states) => mycolors.secod_color),
          onChanged: (val) {
            BlocProvider.of<PaymentCubit>(context).setpayment(val!);
          })
    ]);
  }

  const Payment_method({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mycolors.first_color,

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mycolors.first_color,
          elevation: 0,
          title: const Text("طريقة الدفع",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.amber,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          color: mycolors.first_color,
          child: Column(
            children: [
              SizedBox(height: myApplication.hightClc(50, context),),

              Container(
                height: myApplication.hightClc(350, context),
                margin: const EdgeInsets.only(right: 80),
                child: BlocBuilder<PaymentCubit, PaymentState>(
                  builder: (context, state) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _RadioBulder(context, "بطاقة الائتمان"),
                          _RadioBulder(context, "فودافون كاش"),
                          _RadioBulder(context, "فورى"),
                          _RadioBulder(context, "فواتيرك"),
                          _RadioBulder(context, "نقدى"),

                        ]);
                  },
                ),
              ),

              SizedBox(
                height: myApplication.hightClc(100, context),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () async{
                    await BlocProvider.of<ArchiveCubit>(context).addArchivedItems();
                    showTopSnackBar(Overlay.of(context),
                        MySnackBar.success(message: "تم الدفع بنجاح"),
                      displayDuration: Duration(milliseconds: 100),
                    );
                    Navigator.pop(context);
                    CartCubit.selectedProducts = [];
                    CartCubit.price = 0;
                    ArchiveCubit.archived =[];
                  },
                  child: BlocBuilder<ArchiveCubit, ArchiveState>(
                    builder: (context, state) {
                      if(state is ArchiveLoading){
                        return myApplication.myloading(context);
                      }else{
                        return Text(
                          'موافق',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
