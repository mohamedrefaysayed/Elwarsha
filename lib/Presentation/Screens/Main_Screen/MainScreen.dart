import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:elwarsha/Helper/MyApplication.dart';
import 'package:elwarsha/business_logic/Cubits/nav_bar/bottom_nav_bar_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Constents/colors.dart';
import 'package:flutter/material.dart';
import '../Info/Sane3y_Data.dart';
import '../Map/Map.dart';
import '../auth/Login_Screen.dart';
import '../auth/Regester_Screen.dart';
import '../profile/Profile personly.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final searchcontroller = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    BottomNavBarCubit.selectedIndex = 2;
    BottomNavBarCubit.tabController = TabController(length: 5, vsync: this,initialIndex: 2);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: mycolors.first_color,
      body: WillPopScope(
        onWillPop: () => myApplication.onWillPop(context),
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: BottomNavBarCubit.tabController,
          children: [
            LoginScreen(),
            RegisterScreen(),
            MyMap(),
            const Sane3yData(),
            const person_file(),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          return CurvedNavigationBar(
            animationCurve: Curves.ease,
            animationDuration: const Duration(milliseconds: 500),
            index: BottomNavBarCubit.selectedIndex,
            items: [
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.shopping_cart,
                    color: mycolors.secod_color,
                  ),
                  label: "المتجر",
                  labelStyle: TextStyle(color: mycolors.secod_color)),
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.history,
                    color: mycolors.secod_color,
                  ),
                  label: "الأرشيف",
                  labelStyle: TextStyle(color: mycolors.secod_color)),
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.map,
                    color: mycolors.secod_color,
                  ),
                  label: "الخريطة",
                  labelStyle: TextStyle(color: mycolors.secod_color)),
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.favorite,
                    color: mycolors.secod_color,
                  ),
                  label: "المفضلة",
                  labelStyle: TextStyle(color: mycolors.secod_color)),
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.person,
                    color: mycolors.secod_color,
                  ),
                  label: "صفحتى",
                  labelStyle: TextStyle(color: mycolors.secod_color)),
            ],
            color: mycolors.popColor,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: mycolors.popColor,
            onTap: BlocProvider.of<BottomNavBarCubit>(context).onItemclicked,
          );
        },
      ),
    );
  }
}
