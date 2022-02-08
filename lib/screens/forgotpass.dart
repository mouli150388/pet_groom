import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/screens/signupscreen.dart';
import 'package:pet_groom/shared/app_colors.dart';
import 'package:pet_groom/shared/app_textfield.dart';
import 'package:pet_groom/shared/button_widget.dart';
import 'package:pet_groom/shared/header_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ForgotPassScreen extends StatefulWidget{

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final FocusNode _confirmEmailFocusNode = FocusNode();

  TextEditingController _emailEditController=TextEditingController();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Image.asset("assets/images/logo-small.png",height: 120,),

          SizedBox(height: 40,),
          HeaderText(text:"${AppLocalizations.of(context)?.forgot_password}"),
          Text("${AppLocalizations.of(context)?.forgot_sub_title}",style: TextStyle(letterSpacing: 1.1),textAlign: TextAlign.center,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextFormField(hintText:"${AppLocalizations.of(context)?.email}" ,controller: _emailEditController,
                  textInputAction: TextInputAction.done,textInputType: TextInputType.emailAddress,),
                SizedBox(height: 20,),

              ],
            ),
          ),
          SizedBox(height: 20,),

          (isLoading)? Center(child: CircularProgressIndicator()):  AppPrimaryButton(onPress: (){
          String  email=_emailEditController.text.trim();
            if(email.isEmpty)
            {
              Fluttertoast.showToast(msg:"Please enter register email", toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColor.pink,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return;
            }
            forgotPassword(email);
          },text: "${AppLocalizations.of(context)?.reset_password}",),

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
  forgotPassword(String email)async
  {
    setState(() {
      isLoading=true;
    });

    ApiClient api=getItInstance();
    var response= await api.post(ApiConstants.forgotpassword,body: {"email":email},fakeData: false );
    ApiResponse apiResposne=ApiResponse.fromMap(response);


    setState(() {
      isLoading=false;
    });
    if(apiResposne.code=='5')
    {

      Fluttertoast.showToast(msg: "Password sent to registered email id", toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.pink,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);


    }
    else if(apiResposne.code=='4')
      {
        Fluttertoast.showToast(msg: "This email id not registered", toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColor.pink,
            textColor: Colors.white,
            fontSize: 16.0);
      }
  }
}