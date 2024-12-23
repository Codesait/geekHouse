import 'package:flutter/material.dart';
import 'package:projects/data/local/data.dart';
import 'package:projects/presentation/components/avatar.dart';
import 'package:projects/presentation/components/listeners_tile.dart';

class Space extends StatefulWidget {
  const Space({required this.title, super.key});
  final String title;

  @override
  State<Space> createState() => _SpaceState();
}

class _SpaceState extends State<Space> {
  DataClass dataClass = DataClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  splashRadius: 23,
                  iconSize: 28,
                  color: Colors.grey,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  width: 250,
                  child: Text(
                    widget.title.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Galano',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 5 / 6.5,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 23,
                ),
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: dataClass.listeners.length,
                itemBuilder: (BuildContext context, index) {
                  return ListenerAvatar(
                    avatar: dataClass.listeners[index]['avatar'] as String,
                    name: dataClass.listeners[index]['name'] as String,
                    color: dataClass.listeners[index]['color'] as Color,
                    reaction: dataClass.listeners[index]['reaction'] as String,
                    speaking: dataClass.listeners[index]['speaking'] as String,
                    verified: dataClass.listeners[index]['verified'] as String,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomSheet(),
    );
  }

  // bottom sheet
  Widget bottomSheet() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade300,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        margin: const EdgeInsets.all(10),
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                        child: const Text(
                          'Type your thought here...',
                          style: TextStyle(
                            fontFamily: 'Galano',
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    const Avatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      avatarDimension: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),

          //
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // leave button
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.blueGrey.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          '✌🏽 Leave Quietly',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.deepPurple.shade300,
                          ),
                        ),
                      ),
                    ),

                    // reaction row
                    Row(
                      children: [
                        // Avatar(
                        //   radius: 20,
                        //   backgroundColor: Colors.blueGrey.shade50,
                        //   url: const Text('👋🏽'),
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        Avatar(
                          radius: 20,
                          backgroundColor: Colors.blueGrey.shade400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
