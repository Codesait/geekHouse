import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projects/providers/onboarding/onboard_controller.dart';
import 'package:projects/src/components.dart';
import 'package:projects/src/config.dart';
import 'package:projects/utils/mediaquery.dart';

class UserOnboarding extends ConsumerStatefulWidget {
  const UserOnboarding({super.key});

  @override
  UserOnboardingState createState() => UserOnboardingState();
}

class UserOnboardingState extends ConsumerState<UserOnboarding> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(onboardingController);

    return Scaffold(
      backgroundColor: AppColors.kPrimary.withOpacity(.2),
      body: SafeArea(
        child: Container(
          width: fullWidth(context),
          height: fullHeigth(context),
          padding: const EdgeInsets.fromLTRB(25, 55, 25, 15),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: PageViewIndicator(
                    itemCount: 3,
                    currentPage: controller.page,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: CustomPageView(
                  pageController: _pageController,
                  onPageChange: controller.setPage,
                  height: fullHeigth(context) / 1.5,
                  pageSnapping: false,
                  pages: const [
                    _OnboardIntro(),
                    _ChooseUserName(),
                    _AddProfilePhoto(),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: DefaultButton(
                    text: 'Continue',
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    borderRadius: 100,
                    color: controller.page == 1
                        ? AppColors.kGreen
                        : AppColors.kPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardIntro extends StatelessWidget {
  const _OnboardIntro();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/onboarding.svg',
            height: fullHeigth(context) / 1.9,
          ),
          const TextView(
            text: 'We Want to Know You More Geek',
            fontSize: 35,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
          const TextView(
            text: 'Build your profile in three simple steps',
            fontSize: 15,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ChooseUserName extends StatelessWidget {
  const _ChooseUserName();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TextView(
              text: 'What do You Want us to Know You By ?',
              fontSize: 35,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            SvgPicture.asset(
              'assets/images/social.svg',
              height: 250,
            ),
            const SizedBox(
              width: 270,
              child: CustomInputField(
                hint: '@Sarah-123',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddProfilePhoto extends StatelessWidget {
  const _AddProfilePhoto();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextView(
              text: 'Show Us that Beautiful Smile',
              fontSize: 35,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            const TextView(
              text: 'Select a profile picture',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            const Gap(30),
            Avatar(
              avatarDimension: 300,
              editorDimension: 60,
              editImage: true,
              child: Image.asset('assets/images/yello.png'),
            ),
          ],
        ),
      ),
    );
  }
}
