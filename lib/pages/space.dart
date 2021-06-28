import 'package:flutter/material.dart';
import 'package:projects/utils/data.dart';
import 'package:projects/widget/listenersTile.dart';

class Space extends StatefulWidget {
  const Space({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  _SpaceState createState() => _SpaceState();
}

class _SpaceState extends State<Space> {

  DataClass dataClass = DataClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 28,
                    color: Colors.grey,
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    onPressed: (){}),
                Text(
                  widget.title.toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'Galano',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
                SizedBox(width: 80,)
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 5 / 6.5,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 23),
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: dataClass.listeners.length,
                  itemBuilder: (BuildContext context, index){
                    return ListenerAvatar(
                        avatar: dataClass.listeners[index]['avatar'],
                        name: dataClass.listeners[index]['name'],
                        color: dataClass.listeners[index]['color'],
                        reaction: dataClass.listeners[index]['reaction'],
                        speaking: dataClass.listeners[index]['speaking'],
                        verified: dataClass.listeners[index]['verified'],
                    );
                  }),
            )
          ],
        ),
    );
  }
}
