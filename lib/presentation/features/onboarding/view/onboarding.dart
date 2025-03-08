import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/common/src/components.dart';
import 'package:projects/common/src/config.dart';
import 'package:projects/common/src/providers.dart';
import 'package:projects/common/src/screens.dart';
import 'package:projects/common/src/utils.dart';

class UserOnboarding extends ConsumerStatefulWidget {
  const UserOnboarding({super.key});

  @override
  UserOnboardingState createState() => UserOnboardingState();
}

class UserOnboardingState extends ConsumerState<UserOnboarding> {
  late PageController _pageController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(onboardingController);
    const transitionDuration = Duration(milliseconds: 500);
    const animationCurve = Curves.easeIn;

    return Scaffold(
      backgroundColor: AppColors.kPrimary.withValues(alpha: .2),
      body: SingleChildScrollView(
        child: Container(
          width: fullWidth(context),
          height: fullHeight(context),
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 15),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 35, bottom: 10),
                  child: PageViewIndicator(
                    itemCount: 4,
                    currentPage: controller.page,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: CustomPageView(
                  pageController: _pageController,
                  onPageChange: controller.setPage,
                  height: fullHeight(context) / 1.5,
                  pageSnapping: false,
                  pages: [
                    const _OnboardIntro(),
                    Form(
                      key: formKey,
                      child: const _ChooseUserName(),
                    ),
                    _AddProfilePhoto(
                      userName: controller.userName ?? '',
                    ),
                    InterestsScreen(
                      forOnboard: true,
                      goToNextAction: () async {
                        context
                          ..pop()
                          ..pushReplacementNamed(MainScreen.homePath);
                      },
                    ),
                  ],
                ),
              ),
              if (controller.page == 3)
                const SizedBox.shrink()
              else
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: DefaultButton(
                      text: 'Continue',
                      height: 50,
                      onPressed: () async {
                        await onSubmitOnboardData(
                          provider: controller,
                          transitionDuration: transitionDuration,
                          animationCurve: animationCurve,
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

  /// Advances the onboarding process based on the current page.
  ///
  /// Navigates to the next page if the current page is 0 or if the form
  /// on page 1 is valid. On page 2, it attempts to onboard the user
  /// by calling the `onboardUser` method from the profile view model
  /// provider. After onboarding, it closes all loading indicators and
  /// proceeds to the next page.
  ///
  /// [provider] is the controller managing the onboarding state.
  /// [transitionDuration] specifies the duration of the page transition.
  /// [animationCurve] defines the curve for the page transition animation.
  Future<void> onSubmitOnboardData({
    required OnboardController provider,
    required Duration transitionDuration,
    required Curve animationCurve,
  }) async {
    if (provider.page == 0 ||
        (provider.page == 1 && formKey.currentState!.validate())) {
      await _pageController.nextPage(
        duration: transitionDuration,
        curve: animationCurve,
      );
    } else if (provider.page == 2) {
      if (provider.imageUrl == null) {
        showToast(
          title: 'Missing Params',
          msg: 'To proceed, please select \na profile photo ',
          isWarningMessage: true,
        );
        return;
      }
      await ref
          .read(profileViewmodelProvider.notifier)
          .onboardUser(
            context,
            userName: provider.userName,
            imageUrl: provider.imageUrl,
          )
          .whenComplete(() {
        BotToast.closeAllLoading();
        _pageController.nextPage(
          duration: transitionDuration,
          curve: animationCurve,
        );
      });
    }
  }
}

class _OnboardIntro extends StatelessWidget {
  const _OnboardIntro();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/onboarding.svg',
              height: fullHeight(context) / 2,
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
      ),
    );
  }
}

class _ChooseUserName extends ConsumerStatefulWidget {
  const _ChooseUserName();
  // final TextEditingController userNameController;

  @override
  _ChooseUserNameState createState() => _ChooseUserNameState();
}

class _ChooseUserNameState extends ConsumerState<_ChooseUserName> {
  late TextEditingController _userNameController;
  @override
  void initState() {
    _userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: fullHeight(context),
      child: Column(
        children: [
          const TextView(
            text: 'What do You Want us to Know You By ?',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          CustomInputField(
            hint: 'Sarah-123',
            hideError: true,
            autofocus: true,
            prefixIcon: 'assets/images/@_email.svg',
            textAlign: TextAlign.center,
            controller: _userNameController,
            validator: (value) => Validators().validateUserName(value),
            onChanged: (v) {
              ref.read(onboardingController).userName = v;
            },
          ),
        ],
      ),
    );
  }
}

class _AddProfilePhoto extends ConsumerStatefulWidget {
  const _AddProfilePhoto({required this.userName});
  final String userName;

  @override
  _AddProfilePhotoState createState() => _AddProfilePhotoState();
}

class _AddProfilePhotoState extends ConsumerState<_AddProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileViewmodelProvider);
    final profileProvider = ref.read(profileViewmodelProvider.notifier);
    final onboardController = ref.read(onboardingController);

    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '@${widget.userName.toLowerCase()}',
                    style: const TextStyle(
                      color: AppColors.kGreen,
                    ),
                  ),
                  const TextSpan(
                    text: ' now show us what you look like',
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
            const Gap(20),
            const TextView(
              text: 'Choose a profile picture',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            Avatar(
              url: onboardController.imageUrl,
              avatarDimension: 280,
              editorDimension: 65,
              radius: 200,
              editImage: true,
              canDelete: false,
              imageUploadInProgress: state.isLoading,
              onEditImageTap: () async {
                await profileProvider.uploadProfileImageAndGetUrl().then((v) {
                  if (v != null) {
                    onboardController.imageUrl = v;
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
