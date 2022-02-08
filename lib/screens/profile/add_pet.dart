import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/data/pet_model.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/shared/app_colors.dart';
import 'package:pet_groom/shared/app_textfield.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_groom/shared/button_widget.dart';
import 'package:pet_groom/shared/header_text.dart';


class AddPetScren extends StatefulWidget {
 PetModel? petmodel;
  AddPetScren(this.petmodel);
  @override
  State<AddPetScren> createState() => _AddPetScrenState();
}

class _AddPetScrenState extends State<AddPetScren> {
  int type_selected = 0;
  int size_selected = 0;
  int type_selected_sex = 0;
  TextEditingController pet_name_c=TextEditingController();
  TextEditingController pet_age_c=TextEditingController();
  TextEditingController pet_breed_c=TextEditingController();


  String pet_name="";
  String pet_age="";
  String pet_sex="";
  String pet_breed="";
  bool isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.petmodel!=null)
      {
        pet_name_c.text=widget.petmodel!.pet_name;
        pet_age_c.text=widget.petmodel!.pet_age;

        pet_breed_c.text=widget.petmodel!.pet_breed;
        if(widget.petmodel!.pet_type=="cat")
          type_selected=0;
        else if(widget.petmodel!.pet_type=="dog")
          type_selected=1;

        if(widget.petmodel!.pet_sex=="m")
          type_selected_sex=0;
        else if(widget.petmodel!.pet_sex=="f")
          type_selected_sex=1;


        print("widget.petmodel!.pet_type ${widget.petmodel!.pet_type}");
        if(widget.petmodel!.pet_size=="s")
          size_selected=0;
        else if(widget.petmodel!.pet_size=="m")
          size_selected=1;
        else if(widget.petmodel!.pet_size=="l")
          size_selected=2;
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "${AppLocalizations.of(context)?.addpet}",
          style: TextStyle(color: AppColor.black),
        ),
        backgroundColor: AppColor.scaffoldColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: AppColor.pink),
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                  ),
                  child: Image.asset(
                    "assets/images/logo-small.png",
                    height: 80,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            AppTextFormField(
              controller: pet_name_c,
              hintText: "${AppLocalizations.of(context)?.pet_name}",
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 10,
            ),
            AppTextFormField(
              controller: pet_breed_c,
              hintText: "${AppLocalizations.of(context)?.pet_breed}",
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 10,
            ),
            AppTextFormField(
              controller: pet_age_c,
              hintText: "${AppLocalizations.of(context)?.pet_age}",
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
            ),SizedBox(
              height: 10,
            ),Text(
              "Choose Sex",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ChoiceChip(
                  label: Text('Male', style: TextStyle(fontSize: 18)),
                  selected: type_selected_sex == 0,
                  onSelected: (bool selected) {
                    setState(() {
                      type_selected_sex = 0;
                    });
                  },
                  selectedColor: Colors.orange,
                ),
                SizedBox(
                  width: 30,
                ),

                ChoiceChip(

                  label: Text('Female', style: TextStyle(fontSize: 18)),
                  selected: type_selected_sex == 1,
                  onSelected: (bool selected) {
                    setState(() {
                      type_selected_sex = 1;
                    });
                  },
                  selectedColor: Colors.orange,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "${AppLocalizations.of(context)?.pet_type}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ChoiceChip(
                  avatar: Image.asset("assets/images/cat.png",
                      matchTextDirection: false, width: 100.0),
                  label: Text('Cat', style: TextStyle(fontSize: 18)),
                  selected: type_selected == 0,
                  onSelected: (bool selected) {
                    setState(() {
                      type_selected = 0;
                    });
                  },
                  selectedColor: Colors.orange,
                ),
                SizedBox(
                  width: 30,
                ),
                ChoiceChip(
                  avatar: Image.asset("assets/images/dog.png",
                      matchTextDirection: false, width: 100.0),
                  label: Text('Dog', style: TextStyle(fontSize: 18)),
                  selected: type_selected == 1,
                  onSelected: (bool selected) {
                    setState(() {
                      type_selected = 1;
                    });
                  },
                  selectedColor: Colors.orange,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "${AppLocalizations.of(context)?.pet_size}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ChoiceChip(
                  label: Text('Small', style: TextStyle(fontSize: 18)),
                  selected: size_selected == 0,
                  onSelected: (bool selected) {
                    setState(() {
                      size_selected = 0;
                    });
                  },
                  selectedColor: Colors.orange,
                ),
                SizedBox(
                  width: 30,
                ),
                ChoiceChip(
                  label: Text(
                    'Medium',
                    style: TextStyle(fontSize: 18),
                  ),
                  selected: size_selected == 1,
                  onSelected: (bool selected) {
                    setState(() {
                      size_selected = 1;
                    });
                  },
                  selectedColor: Colors.orange,
                ),
                SizedBox(
                  width: 30,
                ),
                ChoiceChip(
                  label: Text('Large', style: TextStyle(fontSize: 18)),
                  selected: size_selected == 2,
                  onSelected: (bool selected) {
                    setState(() {
                      size_selected = 2;
                    });
                  },
                  selectedColor: Colors.orange,
                )
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 20,
            ),
            SizedBox(
              height: 40,
            ),
            (isLoading)?Center(child: CircularProgressIndicator(),):AppPrimaryButton(
              onPress: () async{
                pet_name=pet_name_c.text.trim();
                pet_age=pet_age_c.text.trim();
                pet_breed=pet_breed_c.text.trim();

                if(pet_name.isEmpty||pet_age.isEmpty||pet_breed.isEmpty)
                  {
                    Fluttertoast.showToast(
                        msg: "All Fields required",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColor.pink,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    return;
                  }
                Map<String,dynamic>params=Map();
                if(size_selected==0)
                  params['pet_size']="s";
               else if(size_selected==1)
                  params['pet_size']="m";
               else if(size_selected==2)
                  params['pet_size']="l";

                if(type_selected==0)
                  params['pet_type']="cat";
               else if(type_selected==1)
                  params['pet_type']="dog";


                if(type_selected_sex==0)
                  pet_sex="m";
               else if(type_selected_sex==1)
                  pet_sex="f";

                  params['pet_name']=pet_name;
                  params['pet_age']=pet_age;
                  params['pet_sex']=pet_sex;
                  params['pet_breed']=pet_breed;
                  if(widget.petmodel!=null)
                  params['id']=widget.petmodel!.id;
                  params['uid']=ApiConstants.USER_ID;

                  setState(() {
                    isLoading=true;
                  });
                  ApiClient _apiClient=getItInstance();
                  late var response;
                  if(widget.petmodel==null)
                 response= await _apiClient.post(ApiConstants.add_pet_info, body:params,fakeData: false,token: "") ;
                else response= await _apiClient.post(ApiConstants.update_pet_info, body:params,fakeData: false,token: "") ;
                ApiResponse resp=ApiResponse.fromMap(response);



                Fluttertoast.showToast(
                    msg: resp.msg,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColor.pink,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                if(resp.code=="24"||resp.code=="25")
                  Navigator.pop(context,1);
                else
                  {
                    setState(() {
                      isLoading=false;
                    });
                  }
                //Navigator.pop(context);
              },
              text: "${AppLocalizations.of(context)?.submit}",
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
