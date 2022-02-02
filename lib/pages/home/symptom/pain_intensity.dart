import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';


class PainIntensity extends StatefulWidget {
  @override
  _PainIntensityState createState() => _PainIntensityState();
}

class _PainIntensityState extends State<PainIntensity> {
  double headPain = 6;
  double chestPain = 6;
  double abdomenPain = 6;
  double armsPain = 6;
  double handsPain = 6;
  double backPain = 6;
  double legsPain = 6;
  double feetPain = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header("How is your pain now?", context, true, true, false, true),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 26),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 35),
                    child: Text(
                      "Tell us how much pain you have right now",
                      style: AppCss.raven12meduim,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  sliderCard(context,170,320,"Head","No pain at all (0)","So much pain (10)"
                  ,headPain,(newvalue){
                          setState(() {
                            headPain=newvalue;
                          });
                  }),
                   Padding(
                    padding: EdgeInsets.only(top:10),
                    child: sliderCard(context,170,320,"Chest","No pain at all (0)","So much pain (10)"
                    ,chestPain,(newvalue){
                            setState(() {
                              chestPain=newvalue;
                            });
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:10),
                    child: sliderCard(context,170,320,"Abdomen","No pain at all (0)","So much pain (10)"
                    ,abdomenPain,(newvalue){
                            setState(() {
                              abdomenPain=newvalue;
                            });
                    }),
                  ),Padding(
                    padding: EdgeInsets.only(top:10),
                    child: sliderCard(context,170,320,"Arms","No pain at all (0)","So much pain (10)"
                    ,armsPain,(newvalue){
                            setState(() {
                              armsPain=newvalue;
                            });
                    }),
                  ),Padding(
                    padding: EdgeInsets.only(top:10),
                    child: sliderCard(context,170,320,"Hands","No pain at all (0)","So much pain (10)"
                    ,handsPain,(newvalue){
                            setState(() {
                              handsPain=newvalue;
                            });
                    }),
                  ),Padding(
                    padding: EdgeInsets.only(top:10),
                    child: sliderCard(context,170,320,"Back","No pain at all (0)","So much pain (10)"
                    ,backPain,(newvalue){
                            setState(() {
                              backPain=newvalue;
                            });
                    }),
                  ),Padding(
                    padding: EdgeInsets.only(top:10),
                    child: sliderCard(context,170,320,"Legs","No pain at all (0)","So much pain (10)"
                    ,legsPain,(newvalue){
                            setState(() {
                              legsPain=newvalue;
                            });
                    }),
                  ),Padding(
                    padding: EdgeInsets.only(top:10),
                    child: sliderCard(context,170,320,"Feet","No pain at all (0)","So much pain (10)"
                    ,feetPain,(newvalue){
                            setState(() {
                              feetPain=newvalue;
                            });
                    }),
                  ),
                  painDateTimeCard(170,320,"Add date and time"),
                  Padding(
                    padding: const EdgeInsets.only(top:31,bottom: 20),
                    child: button(true,320,54,"Save",AppCss.white18bold,AppColors.PINK,(){},false),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: footer(
          ishomepageactive = false,
          iseducationpageactive = false,
          isteampageactive = false,
          isnotificationpageactive=false,
          ismorepageactive = true,
          context)
    );
  }

  
}
