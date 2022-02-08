import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_groom/blocs/auth/auth_cubit.dart';
import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/data/auth_datasource.dart';
import 'package:pet_groom/data/pet_model.dart';
import 'package:pet_groom/data/repositories/user_local_data_source.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/domain/entities/user_entity.dart';
import 'package:pet_groom/screens/loginscreen.dart';
import 'package:pet_groom/screens/profile/add_pet.dart';
import 'package:pet_groom/screens/profile/change_password.dart';
import 'package:pet_groom/screens/profile/editprofile.dart';
import 'package:pet_groom/screens/widgets/dialog_button.dart';
import 'package:pet_groom/screens/widgets/loading_circle.dart';
import 'package:pet_groom/shared/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int buttonsRowDirection = 1;
  bool isLoading = false;
  UserEntity? userEntity;
  //AuthCubit _authCubit=getItInstance();
  List<PetModel>listPets=List.empty(growable: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: SingleChildScrollView(
          child: Stack(children: <Widget>[
        (userEntity==null)?SizedBox.shrink(): Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
              (userEntity!.profile_picture==null||userEntity!.profile_picture.isEmpty)?
            CircleAvatar(
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                  "assets/images/user.png",
                ))),
              ),
              radius: 48.0,
            ) :CachedNetworkImage(
                                  imageBuilder: (context, imageProvider) => Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(48)),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  progressIndicatorBuilder: (context, url, progress) => Center(
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                    ),
                                  ),
                                  imageUrl:

                                  (userEntity!.profile_picture==null||userEntity!.profile_picture.isEmpty)?"https://technosquareusa.com/wp-content/uploads/2020/05/logo-1.png":"${ApiConstants.baseUserProfile}${userEntity!.profile_picture}",
                                )
            ,
            SizedBox(
              height: 10,
            ),
            Text(
              "${userEntity!.name}",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              child: InkWell(
                onTap: () async{
                  var response = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return EditProfile();
                      }));

                  if (response == 1) {
                    getUserDetails();
                  }
                },child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                      Icon(
                      Icons.person_rounded,
                      color: Colors.grey,
                    ),
                        SizedBox(width: 10,),
                        Text(
                          "${AppLocalizations.of(context)?.edit_profile}",
                          textAlign: TextAlign.left,
                          style:
                          TextStyle(color: AppColor.black, fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              child: InkWell(
                onTap: () async{
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return ChangePassword();
                      }));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                      Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ), SizedBox(width: 10,),
                    Text(
                    "${AppLocalizations.of(context)?.change_password}",
                    style:
                    TextStyle(color: AppColor.black, fontSize: 16.sp),
                ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              child: InkWell(
                onTap: () async{
                  showGeneralDialog(
                      context: context,
                      pageBuilder: (BuildContext buildContext,
                          Animation animation,
                          Animation secondaryAnimation) {
                        return _buildDialog(context);
                      });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.login,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "${AppLocalizations.of(context)?.logout}",
                          style:
                          TextStyle(color: AppColor.black, fontSize: 16.sp),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
              color: AppColor.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                    color: Colors.blueGrey),
                child: Row(
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.dashboard,
                        color: Colors.white,
                      ),
                      label: Text(
                        "${AppLocalizations.of(context)?.pet_details}",
                        style: TextStyle(
                            color: AppColor.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () async{
                       var response=await Navigator.pushNamed(context, "/addPetScren");
                       if(response!=null&&response==1)
                         {
                           getMyPets();
                         }
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: (listPets.length<=0)?Center(
                child: Text("No Pets info available",style: TextStyle(fontSize: 20,color: Colors.black),),
              ):ListView.builder( itemBuilder: (ctx,index){
                PetModel petmodel=listPets[index];
                return   InkWell(
                  onTap: ()async{
                    var response=  await Navigator.push(context,MaterialPageRoute(builder: (ctx){
                      return AddPetScren(petmodel);
                    }));
print("Resposne $response");
                    if(response!=null&&response==1)
                    {
                      getMyPets();
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  (petmodel.pet_type=="cat")?Image.asset(
                                    "assets/images/cat.png",
                                    height: 20.h,
                                  ): Image.asset(
                                    "assets/images/dog.png",
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${petmodel.pet_name[0].toUpperCase()}${petmodel.pet_name.substring(1)}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text("${petmodel.pet_sex[0].toUpperCase()}${petmodel.pet_sex.substring(1)}",
                                          style: TextStyle(color: Colors.grey)),
                                      Text("${petmodel.pet_breed[0].toUpperCase()}${petmodel.pet_breed.substring(1)}",
                                          style: TextStyle(color: Colors.grey)),
                                      Text("${petmodel.pet_age}",
                                          style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            right: 10,
                            top: 5,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  color:  ((petmodel.pet_size)=="s")?Colors.blueGrey: (petmodel.pet_size)=="m"?Colors.pinkAccent:Colors.orange),
                              child: Center(
                                child: Text(
                                  (petmodel.pet_size)=="s"?"S": (petmodel.pet_size)=="m"?"M":"L",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },itemCount: listPets.length,shrinkWrap: true,
                primary: false,),
            )
          ],
        ),
        (isLoading)
            ? Center(
                child: LoadingCircle(
                  size: 72,
                ),
              )
            : SizedBox.shrink(),
      ])),
    );
  }

  Widget _buildDialog(context) {
    return AlertDialog(
        backgroundColor: Colors.white,
        shape: _defaultShape(),
        insetPadding: EdgeInsets.all(8),
        elevation: 10,
        titlePadding: const EdgeInsets.all(0.0),
        title: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "${AppLocalizations.of(context)?.realy_logout}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        contentPadding: EdgeInsets.all(8),
        content: buttonsRowDirection == 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _getRowButtons(context),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _getColButtons(context),
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


  _getRowButtons(context) {
    return [
      DialogButton(
        width: 120,
        child: Text(
          "${AppLocalizations.of(context)?.yes}",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () async {
          print("OnLogout Yes");

          UserLocalDataSource _userLocalDataSource=UserLocalDataSourceImpl();
          var user=await _userLocalDataSource.deleteUser();
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }));

        },
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        width: 120,
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ];
  }

  _getColButtons(context) {
    return [
      DialogButton(
        child: Text(
          "Continue",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ];
  }

  getUserDetails() async {
    setState(() {
      isLoading=true;
    });
    AuthDataSource datasource = getItInstance();
    Map<String, dynamic> params = Map();
    params['uid'] = ApiConstants.USER_ID;


    var apiresposne = await datasource.getUserDetails(params);
    if(apiresposne==null)
      {
        setState(() {
          isLoading=false;
        });
        return;
      }

    UserLocalDataSource _userLocalDataSource=UserLocalDataSourceImpl();
    _userLocalDataSource.saveUser((apiresposne.data));
    ApiConstants.USER_ID=apiresposne.data['id'].toString();
    ApiConstants.USER_Name=apiresposne.data['name'];
    if(apiresposne.data['profile_picture']!=null)
    ApiConstants.IMAGE=apiresposne.data['profile_picture'];

    UserEntity data=UserEntity.fromMap(apiresposne.data);
    if (data is UserEntity) {
      setState(() {
        userEntity = data;
        isLoading = false;
      });
    }
    setState(() {
      isLoading=true;
    });
    getMyPets();
  }

  getMyPets()async
  {
    setState(() {
      isLoading=true;
    });

    ApiClient api=getItInstance();
    Map<String,String>params=Map();
    params['uid']=ApiConstants.USER_ID;
    var response= await api.post(ApiConstants.get_my_pets,body: params,fakeData: false );
    ApiResponse apiResposne=ApiResponse.fromMap(response);

    //Fluttertoast.showToast(msg: apiResposne.msg);

    if(apiResposne.code=='5')
    {
   List<PetModel>listPetsdata=List.empty(growable: true);
     apiResposne.data.forEach((a) {
       listPetsdata.add(PetModel.fromJson(a));
     });
      /* var list=ServiceModel.parseList(apiResposne.data) as List<ServiceModel>;
      list.forEach((element) {
        if(element.service_type=="main")
          serviceList.add(element);
        else if(element.service_type=="ad_on")
          adonserviceList.add(element);
      });*/

      setState(() {
        isLoading=false;
        listPets.clear();
        listPets.addAll(listPetsdata);

      });


      return;
    }
    setState(() {
      isLoading=false;
    });
   /* Fluttertoast.showToast(msg: apiResposne.msg, toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.pink,
        textColor: Colors.white,
        fontSize: 16.0);*/
  }
}
