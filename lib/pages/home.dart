import 'package:flutter/material.dart';
import 'package:projects/utils/size.dart';
import 'package:projects/widget/home_custom_appbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: fullWidth(context),
          height: fullHeigth(context),
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 25),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        CustomAppBar(),

                      ],
                    ),
              )),

              Expanded(
                flex: 4,
                  child: Container(

                  )),
            ],
          ),
        ),
      ),
    );
  }
}
