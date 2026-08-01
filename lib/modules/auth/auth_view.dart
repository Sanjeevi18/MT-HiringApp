import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import '../../shared/responsive_layout.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      // Reactive Floating Action Button for the Role step
      floatingActionButton: Obx(() {
        if (controller.currentStep.value == AuthStep.role) {
          return FloatingActionButton.extended(
            onPressed: controller.completeLogin,
            backgroundColor: Colors.blueAccent,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            label: const Text(
              'Select',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
          );
        }
        return const SizedBox.shrink();
      }),

      body: SafeArea(
        child: Center(
          child: ResponsiveLayout(
            mobile: _buildAuthContainer(context, isMobile: true),
            tablet: _buildAuthContainer(context, isMobile: false),
            desktop: _buildAuthContainer(context, isMobile: false),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthContainer(BuildContext context, {required bool isMobile}) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        width: isMobile ? double.infinity : 500,
        margin: EdgeInsets.all(isMobile ? 0 : 24.0),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 32.0 : 48.0,
          vertical: 48.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              isMobile ? BorderRadius.zero : BorderRadius.circular(24),
          boxShadow: isMobile
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  )
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dynamic Header Icon based on Step
            Obx(() {
              IconData currentIcon;
              switch (controller.currentStep.value) {
                case AuthStep.phone:
                  currentIcon = Icons.smartphone_rounded;
                  break;
                case AuthStep.otp:
                  currentIcon = Icons.security_rounded;
                  break;
                case AuthStep.role:
                  currentIcon = Icons.badge_outlined;
                  break;
              }

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Container(
                  key: ValueKey<AuthStep>(controller.currentStep.value),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(currentIcon, size: 64, color: Colors.blueAccent),
                ),
              );
            }),

            const SizedBox(height: 32),

            // Dynamic Header Text
            Obx(() {
              String title = '';
              switch (controller.currentStep.value) {
                case AuthStep.phone:
                  title = 'Welcome Back';
                  break;
                case AuthStep.otp:
                  title = 'Enter OTP';
                  break;
                case AuthStep.role:
                  title = 'Choose Profile';
                  break;
              }
              return Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    letterSpacing: -0.5),
              );
            }),

            const SizedBox(height: 8),

            // Dynamic Subtitle Text
            Obx(() {
              String subtitle = '';
              switch (controller.currentStep.value) {
                case AuthStep.phone:
                  subtitle = 'Enter your phone number to login or register.';
                  break;
                case AuthStep.otp:
                  subtitle =
                      'We sent a 4-digit code to ${controller.phoneController.text}';
                  break;
                case AuthStep.role:
                  subtitle = 'How would you like to use the platform today?';
                  break;
              }
              return Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15, color: Colors.black.withValues(alpha: 0.5)),
              );
            }),

            const SizedBox(height: 48),

            // Animated Form Swapper
            Obx(() {
              Widget currentWidget;
              switch (controller.currentStep.value) {
                case AuthStep.phone:
                  currentWidget = _buildPhoneForm();
                  break;
                case AuthStep.otp:
                  currentWidget = _buildOtpForm();
                  break;
                case AuthStep.role:
                  currentWidget = _buildRoleSelectionForm();
                  break;
              }

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0.05, 0), end: Offset.zero)
                          .animate(animation),
                      child: child,
                    ),
                  );
                },
                child: KeyedSubtree(
                  key: ValueKey<AuthStep>(controller.currentStep.value),
                  child: currentWidget,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // --- UI Step 1: Phone Input ---
  Widget _buildPhoneForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'Phone Number',
            hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.3)),
            prefixIcon: Icon(Icons.phone_android_rounded,
                color: Colors.black.withValues(alpha: 0.4)),
            filled: true,
            fillColor: Colors.grey.withValues(alpha: 0.06),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: Colors.blueAccent, width: 1.5)),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            onPressed:
                controller.isLoading.value ? null : controller.requestOtp,
            child: controller.isLoading.value
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.5, color: Colors.white))
                : const Text('Send OTP',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5)),
          ),
        ),
      ],
    );
  }

  // --- UI Step 2: OTP Verification ---
  Widget _buildOtpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller.otpController,
          keyboardType: TextInputType.number,
          maxLength: 4,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 32,
              letterSpacing: 24.0,
              fontWeight: FontWeight.w800,
              color: Colors.blueAccent),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            counterText: '',
            hintText: '----',
            hintStyle: TextStyle(
                fontSize: 32,
                letterSpacing: 24.0,
                color: Colors.blueAccent.withValues(alpha: 0.3)),
            filled: true,
            fillColor: Colors.blueAccent.withValues(alpha: 0.05),
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: Colors.blueAccent, width: 2)),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: controller.isLoading.value ? null : controller.verifyOtp,
            child: controller.isLoading.value
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.5, color: Colors.white))
                : const Text('Verify',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5)),
          ),
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed:
              controller.isLoading.value ? null : controller.resetToPhoneInput,
          child: Text('Edit Phone Number',
              style: TextStyle(
                  color: Colors.blueAccent.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  // --- UI Step 3: Role Selection ---
  Widget _buildRoleSelectionForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() => Column(
              children: controller.availableRoles.map((role) {
                bool isSelected = controller.selectedRole.value == role;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: InkWell(
                    onTap: () => controller.selectedRole.value = role,
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 24),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blueAccent.withValues(alpha: 0.05)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? Colors.blueAccent
                              : Colors.grey.withValues(alpha: 0.2),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            role,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: isSelected
                                  ? Colors.blueAccent
                                  : Colors.black87,
                            ),
                          ),
                          if (isSelected)
                            const Icon(Icons.check_circle_rounded,
                                color: Colors.blueAccent),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
        const SizedBox(height: 80),
      ],
    );
  }
}
