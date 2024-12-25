import 'package:flutter/material.dart';

class StartRoomView extends StatefulWidget {
  const StartRoomView({super.key});

  @override
  State<StartRoomView> createState() => _StartRoomViewState();
}

class _StartRoomViewState extends State<StartRoomView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              'Create Audio Room',
              style: theme.textTheme.labelLarge!
                  .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
