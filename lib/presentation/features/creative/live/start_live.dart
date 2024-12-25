import 'package:flutter/material.dart';

class StartLiveView extends StatefulWidget {
  const StartLiveView({super.key});

  @override
  State<StartLiveView> createState() => _StartLiveViewState();
}

class _StartLiveViewState extends State<StartLiveView> {
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
              'Get Ready',
              style: theme.textTheme.labelLarge!
                  .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
