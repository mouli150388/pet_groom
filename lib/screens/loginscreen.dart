import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/data/auth_datasource.dart';
import 'package:pet_groom/data/repositories/user_local_data_source.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/screens/dashboard_screen.dart';
import 'package:pet_groom/screens/forgotpass.dart';
import 'package:pet_groom/screens/signupscreen.dart';
import 'package:pet_groom/screens/widgets/loading_circle.dart';
import 'package:pet_groom/shared/app_colors.dart';
import 'package:pet_groom/shared/app_textfield.dart';
import 'package:pet_groom/shared/button_widget.dart';
import 'package:pet_groom/shared/header_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _confirmEmailFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  TextEditingController _emailEditController=TextEditingController();
  TextEditingController _passwordEditController=TextEditingController();
  bool isLoading=false;
  bool showPassConfirm=true;
  AuthDataSource authDataSource=getItInstance();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Image.asset("assets/images/logo-small.png",height: 120,),
          Row(mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(

                  decoration: BoxDecoration(
                      color: AppColor.pink,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(18),
                      )),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "${AppLocalizations.of(context)?.login}",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40,),
              Expanded(
                child: Container(

                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(18),
                      )),
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return SignupScreen();}));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "${AppLocalizations.of(context)?.signup_here}",
                        style: TextStyle(color: AppColor.font_header,fontWeight: FontWeight.bold,fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ),
            ],),
          SizedBox(height: 40,),
          HeaderText(text:"${AppLocalizations.of(context)?.welcome_back}"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextFormField(hintText:"${AppLocalizations.of(context)?.email}" ,
                  textInputAction: TextInputAction.next,textInputType: TextInputType.emailAddress,
                  controller: _emailEditController,
                ),
                SizedBox(height: 20,),
                AppTextFormField(
                  suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey,),
                    onPressed: () { setState(() {
                      showPassConfirm=!showPassConfirm;
                    }); },),
                  hintText: "${AppLocalizations.of(context)?.password_hint}",
                  textInputAction: TextInputAction.next,obscureText: showPassConfirm,
                  controller: _passwordEditController,
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          /*Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [*/

              TextButton(

                onPressed: () async {


                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return ForgotPassScreen(
                       );

                  }));
                },
                child: Text("${AppLocalizations.of(context)?.forgot_password}?"),

              ),
            /*],
          ),*/
          SizedBox(height: 10,),
          (isLoading)? Center(child: LoadingCircle(size: 75,)): AppPrimaryButton(onPress: () async{
            String email=_emailEditController.text.trim();
            String password=_passwordEditController.text.trim();
            setState(() {
              isLoading=true;
            });

            Map<String,dynamic>params=Map();
            params['password']=password;
            params['email']=email;

            ApiResponse apiResposne=await authDataSource.loginUser(params);
            Fluttertoast.showToast(msg: apiResposne.msg, toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: AppColor.pink,
                textColor: Colors.white,
                fontSize: 16.0);

            if(apiResposne.code=='9')
            {
              UserLocalDataSource _userLocalDataSource=UserLocalDataSourceImpl();
              _userLocalDataSource.saveUser((apiResposne.data));
              ApiConstants.USER_ID=apiResposne.data['id'].toString();
              ApiConstants.USER_Name=apiResposne.data['name'];
              if(apiResposne.data['profile_picture']!=null)
              ApiConstants.IMAGE=apiResposne.data['profile_picture'];
              setState(() {
                isLoading=false;
              });

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return DashBoardScreen();}));
            }
            setState(() {
              isLoading=false;
            });

          },text: "${AppLocalizations.of(context)?.login}",),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "${AppLocalizations.of(context)?.to_continue}",
                style: TextStyle(color:Colors.black),
                children: [
                  TextSpan(
                    text: " ${AppLocalizations.of(context)?.privacy_policy} ",
                    style: TextStyle(decoration: TextDecoration.underline,color:AppColor.btn_color),

                  ),TextSpan(
                    text: " ${AppLocalizations.of(context)?.and} ",
                    style: TextStyle(color:Colors.black),
                  ),
                  TextSpan(
                    text: "${AppLocalizations.of(context)?.privacy_policy_regarding}",
                    style: TextStyle(decoration: TextDecoration.underline,color:AppColor.btn_color),
                  ),TextSpan(
                  text: " ${AppLocalizations.of(context)?.before_registering} ",
                style: TextStyle(color:Colors.black),
              ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
        ],
      )),
    );


    /*Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Image.asset("assets/images/logo-small.png",height: 120,),
          Row(mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(

                  decoration: BoxDecoration(
                      color: AppColor.pink,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(18),
                      )),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40,),
              Expanded(
                child: Container(

                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(18),
                      )),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: AppColor.font_header,fontWeight: FontWeight.bold,fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],),
          SizedBox(height: 40,),
          HeaderText(text:"Welcome back!"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextFormField(focusNode: _confirmEmailFocusNode,hintText: "Email",),
                SizedBox(height: 20,),
                AppTextFormField(focusNode: _confirmPasswordFocusNode,hintText: "Email",),
              ],
            ),
          ),

          SizedBox(height: 40,),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              TextButton(

                onPressed: () async{


                  Map<String,dynamic>map=Map();
                  map['email']="email";


                  // Navigator.pushReplacementNamed(context, AppRoutes.signup);
                },
                child: Text("${AppLocalizations.of(context)?.forgot_password}"),

              ),
            ],
          ),
          SizedBox(height: 20,),
          AppPrimaryButton(onPress: (){},text: "Sign In",),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "${AppLocalizations.of(context)?.to_continue}",
                style: TextStyle(color:Colors.black),
                children: [
                  TextSpan(
                    text: " ${AppLocalizations.of(context)?.terms_condition} ",
                    style: TextStyle(decoration: TextDecoration.underline,color:Colors.black),

                  ),TextSpan(
                    text: " ${AppLocalizations.of(context)?.and} ",
                    style: TextStyle(color:Colors.black),
                  ),
                  TextSpan(
                    text: "${AppLocalizations.of(context)?.privacy_policy}",
                    style: TextStyle(decoration: TextDecoration.underline,color:Colors.black),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    )*/
  }
}