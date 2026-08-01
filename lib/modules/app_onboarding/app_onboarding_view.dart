import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_onboarding_controller.dart';
import '../../shared/responsive_layout.dart';

class AppOnboardingView extends GetView<AppOnboardingController> {
  const AppOnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: _buildCarousel(context, isMobile: true),
          tablet: _buildCarousel(context, isMobile: false),
          desktop: _buildCarousel(context, isMobile: false),
        ),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, {required bool isMobile}) {
    return Center(
      child: Container(
        width: isMobile ? double.infinity : 500,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // Top Bar with Skip Button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: controller.finishOnboarding,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Swipeable Pages
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.onboardingPages.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildPageContent(
                    icon: controller.onboardingPages[index]['icon'],
                    title: controller.onboardingPages[index]['title'],
                    description: controller.onboardingPages[index]
                        ['description'],
                  );
                },
              ),
            ),

            // Bottom Navigation (Dots and Button)
            Padding(
              padding: const EdgeInsets.only(bottom: 48.0, top: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Animated Dot Indicators
                  Row(
                    children: List.generate(
                      controller.onboardingPages.length,
                      (index) => Obx(() => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 8),
                            height: 8,
                            width:
                                controller.currentPage.value == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color: controller.currentPage.value == index
                                  ? Colors.blueAccent
                                  : Colors.grey.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )),
                    ),
                  ),

                  // Next / Get Started Button
                  Obx(() => FloatingActionButton.extended(
                        onPressed: controller.nextPage,
                        backgroundColor: Colors.blueAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        label: Text(
                          controller.currentPage.value ==
                                  controller.onboardingPages.length - 1
                              ? 'Get Started'
                              : 'Next',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        icon: Icon(
                          controller.currentPage.value ==
                                  controller.onboardingPages.length - 1
                              ? Icons.check_rounded
                              : Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent(
      {required IconData icon,
      required String title,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 100,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 64),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withValues(alpha: 0.5),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
