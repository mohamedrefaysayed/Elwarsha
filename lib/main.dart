// ignore_for_file: non_constant_identifier_names
import 'package:elwarsha/Helper/cahch_helper.dart';
import 'package:elwarsha/Presentation/Screens/profile/Profile%20personly.dart';
import 'package:elwarsha/business_logic/Cubits/Confirm_mail/confirm_mail_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Login/login_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Map/map_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Notification_Button/notify_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Passwors_Obscure/pass_op_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Register/register_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Team_Info/team_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/Verfy_email/verifyemail_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/addItem/add_item_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/archive/archive_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/carInfo/car_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/cart/cart_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/comments/comments_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/edit/edit_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/elwarsha_Info/elwarsha_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/fav/fav_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/getInfo/get_info_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/imageLabeling/image_labling_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/map_Picker/map_picker_cubit.dart';
import 'package:elwarsha/business_logic/Cubits/nav_bar/bottom_nav_bar_cubit.dart';
import 'package:elwarsha/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Presentation/Screens/Splash_Screens/splash.dart';
import 'business_logic/Cubits/Payment/payment_cubit.dart';
import 'business_logic/Cubits/RepairRequest/repair_request_cubit.dart';
import 'business_logic/Cubits/Reset_password/reset_password_cubit.dart';
import 'business_logic/Cubits/role/role_cubit.dart';
import 'global/global.dart';



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.requestPermission();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("Token :$fcmToken");
  FirebaseMessaging.onBackgroundMessage((message) async{
    print(message.notification!.title);
    print(message.notification!.body);

  });
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await CahchHelper.init();
  final Prefs = await SharedPreferences.getInstance();
  userKey = Prefs.getString("userKey");
  final showHome = Prefs.getBool('showHome') ?? false;
  final signMethod = Prefs.getString('signMethod') ?? "";
  Role = Prefs.getString('role') ?? "";
  elwarshaState = false;
  stordimagePath = Prefs.getString("image") ?? null;
  SignedIn = CahchHelper.getData(key: "signedIn") ?? false;
  runApp(Elwarsha(showHome: showHome,signMethod: signMethod));
}

class Elwarsha extends StatelessWidget {
  final bool showHome;
  final String signMethod;

  const Elwarsha({Key? key, required this.showHome, required this.signMethod}) : super(key: key);

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
        BlocProvider(create: (context) => MapPickerCubit()),
        BlocProvider(create: (context) => ImageLablingCubit()),
        BlocProvider(create: (context) => RoleCubit()),
        BlocProvider(create: (context) => ElwarshaInfoCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => FavCubit()),
        BlocProvider(create: (context) => CommentsCubit()),
        BlocProvider(create: (context) => AddItemCubit()),
        BlocProvider(create: (context) => ArchiveCubit()),

      ],
      child: MaterialApp(

          debugShowCheckedModeBanner: false,
          themeAnimationCurve: Curves.ease,
          theme: ThemeData(
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              bodySmall: TextStyle(color: Colors.white),
            ),
            primarySwatch: Colors.blueGrey,
            fontFamily: "Vazirmatn",
          ),
          title: 'الورشة',
          home: SplashScreen(showHome: showHome, signMethod: signMethod)),
    );
  }
}
