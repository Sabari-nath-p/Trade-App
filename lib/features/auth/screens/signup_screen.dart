import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure flutter_svg is in pubspec
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/responsive_layout.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: ResponsiveLayout(
        // Mobile: Just the form
        mobileBody: const _SignupFormSection(),
        // Desktop: Form + Visual Hero Section
        desktopBody: Row(
          children: [
            const Expanded(
              flex: 5, // Approx 40-45% width
              child: _SignupFormSection(),
            ),
            Expanded(
              flex: 6, // Approx 55-60% width
              child: _HeroVisualSection(),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// LEFT SECTION: FORM
// -----------------------------------------------------------------------------
class _SignupFormSection extends StatelessWidget {
  const _SignupFormSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundDark,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header / Logo
              _buildHeader(),
              SizedBox(height: 40.h),

              // Title & Subtitle
              SizedBox(
                width: 400.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Trading Smarter",
                      style: GoogleFonts.inter(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Create your account to access advanced journaling and AI insights.",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              // Form Container
              SizedBox(
                width: 400.w,
                child: Column(
                  children: [
                    // Google Sign Up Button
                    _buildSocialButton(),

                    SizedBox(height: 24.h),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.borderDark,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            "OR",
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary.withOpacity(0.7),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.borderDark,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Inputs
                    const CustomTextField(
                      label: "Email Address",
                      placeholder: "name@example.com",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20.h),

                    const CustomTextField(
                      label: "Password",
                      placeholder: "Create a password",
                      isPassword: true,
                      suffixIcon: Icon(
                        Icons.visibility_outlined,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Password Strength Meter
                    Row(
                      children: List.generate(4, (index) {
                        return Expanded(
                          child: Container(
                            height: 4.h,
                            margin: EdgeInsets.only(
                              right: index == 3 ? 0 : 4.w,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors
                                  .borderDark, // Default inactive color
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: 20.h),

                    const CustomTextField(
                      label: "Confirm Password",
                      placeholder: "Re-enter your password",
                      isPassword: true,
                    ),

                    SizedBox(height: 32.h),

                    PrimaryButton(
                      text: "Create Account",
                      onPressed: () {
                        // TODO: Implement Auth Logic
                        Get.toNamed('/dashboard'); // Example route
                      },
                    ),

                    SizedBox(height: 24.h),

                    // Footer
                    Text(
                      "By clicking Create Account, you agree to our Terms of Service and Privacy Policy.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Already have account?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: GoogleFonts.inter(
                            color: AppColors.textSecondary,
                            fontSize: 14.sp,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Log in",
                            style: GoogleFonts.inter(
                              color: AppColors.primary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: 400.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Logo Icon (SVG Path replica from HTML)
              SvgPicture.string(
                '''<svg width="32" height="32" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M42.1739 20.1739L27.8261 5.82609C29.1366 7.13663 28.3989 10.1876 26.2002 13.7654C24.8538 15.9564 22.9595 18.3449 20.6522 20.6522C18.3449 22.9595 15.9564 24.8538 13.7654 26.2002C10.1876 28.3989 7.13663 29.1366 5.82609 27.8261L20.1739 42.1739C21.4845 43.4845 24.5355 42.7467 28.1133 40.548C30.3042 39.2016 32.6927 37.3073 35 35C37.3073 32.6927 39.2016 30.3042 40.548 28.1133C42.7467 24.5355 43.4845 21.4845 42.1739 20.1739Z" fill="#2BCDEE"/>
                </svg>''',
                height: 32.h,
                width: 32.w,
              ),
              SizedBox(width: 12.w),
              Text(
                "TradingAI",
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          // Hidden on desktop in original HTML, shown here for structure
        ],
      ),
    );
  }

  Widget _buildSocialButton() {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Google Icon
              SvgPicture.string(
                '''<svg width="20" height="20" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
                <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                </svg>''',
              ),
              SizedBox(width: 12.w),
              Text(
                "Sign up with Google",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// RIGHT SECTION: HERO VISUALS (DESKTOP ONLY)
// -----------------------------------------------------------------------------
class _HeroVisualSection extends StatelessWidget {
  const _HeroVisualSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceDark,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Background Gradient / Abstract Elements
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.surfaceDark, AppColors.backgroundDark],
              ),
            ),
          ),
          // Orbs
          Positioned(
            top: 150.h,
            right: 150.w,
            child: Container(
              width: 380.w,
              height: 380.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          // Grid Pattern Overlay (Simulated with CustomPaint or simplified Container)
          // For simplicity/performance in this code block, using a subtle overlay color.

          // 2. Main Visual Card
          Padding(
            padding: EdgeInsets.all(40.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Align hero content left or center
              children: [
                _buildAnalysisCard(),
                SizedBox(height: 48.h),
                _buildTestimonial(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisCard() {
    return Container(
      width: 400.w,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(
          0xFF132427,
        ).withOpacity(0.8), // Dark transparent card
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderDark),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.auto_graph,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AI Market Analysis",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Real-time signal processing active",
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Progress Bar
          Container(
            height: 8.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.borderDark.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.94, // 94% confidence
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Confidence Score",
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                "94.2%",
                style: GoogleFonts.jetBrainsMono(
                  // Monospace for numbers
                  color: AppColors.primary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Mini Chart Visual (Replicating the DIV bars from HTML)
          SizedBox(
            height: 96.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _chartBar(0.4, AppColors.borderDark.withOpacity(0.4)),
                _chartBar(0.6, AppColors.borderDark.withOpacity(0.4)),
                _chartBar(0.3, AppColors.borderDark.withOpacity(0.4)),
                _chartBar(0.5, AppColors.primary.withOpacity(0.4)),
                _chartBar(0.75, AppColors.primary.withOpacity(0.7)),
                _chartBar(0.9, AppColors.primary, glow: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chartBar(double heightFactor, Color color, {bool glow = false}) {
    return Container(
      width: 50.w, // Approx w-1/6
      height: 96.h * heightFactor,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.vertical(top: Radius.circular(2.r)),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.5),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );
  }

  Widget _buildTestimonial() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '"The journaling features alone have improved my win rate by 15% in just two months."',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.borderDark,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                "JD",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jonathan D.",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Professional Forex Trader",
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
