import 'package:flutter/material.dart';
import 'package:projects/widget/avatar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Good Morning,\nBernice',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: "Galano",
            ),
          ),
          Row(
            children: [
              IconButton(
                  splashRadius: 23,
                  icon: Icon(Icons.search_rounded),
                  onPressed: (){}),
              Avatar(
                radius: 20,
                backgroundColor: Colors.deepPurple.shade300,
                child: Image.asset("assets/images/yello.png"))
            ],
          )
        ],
      ),
    );
  }
}
