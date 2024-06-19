import 'package:flutter/material.dart';
import 'package:projects/utils/size.dart';

class CurrentTablet extends StatelessWidget {
  const CurrentTablet({
    required this.title,
    required this.speaking,
    required this.subtitle,
    required this.visitors,
    required this.onTap,
    super.key,
  });
  final String title;
  final String subtitle;
  final String visitors;
  final String speaking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth(context),
      height: fullHeigth(context) / 4.5,
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // title
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Galano',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              //subtitle
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Galano',
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      peopleAvatar('assets/images/yello.png'),
                      peopleAvatar('assets/images/boss.png'),
                      peopleAvatar('assets/images/Daco.png'),
                    ],
                  ),
                  Container(
                    height: 37,
                    width: 105,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blueGrey.shade50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 16,
                            ),
                            Text(
                              visitors,
                              style: const TextStyle(
                                fontFamily: 'Galano',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.mic,
                              color: Colors.black,
                              size: 16,
                            ),
                            Text(
                              speaking,
                              style: const TextStyle(
                                fontFamily: 'Galano',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget peopleAvatar(String image) {
    return Container(
      height: 36,
      width: 36,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Colors.orange,
      ),
      child: Image.asset(image),
    );
  }
}
