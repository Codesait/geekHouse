import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:projects/commons/src/config.dart';
import 'package:projects/commons/src/screens.dart';
import 'package:projects/utils/mediaquery.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PersistentTabController _controller = PersistentTabController();

  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: const Home(),
          item: ItemConfig(
            icon: SizedBox.square(
              dimension: 20,
              child: SvgPicture.asset(
                'assets/images/home_icon.svg',
                colorFilter:
                    ColorFilter.mode(AppColors.kPrimary, BlendMode.srcIn),
              ),
            ),
            activeForegroundColor: Colors.deepOrange,
          ),
        ),
        PersistentTabConfig.noScreen(
          item: ItemConfig(
            icon: SizedBox.square(
              dimension: 35,
              child: SvgPicture.asset(
                'assets/images/add_icon.svg',
                colorFilter:
                    const ColorFilter.mode(Colors.orange, BlendMode.srcIn),
              ),
            ),
            activeForegroundColor: Colors.blueAccent,
          ),
          onPressed: (context) {},
        ),
        PersistentTabConfig(
          screen: SizedBox(
            height: fullHeight(context),
            width: fullWidth(context),
            child: const Center(
              child: Text('Messages'),
            ),
          ),
          item: ItemConfig(
            icon: SizedBox.square(
              dimension: 20,
              child: SvgPicture.asset(
                'assets/images/mail_icon.svg',
                colorFilter:
                    ColorFilter.mode(AppColors.kPrimary, BlendMode.srcIn),
              ),
            ),
            activeForegroundColor: Colors.deepOrange,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) => PersistentTabView(
        controller: _controller,
        tabs: _tabs(),
        navBarBuilder: (navBarConfig) => Style5BottomNavBar(
          navBarConfig: navBarConfig,
        ),
        // margin: settings.margin,
        // avoidBottomPadding: settings.avoidBottomPadding,
        // handleAndroidBackButtonPress: settings.handleAndroidBackButtonPress,
      );
}
