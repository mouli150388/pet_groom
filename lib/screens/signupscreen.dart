import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/data/auth_datasource.dart';
import 'package:pet_groom/data/repositories/user_local_data_source.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/screens/loginscreen.dart';
import 'package:pet_groom/screens/otpscreen.dart';
import 'package:pet_groom/screens/widgets/loading_circle.dart';
import 'package:pet_groom/shared/app_colors.dart';
import 'package:pet_groom/shared/app_textfield.dart';
import 'package:pet_groom/shared/button_widget.dart';
import 'package:pet_groom/shared/header_text.dart';

import 'package:pet_groom/core/extensions/common_extension.dart';
class SignupScreen extends StatefulWidget{
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthDataSource authDataSource=getItInstance();
  TextEditingController _nameEditController=TextEditingController();
  TextEditingController _phoneEditController=TextEditingController();
  TextEditingController _emailEditController=TextEditingController();
  TextEditingController _passwordEditController=TextEditingController();
  TextEditingController _conpasswordEditController=TextEditingController();
  TextEditingController _addressEditController=TextEditingController();
  TextEditingController _cityEditController=TextEditingController();
  TextEditingController _stateEditController=TextEditingController();
  bool passwordState=true;
  bool conpasswordState=true;
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: ListView(
        children: [
          Column(
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

                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(18),
                        )),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return LoginScreen();}));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "${AppLocalizations.of(context)?.login}",
                          style: TextStyle(color: AppColor.font_header,fontWeight: FontWeight.bold,fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40,),
                Expanded(
                  child: Container(

                    decoration: BoxDecoration(
                        color: AppColor.pink,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(18),
                        )),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "${AppLocalizations.of(context)?.signup_here}",
                        style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],),
            SizedBox(height: 40,),
            HeaderText(text:"${AppLocalizations.of(context)?.create_an_account}"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextFormField(hintText:"${AppLocalizations.of(context)?.name}" ,
                    textInputAction: TextInputAction.next,
                    controller: _nameEditController,
                  ),
                  SizedBox(height: 10,),
                  AppTextFormField(hintText:"${AppLocalizations.of(context)?.email}" ,
                    textInputAction: TextInputAction.next,textInputType: TextInputType.emailAddress,
                    controller: _emailEditController,
                  ),
                  SizedBox(height: 10,),
                  AppTextFormField(hintText:"${AppLocalizations.of(context)?.mobile_hint}" ,
                    textInputAction: TextInputAction.next,textInputType: TextInputType.phone,
                    controller: _phoneEditController,
                    limitCount: 10,
                    isLimit: true,

                  ),
                  SizedBox(height: 10,),
                  AppTextFormField(hintText:"${AppLocalizations.of(context)?.password_hint}" ,
                    textInputAction: TextInputAction.next,obscureText: passwordState,
                    autofocus: false,
                     controller: _passwordEditController,
                    suffixIcon: IconButton(icon: Icon(passwordState?Icons.visibility_off_outlined
                        : Icons.visibility_outlined,color: Colors.grey,),
                      onPressed: () { setState(() {
                        passwordState=!passwordState;
                      }); },),

                    /* suffixIcon: IconButton(icon: Icon(passwordState
                          ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,color: Colors.grey,), onPressed: () {
                       setState(() {
                         passwordState=!passwordState;
                       });
                     }

                  ),*/ ),
                  SizedBox(height: 10,),
                  AppTextFormField(hintText:"${AppLocalizations.of(context)?.confirm_password}" ,

                     controller: _conpasswordEditController,
                    autofocus: false,
                    suffixIcon: IconButton(icon: Icon(conpasswordState?Icons.visibility_off_outlined
                          : Icons.visibility_outlined,color: Colors.grey,),
                      onPressed: () { setState(() {
                        conpasswordState=!conpasswordState;
                      }); },),
                      /*suffixIcon: IconButton(icon: Icon(conpasswordState
                          ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,color: Colors.grey,), onPressed: () {
                        setState(() {
                          conpasswordState=!conpasswordState;
                        });

                     },

                  ),*/
                    textInputAction: TextInputAction.next,obscureText: conpasswordState,
                  ),
                  AppTextFormField(hintText:"${AppLocalizations.of(context)?.address}" ,
                    textInputAction: TextInputAction.next,
                    controller: _addressEditController,
                  ),
                  SizedBox(height: 10,),
                  AppTextFormField(hintText:"${AppLocalizations.of(context)?.city}" ,
                    textInputAction: TextInputAction.next,
                    controller: _cityEditController,
                  ),
                  SizedBox(height: 10,),
                  AppTextFormField(hintText:"${AppLocalizations.of(context)?.state}" ,
                    textInputAction: TextInputAction.done,
                    controller: _stateEditController,
                  )

                ],
              ),
            ),
            SizedBox(height: 20,),

            (isLoading)? Center(child: LoadingCircle(size: 75,)): AppPrimaryButton(onPress: () async{
              print("OnButton click");

              String name=_nameEditController.text.trim();
              String phone=_phoneEditController.text.trim();
              String email=_emailEditController.text.trim();
              String password=_passwordEditController.text.trim();
              String conpass=_conpasswordEditController.text.trim();
              String address=_addressEditController.text.trim();
              String city=_cityEditController.text.trim();
              String state=_stateEditController.text.trim();
              if(name.isEmpty||phone.isEmpty||email.isEmpty||password.isEmpty||address.isEmpty||city.isEmpty||state.isEmpty)
                {
                  Fluttertoast.showToast(msg: "Please enter all fields", toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColor.pink,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  return;
                }
               if(!email.isValidEmail())
                 {
                   Fluttertoast.showToast(msg: "Please enter valid email", toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColor.pink,
                        textColor: Colors.white,
                        fontSize: 16.0);
                       return;
                 }
              if(!phone.isValidNUmber())
              {
                Fluttertoast.showToast(msg: "Please enter valid mobile number", toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColor.pink,
                    textColor: Colors.white,
                    fontSize: 16.0);
                return;
              }
              if(password.length<4)
                {
                  Fluttertoast.showToast(msg: "Password should be minimum 4 digits", toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColor.pink,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  return;
                }
              if(password!=conpass)
                {
                  Fluttertoast.showToast(msg: "Password and Confirm password should be same", toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColor.pink,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  return;
                }
              setState(() {
                isLoading=true;
              });

              Map<String,dynamic>params=Map();
              params['password']=password;
              params['email']=email;
              params['name']=name;
              params['phone']=phone;
              params['city']=city;
              params['state']=state;
              params['address']=address;
             ApiResponse apiResposne=await authDataSource.signupUser(params);
              Fluttertoast.showToast(msg: apiResposne.msg, toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColor.pink,
                        textColor: Colors.white,
                        fontSize: 16.0);

             if(apiResposne.code=='7')
               {
                 UserLocalDataSource _userLocalDataSource=UserLocalDataSourceImpl();
                 _userLocalDataSource.saveUser((apiResposne.data));
                 ApiConstants.USER_ID=apiResposne.data['id'].toString();
                 ApiConstants.USER_Name=apiResposne.data['name'];
                 var otp=apiResposne.data['otp'];
                 setState(() {
                   isLoading=false;
                 });

                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                   return OTPScreen(_phoneEditController.text,otp);}));
               }
              setState(() {
                isLoading=false;
              });
             /* Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return OTPScreen(_phoneEditController.text);}));*/
              
            },text: "${AppLocalizations.of(context)?.signup_here}",),
            SizedBox(height: 10,),
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
        ),
        ],
      )),
    );
  }
}