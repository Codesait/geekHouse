import 'package:flutter/material.dart';
import 'package:projects/utils/mediaquery.dart';

class UpComings extends StatelessWidget {
  const UpComings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth(context),
      height: fullHeight(context) / 6.5,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.deepPurple.shade300,
      ),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
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
                      Text(
                        '10:00 - 20:00',
                        style: TextStyle(
                          fontFamily: 'Galano',
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Design talks and chill',
                        style: TextStyle(
                          fontFamily: 'Galano',
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
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
            ),
          ],
        ),
      ),
    );
  }
}
