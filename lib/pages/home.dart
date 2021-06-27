import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projects/utils/data.dart';
import 'package:projects/utils/size.dart';
import 'package:projects/widget/BottomNav.dart';
import 'package:projects/widget/currentTalks.dart';
import 'package:projects/widget/home_custom_appbar.dart';
import 'package:projects/widget/tab_pill.dart';
import 'package:projects/widget/upComingTablet.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DataClass data = DataClass();
  double horizontalPad = 15.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Container(
          width: fullWidth(context),
          height: fullHeigth(context),
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [

              Expanded(
                flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: horizontalPad),
                          child: CustomAppBar(),
                        ),
                        SizedBox(height: 25),
                        Container(
                          height: 45,
                          width: fullWidth(context),
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: data.tabData.map((e) =>
                                  TabPill(
                                    backgroundColor: e['color'],
                                    title: e['title'],
                                    icon: e['icon']
                                  )).toList(),
                            ),
                        ),

                      ],
                    ),
              )),

              Expanded(
                flex: 4,
                  child: Container(
                    width: fullWidth(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                    ),
                    padding:  EdgeInsets.symmetric(horizontal: horizontalPad),
                    child: SingleChildScrollView(child: body()),
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }


  Widget body(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        //upComings
        Text(
          'Upcoming',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontFamily: "Galano"
          ),

        ),
        SizedBox(height: 10),
        UpComings(),

        // happening now
        SizedBox(height: 15),
        Text(
          'Happening now',
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              fontFamily: "Galano"
          ),

        ),
        Column(
          children: data.talks.map((e) =>
              CurrentTablet(
                title: e['title'],
                speaking: e['speaking'],
                subtitle: e['subTitle'],
                visitors: e['visitors']
              )
          ).toList(),
        )

      ],
    );
  }
}
