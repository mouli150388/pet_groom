import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreens extends StatefulWidget{
  @override
  State<IntroScreens> createState() => _IntroScreensState();
}

class _IntroScreensState extends State<IntroScreens> {
  List<Slide> slides = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "",
        description: "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        pathImage: "assets/images/intro-one.jpg",
        backgroundColor:Colors.grey,
      ),
    );
    slides.add(
      new Slide(
        title: "",
        description: "Ye indulgence unreserved connection alteration appearance",
        pathImage: "assets/images/intro-two.jpg",
        backgroundColor: Colors.lightGreen,
      ),
    );
    slides.add(
      new Slide(
        title: "",
        heightImage: 500,
        widthImage: 300,
        description:
        "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "assets/images/intro-three.jpg",
        backgroundColor: Colors.greenAccent,
      ),
    );
  }

  void onDonePress() {
    // TODO: go to next screen
  }

  void onSkipPress() {
    // TODO: go to next screen
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
    );
  }
}
