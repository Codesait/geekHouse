import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/data/local/data.dart';
import 'package:projects/main.dart';
import 'package:projects/presentations/components/current_talks.dart';
import 'package:projects/presentations/components/home_custom_appbar.dart';
import 'package:projects/presentations/components/tab_pill.dart';
import 'package:projects/presentations/components/up_coming_tablet.dart';
import 'package:projects/presentations/features/home/space.dart';
import 'package:projects/presentations/features/profile/viewmodel/profile_viewmodel.dart';
import 'package:projects/utils/mediaquery.dart';
import 'package:projects/utils/modal.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    /**
     ** Retrieving the user data from the
     ** authentication provider using Riverpod's `ref.watch` method.
     */
    Future.microtask(() {
      ref.read(profileViewmodelProvider.notifier).getUserProfile();
    });
    super.initState();
  }

  DataClass data = DataClass();
  double horizontalPad = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Container(
          width: fullWidth(context),
          height: fullHeight(context),
          padding: const EdgeInsets.only(top: 25),
          child: Skeletonizer(
            enabled: ref.watch(profileViewmodelProvider).isLoading,
            effect: const ShimmerEffect(),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPad),
                        child: const CustomAppBar(),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        height: 45,
                        padding: const EdgeInsets.only(bottom: 5),
                        width: fullWidth(context),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: data.tabData
                              .map(
                                (e) => TabPill(
                                  backgroundColor: e['color'] as Color,
                                  title: e['title'] as String,
                                  icon: e['icon'] as String,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    width: fullWidth(context),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      right: horizontalPad,
                      left: horizontalPad,
                      top: 15,
                    ),
                    child: _Events(
                      data: data,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Events extends StatelessWidget {
  const _Events({this.data});
  final DataClass? data;

  @override
  Widget build(BuildContext context) {
    final modal = Modal();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /**
           ** UPCOMING EVENTS
           */
          const Text(
            'Upcoming',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Galano',
            ),
          ),
          const SizedBox(height: 10),
          const UpComings(),

          /**
           ** HAPPENING NOW
           */
          const SizedBox(height: 15),
          const Text(
            'Happening now',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Galano',
            ),
          ),
          Column(
            children: data!.talks
                .map(
                  (e) => CurrentTablet(
                    title: e['title'] as String,
                    speaking: e['speaking'] as String,
                    subtitle: e['subTitle'] as String,
                    visitors: e['visitors'] as String,
                    onTap: () {
                      modal.modalSheet(
                        appNavigatorKey.currentContext!,
                        child: Space(
                          title: e['title'] as String,
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
