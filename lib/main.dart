// ignore_for_file: non_constant_identifier_names
import 'package:elwarsha/business_logic/Cubits/Confirm_mail/confirm_mail_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Login/login_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Map/map_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Notification_Button/notify_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Passwors_Obscure/pass_op_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Register/register_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Team_Info/team_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Verfy_email/verifyemail_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/carInfo/car_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/edit/edit_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/getInfo/get_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/nav_bar/bottom_nav_bar_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Presentation/Screens/Splash_Screens/splash.dart';
import 'business_logic/Cubits/Payment/payment_cubit.dart';
import 'business_logic/Cubits/RepairRequest/repair_request_cubit.dart';
import 'business_logic/Cubits/Reset_password/reset_password_cubit.dart';
import 'global/global.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final Prefs = await SharedPreferences.getInstance();
  userKey = Prefs.getString("userKey");

  final showHome = Prefs.getBool('showHome') ?? false;
  runApp(Elwarsha(showHome: showHome));
}

class Elwarsha extends StatelessWidget {
  final bool showHome;

  const Elwarsha({Key? key, required this.showHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => PassOpCubit()),
        BlocProvider(create: (context) => BottomNavBarCubit()),
        BlocProvider(create: (context) => ResetPasswordCubit()),
        BlocProvider(create: (context) => ConfirmMailCubit()),
        BlocProvider(create: (context) => VerifyemailCubit()),
        BlocProvider(create: (context) => MapCubit()),
        BlocProvider(create: (context) => PaymentCubit()),
        BlocProvider(create: (context) => RepairRequestCubit()),
        BlocProvider(create: (context) => TeamInfoCubit()),
        BlocProvider(create: (context) => NotifyCubit()),
        BlocProvider(create: (context) => GetInfoCubit()),
        BlocProvider(create: (context) => CarInfoCubit()),
        BlocProvider(create: (context) => EditCubit()),

      ],
      child: MaterialApp(
          locale: Locale('en'),
          localizationsDelegates:  [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],


          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (deviceLocale != null &&
                  deviceLocale.languageCode == locale.languageCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
             },
          debugShowCheckedModeBanner: false,
          themeAnimationCurve: Curves.ease,
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            fontFamily: "Vazirmatn",
          ),
          title: 'الورشة',
          home: SplashScreen(
            showHome: showHome,
          )),
    );
  }
}
