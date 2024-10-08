import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projects/config/app_colors.dart';
import 'package:projects/providers/onboarding/onboard_controller.dart';
import 'package:projects/providers/profile/profile_viewmodel.dart';
import 'package:projects/src/components.dart';
import 'package:projects/src/config.dart';
import 'package:projects/src/utils.dart';
import 'package:projects/utils/mediaquery.dart';

class UserOnboarding extends ConsumerStatefulWidget {
  const UserOnboarding({super.key});

  @override
  UserOnboardingState createState() => UserOnboardingState();
}

class UserOnboardingState extends ConsumerState<UserOnboarding> {
  late PageController _pageController;
  late TextEditingController _userNameController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _pageController = PageController();
    _userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(onboardingController);
    const transitionDuration = Duration(milliseconds: 500);
    const animationCurve = Curves.easeIn;

    return Scaffold(
      backgroundColor: AppColors.kPrimary.withOpacity(.2),
      body: StatefulBuilder(
        builder: (context, state) {
          return SafeArea(
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
                      pages: [
                        const _OnboardIntro(),
                        Form(
                          key: formKey,
                          child: _ChooseUserName(
                            userNameController: _userNameController,
                          ),
                        ),
                        _AddProfilePhoto(
                          userName: controller.userName ?? '',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: DefaultButton(
                        text: 'Continue',
                        onPressed: () async {
                          if (controller.page == 0) {
                            await _pageController.nextPage(
                              duration: transitionDuration,
                              curve: animationCurve,
                            );
                          } else if (controller.page == 1) {
                            if (formKey.currentState!.validate()) {
                              await _pageController.nextPage(
                                duration: transitionDuration,
                                curve: animationCurve,
                              );
                              state(() {
                                controller.userName =
                                    _userNameController.text.trim();
                              });
                            }
                          } else {}
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
          );
        },
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

class _ChooseUserName extends StatefulWidget {
  const _ChooseUserName({required this.userNameController});
  final TextEditingController userNameController;

  @override
  State<_ChooseUserName> createState() => _ChooseUserNameState();
}

class _ChooseUserNameState extends State<_ChooseUserName> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TextView(
              text: 'What do You Want us to Know You By ?',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            SvgPicture.asset(
              'assets/images/social.svg',
              height: 250,
            ),
            SizedBox(
              width: 170,
              child: CustomInputField(
                hint: 'Sarah-123',
                hideError: true,
                prefixIcon: 'assets/images/@_email.svg',
                textAlign: TextAlign.center,
                controller: widget.userNameController,
                validator: (value) => Validators().validateUserName(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddProfilePhoto extends ConsumerWidget {
  const _AddProfilePhoto({required this.userName});
  final String userName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileProvider = ref.read(profileViewmodelProvider.notifier);

    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '@${userName.toLowerCase()}',
                    style: TextStyle(
                      color: AppColors.kPrimary,
                    ),
                  ),
                  const TextSpan(
                    text: ' now show us that beautiful smile',
                    style: TextStyle(
                      color: AppColors.kBlack,
                    ),
                  ),
                ],
              ),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.kPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            const TextView(
              text: 'Choose a profile picture',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            const Gap(30),
            Avatar(
              avatarDimension: 300,
              editorDimension: 60,
              editImage: true,
              canDelete: false,
              onEditImageTap: () {
                profileProvider.uploadProfileImageAndGetUrl().then((v) {
                  if(v != null){
                    
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
