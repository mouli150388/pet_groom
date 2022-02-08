
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_groom/blocs/bottom_navigation_model.dart';
import 'package:pet_groom/blocs/index_cubit.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/screens/booking/bookings.dart';
import 'package:pet_groom/screens/dashboard/history.dart';
import 'package:pet_groom/screens/dashboard/home.dart';
import 'package:pet_groom/screens/profile/profile_screen.dart';

import 'package:pet_groom/shared/app_colors.dart';

class DashBoardScreen extends StatelessWidget{

  GlobalKey<ScaffoldState>_scaffoldGlobalKey=GlobalKey();
  final List<Widget> screens = [
      HomeScreen(),
      HistoryScreen(),
    ProfileScreen(),

  ];

  final IndexCubit _indexCubit = getItInstance<IndexCubit>();

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(providers: [
      BlocProvider<IndexCubit>( create: (BuildContext context) => _indexCubit, ),
    ], child: BlocBuilder<IndexCubit,int>(
      bloc: _indexCubit..currentIndex(0),
      builder: (_,currentIndex){

        return WillPopScope(
          onWillPop: () async{
            return await _onWillPop(context);
          },
          child: Scaffold(
            key:_scaffoldGlobalKey,
            body: SafeArea(child: screens[currentIndex]),
            bottomNavigationBar: CurvedNavigationBar(
              color: AppColor.lightPrimary,
              index: currentIndex,
              height: 54.0,
              onTap: (index)=>_indexCubit..change(index),
              animationCurve: Curves.ease,
              animationDuration: Duration(milliseconds: 500),
              buttonBackgroundColor: AppColor.lightPrimary,
              backgroundColor: AppColor.white,
              items: bottomNavigationItems.map((e) {
                String lable="";
                if(e.label.startsWith("Home"))
                 lable="${AppLocalizations.of(context)?.home}";
                else if(e.label.startsWith("Bookings"))
                 lable="${AppLocalizations.of(context)?.mybookings}";
                else if(e.label.startsWith("Profi"))
                 lable="${AppLocalizations.of(context)?.profile}";
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(e.icon,size: 22,color: AppColor.white),

                    Text("${lable}",style: TextStyle(fontSize: 8,color: AppColor.white),),
                    SizedBox(height:2),
                  ],);
              }).toList(),),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: AppColor.lightPrimary,
                    ),
                    child: InkWell(
                      onTap: (){
                        if (_scaffoldGlobalKey.currentState!.isDrawerOpen) {
                          _scaffoldGlobalKey.currentState!.openEndDrawer();
                        }
                        _indexCubit..change(2);
                      },
                      child: Column(
                        children: [
                          Image.asset("assets/logo_round.png",height: 80,),
                          SizedBox(height: 10,),
                            Text('Pet Groom',style: TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
        );
      },
    ));

  }
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(
        color: Colors.deepOrange,
      ),
    );
  }


  @override
  void dispose() {

  }








  Future<bool> _onWillPop(context) async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title:  Text("",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black)),
        content:  Text("${AppLocalizations.of(context)?.exit_app}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('${AppLocalizations.of(context)?.cancel}'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('${AppLocalizations.of(context)?.yes}'),
          ),
        ],
      ),
    )) ?? false;
  }

}