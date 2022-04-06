import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/intro-screen.dart';
import 'package:pet_groom/providers/book_service_provider.dart';
import 'package:pet_groom/providers/connectivity.dart';
import 'package:pet_groom/screens/booking/bookings.dart';
import 'package:pet_groom/screens/booking/thanks_screen.dart';
import 'package:pet_groom/screens/dashboard_screen.dart';
import 'package:pet_groom/screens/forgotpass.dart';
import 'package:pet_groom/screens/loginscreen.dart';
import 'package:pet_groom/screens/onboarding.dart';
import 'package:pet_groom/screens/otpscreen.dart';
import 'package:pet_groom/screens/profile/add_pet.dart';
import 'package:pet_groom/screens/profile/change_password.dart';
import 'package:pet_groom/screens/profile/editprofile.dart';
import 'package:pet_groom/screens/signupscreen.dart';
import 'package:pet_groom/screens/splashscreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_groom/shared/app_colors.dart';
import 'l10n/l10.dart';
import 'package:google_fonts/google_fonts.dart';
import 'di/dependency_injection.dart' as get_it;
import 'screens/booking/summary.dart';
import 'package:provider/provider.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await get_it.init();
  runApp(ChangeNotifierProvider(
      create: (context) => BookserviceProvider(List.empty(growable: true)),
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        ScreenUtils.init(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
        );
        return BlocProvider.value(
          value: ConnectivityCubit(get_it.getItInstance())..checkConnectivity(),
          child: BlocListener<ConnectivityCubit, bool>(
            listener: (context, state) {

              print("Listnerthe netwrok status");
              if(!state)
                {
                  Fluttertoast.showToast(
                      msg: "Please Check Network connection",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColor.pink,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
            },
            child: MaterialApp(
              locale: L10n.all[0],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: [
                Locale('en', ''), // English, no country code

              ],
              title: 'Pet Spa VIP',
              theme: ThemeData(

                visualDensity: VisualDensity.adaptivePlatformDensity,

                primaryColor: Color(0xFFFFFFFF),
                primaryTextTheme: TextTheme(
                    headline6: TextStyle(
                        color: Colors.black
                    )
                ),
                textTheme: GoogleFonts.nunitoTextTheme(
                  Theme
                      .of(context)
                      .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
                ),
              ),
              routes: {
                '/': (context) => SplashScreen(),
                '/onboarding': (context) => OnBoardingScreen(),
                '/login': (context) => LoginScreen(),
                '/signup': (context) => SignupScreen(),
                '/forgotpass': (context) => ForgotPassScreen(),
                '/dashboard': (context) => DashBoardScreen(),
                '/bookingSummary': (context) => BookingSummary(),
                '/thanksScreen': (context) => ThanksScreen(),
                '/editprofile': (context) => EditProfile(),
                '/changepassword': (context) => ChangePassword(),
                '/addPetScren': (context) => AddPetScren(null),
                '/otpScreen': (context) => OTPScreen("", ""),
                '/bookingScreen': (context) => BookingScreen(),
              },

              initialRoute: '/',

            ),
          ),
        );
      },
    );
  }
}

