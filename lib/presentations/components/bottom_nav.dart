import 'package:flutter/material.dart';
import 'package:projects/utils/mediaquery.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: fullWidth(context),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            box(
              child: Icon(
                Icons.calendar_today_outlined,
                color: Colors.deepPurple.shade300,
              ),
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.add_circle_rounded),
                    Text(
                      'Start Room',
                    ),
                  ],
                ),
              ),
            ),
            box(
              child: Icon(
                Icons.person_outline_outlined,
                color: Colors.deepPurple.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget box({Widget? child}) {
    return Container(
      height: 45,
      width: 45,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.blueGrey.shade50,
      ),
      child: child,
    );
  }
}
