import 'package:flutter/material.dart';
import 'package:projects/utils/data.dart';
import 'package:projects/widget/avatar.dart';
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
            Expanded(flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 28,
                      color: Colors.grey,
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      onPressed: (){}),
                  Container(
                    alignment: Alignment.center,
                    width: 250,
                    child: Text(
                     widget.title.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Galano',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                  ),
                  SizedBox(width: 80,)
                ],
              ),
            ),
            Expanded(
               flex: 8,
               child: Container(
                  padding: const EdgeInsets.only(left: 10,right: 10),
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
                ),
             ),

          ],
        ),
      bottomNavigationBar: bottomSheet(),
    );
  }

  Widget bottomSheet(){
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade300,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        )
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [

              ],
            )
          ),

          //
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                )
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // leave button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                            primary: Colors.blueGrey.shade50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        child: Text(
                            '✌🏽 Leave Quietly',
                          style: TextStyle(fontSize: 15,color: Colors.deepPurple.shade300),
                        )
                    ),
                  ),

                  // reaction row
                  Row(
                    children: [
                      Avatar(
                          radius: 20,
                          backgroundColor: Colors.blueGrey.shade50,
                          child: Text(
                            '👋🏽'
                          )),
                      SizedBox(width: 10,),
                      Avatar(
                          radius: 20,
                          backgroundColor: Colors.blueGrey.shade400,
                          child: Image.asset(
                            'assets/images/yello.png'
                          ))
                    ],
                  )
                ],
              ),
            ),
          ))

        ],
      ),
    );
  }


}
