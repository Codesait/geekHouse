import 'package:flutter/material.dart';
import 'package:projects/presentations/components/bottom_nav.dart';
import 'package:projects/presentations/components/current_talks.dart';
import 'package:projects/presentations/components/home_custom_appbar.dart';
import 'package:projects/presentations/components/modal.dart';
import 'package:projects/presentations/components/tab_pill.dart';
import 'package:projects/presentations/components/up_coming_tablet.dart';
import 'package:projects/presentations/screens/home/space.dart';
import 'package:projects/utils/data.dart';
import 'package:projects/utils/mediaquery.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DataClass data = DataClass();
  double horizontalPad = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Container(
          width: fullWidth(context),
          height: fullHeigth(context),
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPad),
                      child: const CustomAppBar(),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: 45,
                      padding: const EdgeInsets.only(bottom: 5),
                      width: fullWidth(context),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: data.tabData
                            .map(
                              (e) => TabPill(
                                backgroundColor: e['color'] as Color,
                                title: e['title'] as String,
                                icon: e['icon'] as String,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  width: fullWidth(context),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    right: horizontalPad,
                    left: horizontalPad,
                    top: 15,
                  ),
                  child: SingleChildScrollView(child: body()),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }

  Widget body() {
    final modal = Modal();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //upComings
        const Text(
          'Upcoming',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Galano',
          ),
        ),
        const SizedBox(height: 10),
        const UpComings(),

        // happening now
        const SizedBox(height: 15),
        const Text(
          'Happening now',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Galano',
          ),
        ),
        Column(
          children: data.talks
              .map(
                (e) => CurrentTablet(
                  title: e['title'] as String,
                  speaking: e['speaking'] as String,
                  subtitle: e['subTitle'] as String,
                  visitors: e['visitors'] as String,
                  onTap: () {
                    modal.modalSheet(
                      context,
                      child: Space(
                        title: e['title'] as String,
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
