import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/screens/widgets/loading_circle.dart';
import 'package:pet_groom/shared/app_colors.dart';
class ChangePassword extends StatefulWidget{
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _passwordEditController=TextEditingController();
  TextEditingController _currentpasswordEditController=TextEditingController();

  TextEditingController _conpasswordEditController=TextEditingController();

  bool showcurrentPass=false;
  bool showPass=false;
  bool showPassConfirm=false;
  bool isLoading=false;
  ApiClient api=getItInstance();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("${AppLocalizations.of(context)?.change_password}",style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
        child: Column(
          children: [
          SizedBox(height: 30.h),
                    TextField(
                    controller: _currentpasswordEditController,

                    decoration: InputDecoration(
                      hintText:"${AppLocalizations.of(context)?.enter_current_pass}" ,
                      prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                      suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey,),
                        onPressed: () { setState(() {
                          showcurrentPass=!showcurrentPass;
                        }); },),
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    obscureText: !showcurrentPass,
                  ),
            SizedBox(height: 20,), TextField(
                    controller: _passwordEditController,

                    decoration: InputDecoration(
                      hintText:"${AppLocalizations.of(context)?.password_hint}" ,
                      prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                      suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey,),
                        onPressed: () { setState(() {
                          showPass=!showPass;
                        }); },),
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    obscureText: !showPass,
                  ),
            SizedBox(height: 20,),
            TextField(
              controller: _conpasswordEditController,

              decoration: InputDecoration(
                hintText:"${AppLocalizations.of(context)?.confirm_password}",
                prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey,),
                  onPressed: () { setState(() {
                    showPassConfirm=!showPassConfirm;
                  }); },),
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              obscureText: showPassConfirm,
            ),
            SizedBox(height: 30,),
            (isLoading)?LoadingCircle(size: 75.sp): Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {Navigator.pop(context);},
                  child: Text("${AppLocalizations.of(context)?.cancel}",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black)),
                ),
                MaterialButton(
                  onPressed: () {
                    if(_currentpasswordEditController.text.trim().isEmpty)
                      {
                        Fluttertoast.showToast(
                            msg: "${AppLocalizations.of(context)?.enter_current_pass}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColor.pink,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        return;
                      }
                if(_conpasswordEditController.text.trim().length<4||(_conpasswordEditController.text!=_passwordEditController.text))
                  {
                    Fluttertoast.showToast(
                        msg: "${AppLocalizations.of(context)?.pass_confirm_match}",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColor.pink,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    return;
                  }
                setState(() {
                  isLoading=true;
                  callChangePassword();
                });
                  },
                  color: AppColor.black,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "${AppLocalizations.of(context)?.save}",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
    ),
      ),);
  }

  callChangePassword()async
  {
    Map<String,dynamic>data=Map();
    data['id']=ApiConstants.USER_ID;
    data['new_password']=_passwordEditController.text;
    data['current_password']=_currentpasswordEditController.text;

   var response= await api.post(ApiConstants.passwordchange,body: data,fakeData: false );

    Fluttertoast.showToast(
        msg: response['data'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.pink,
        textColor: Colors.white,
        fontSize: 16.0
    );
    if(response['code']=='17')
    {
      Navigator.pop(context);

    }else
      {
        setState(() {
          isLoading=false;
        });
      }
   print("Change Password ${response}");
  }
}