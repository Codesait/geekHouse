import 'package:flutter/material.dart';
import 'package:projects/utils/size.dart';


class UpComings extends StatelessWidget {
  const UpComings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth(context),
      height: fullHeigth(context)/6.5,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepPurple.shade300
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VerticalDivider(
                    thickness: 3,
                    color: Colors.orange,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("10:00 - 20:00",
                        style: TextStyle(
                            fontFamily: 'Galano',
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ),
                      Text(
                        "Design talks and chill",
                        style:
                        TextStyle(
                            fontFamily: 'Galano',
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500

                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
