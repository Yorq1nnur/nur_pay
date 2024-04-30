import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

// import 'package:nur_pay/data/local/storage_repository.dart';
import 'package:nur_pay/screens/on_boarding/pages/boarding_page_one.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:nur_pay/utils/images/app_images.dart';
import 'package:nur_pay/utils/sizedbox/get_sizedbox.dart';
import 'package:nur_pay/utils/styles/app_text_style.dart';
// import 'package:nur_pay/screens/routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({
    super.key,
  });

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();
  int activeIndex = 0;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.authContainerGradient,
        ),
        child: Column(
          children: [
            150.getH(),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (
                  index,
                ) {},
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  _pageImages.length,
                  (index) => BoardingPageSample(
                    imagePath: _pageImages[index],
                    title: _pageTitles[index],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                    onTap: () {
                      if (activeIndex == 0) {
                        activeIndex = activeIndex;
                      } else {
                        activeIndex--;
                        controller.animateToPage(
                          activeIndex,
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.linear,
                        );
                      }
                    },
                    child: Container(
                      width: 100.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Previous",
                          style: AppTextStyle.interBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                    onTap: () {
                      if (activeIndex == 2) {
                        activeIndex = activeIndex;

                        ///TODO HANDLE
// StorageRepository.setBool(
//   key: "is_new_user",
//   value: true,
// );
//   .then(
// (value) {
//   Navigator.pushReplacementNamed(
//     context,
//     RouteNames.loginRoute,
//   );
// },
// );
                      } else {
                        activeIndex += 1;
                        controller.animateToPage(
                          activeIndex,
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.linear,
                        );
                      }
                    },
                    child: Container(
                      width: 100.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Next",
                          style: AppTextStyle.interBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.getH()
          ],
        ),
      ),
    );
  }

  final List<String> _pageImages = [
    AppImages.firstOnboard,
    AppImages.secondOnboard,
    AppImages.thirdOnboard,
  ];

  final List<String> _pageTitles = [
    "THIS IS BANKING APP",
    "THIS IS PROJECT MANAGER IS YORQ1NNUR",
    "GOODBYE",
  ];
}
