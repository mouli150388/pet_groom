import 'dart:convert';
import 'dart:io' as IO;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/data/auth_datasource.dart';
import 'package:pet_groom/data/repositories/user_local_data_source.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/request/profile_request.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/screens/widgets/loading_circle.dart';
import 'package:pet_groom/shared/app_colors.dart';

class EditProfile extends StatefulWidget{
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ApiClient api=getItInstance();

  bool showPassword=false;
  bool isLoading=false;

  TextEditingController _nameEditController=TextEditingController();

  TextEditingController _phoneEditController=TextEditingController();

  TextEditingController _emailEditController=TextEditingController();
  TextEditingController _countryController=TextEditingController();

  TextEditingController _passwordEditController=TextEditingController();

  

  String filepath="";

  late String _imageFile;
  late String country_name;
  late String country_code;
  late String profilepath="";

 // late ImageProvider provider;
  @override
  void initState()  {
    super.initState();
   // provider=AssetImage('assets/logo_round.png');
    callD();
  }
  callD()async
  {
    UserLocalDataSourceImpl().getUser().then((value)  {

      setState(() {
        ApiConstants.USER_ID=value!.id;
        ApiConstants.USER_Name=value!.name;
        // ApiConstants.IMAGE=value!.profile_picture;
        profilepath="${ApiConstants.baseUserProfile}${ApiConstants.IMAGE}";
        print("profilepath ${profilepath}");
        _nameEditController.text=ApiConstants.USER_Name;
        _emailEditController.text=value!.email;
        _phoneEditController.text=value!.phone;
      });

    });
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text("${AppLocalizations.of(context)?.profile}",),
          elevation: 1,
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
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child:
                  Stack(
                      children: [

                        CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(60)),
                              border: Border.all(color: Colors.black,width: 1),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          progressIndicatorBuilder: (context, url, progress) => Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: CircularProgressIndicator(

                                value: progress.progress,
                              ),
                            ),
                          ),
                          imageUrl:profilepath,
                          errorWidget: (
                            BuildContext context,
                            String url,
                            dynamic error,
                          ){
                            print("profile error ${url}");
                            return CircleAvatar(child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/user.png",)
                                )
                              ),
                            ),
                            radius: 56.0,
                            );
                          },
                        ),
                        /*CircleAvatar(
                            radius: 72.0,
                            backgroundColor: Colors.transparent,
                            backgroundImage: provider

                        ),*/
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child:ElevatedButton(
                              onPressed: () {
                                _pickImage();
                              },
                              child: Icon(Icons.edit,
                                  color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(2),
                                primary: Colors.blue, // <-- Button color
                                onPrimary: Colors.red, // <-- Splash color
                              ),
                            ) /*Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: AppColor.pink,
                              ),
                              child: TextButton(
                                onPressed: () {

                                  _pickImage();
                                },
                                child: Icon(
                                  Icons.edit,
                                  size:20,
                                  color: Colors.white,
                                ),
                              ),
                            )*/),

                      ])
                      /*BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if(state is LoadedUserData) {
                            filepath = state.userEntity.profile_picture;
                            ImageProvider provider=AssetImage('assets/logo_round.png');
                            if(filepath.isNotEmpty)
                              if(filepath.contains("http"))
                              provider=NetworkImage(filepath);
                              else
                              provider=FileImage(IO.File(filepath));
                            return Stack(
                                children: [

                              CircleAvatar(
                                radius: 72.0,
                                backgroundColor: Colors.transparent,
                                backgroundImage: provider
                            ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 4,
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                          ),
                                          color: AppColor.pink,
                                        ),
                                        child: TextButton(
                                          onPressed: () {

                                            _pickImage(state.userEntity);
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),

                  ]);

                          }


                       return SizedBox.shrink();
                    }),*/


                  ),
                (isLoading)?LoadingCircle(size:75.h,):SizedBox.shrink(),
                SizedBox(
                  height: 35,
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: _nameEditController,
                 
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "${AppLocalizations.of(context)?.name}",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "${AppLocalizations.of(context)?.name}",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: _phoneEditController,
                  

                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "${AppLocalizations.of(context)?.mobile_number}",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "${AppLocalizations.of(context)?.mobile_number}",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  ),
                ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                controller: _emailEditController,
              
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                readOnly: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "${AppLocalizations.of(context)?.email}",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "${AppLocalizations.of(context)?.email}",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),
           

                SizedBox(
                  height: 35,
                ),
                Row(
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
              if(_nameEditController.text.isEmpty||_phoneEditController.text.isEmpty)
              {
                Fluttertoast.showToast(
                    msg: "${AppLocalizations.of(context)?.field_empty}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColor.pink,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                return;
              }
              if(!validateMobile(_phoneEditController.text))
                {
                  Fluttertoast.showToast(
                      msg: "${AppLocalizations.of(context)?.enter_valid_number}",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColor.pink,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  return ;
                }


              callUpdate(ProfileRequestParams(email:_emailEditController.text,name: _nameEditController.text, phone: _phoneEditController.text, id: ApiConstants.USER_ID
              ));
              
            },
            color: AppColor.pink,
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
          ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
  }
  bool validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return false;
    }
    else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
   // try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      _imageFile = pickedFile!.path;
      await uploadImage();


      //userEntity.profile_picture=_imageFile!;
     // authCubit.setImage(userEntity);

   /* } catch (e) {
      print("Image picker error " + e.toString());
    }*/
  }

  late FormData formData ;

   uploadImage() async {
     print("Image picker uploading11 " );



     setState(() {
       isLoading=true;
     });

    print("Image picker uploading " );

     final bytes = IO.File(_imageFile).readAsBytesSync();
     if(bytes.length>1024*100)
       {
         Fluttertoast.showToast(
             msg: "Please select small image",//${AppLocalizations.of(context)?.imge_limit}
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.BOTTOM,
             timeInSecForIosWeb: 1,
             backgroundColor: AppColor.pink,
             textColor: Colors.white,
             fontSize: 16.0
         );
         setState(() {
           isLoading=false;
         });
         return;
       }
    // String base64Encode(List<int> bytes) => base64.encode(bytes);


     String base64Encode = base64.encode(bytes);
     formData = FormData.fromMap({
       "id": ApiConstants.USER_ID,
       "profile_picture": (ApiConstants.IMAGE==null)?"":ApiConstants.IMAGE,
       "image":base64Encode
     });

     print(base64Encode);
     print(formData.fields[0]);
        ApiResponse resposne=  ApiResponse.fromMap( await api.uploadImage(data: formData, options: Options(method: "POST"),path: ApiConstants.uploadImage,isImage: true ) as Map<String,dynamic>);

    String msg="";
    if(resposne.status)
      msg="${AppLocalizations.of(context)?.profile_update}";
      else msg="${AppLocalizations.of(context)?.try_again}";
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.pink,
          textColor: Colors.white,
          fontSize: 16.0
      );
     Navigator.pop(context,1);

  }

  void imageUpload(params) async{

  }

  callUpdate(params)async
  {
    setState(() {
      isLoading=true;
    });
    AuthDataSource updateProfileUC=getItInstance();
    String msg="${AppLocalizations.of(context)?.profile_update}";
    final ApiResponse response=await updateProfileUC.updateProfile(params.toJson());
    print("Profile Update 1 ${response.code}");

    Fluttertoast.showToast(
        msg: response.msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.pink,
        textColor: Colors.white,
        fontSize: 16.0
    );
    if(response.code=='22')
    {
      Navigator.pop(context,1);

    }
   // Navigator.pop(context);

  }
}