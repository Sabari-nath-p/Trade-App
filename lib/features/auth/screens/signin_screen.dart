import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradeapp/core/constants/size_extensions.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/responsive_layout.dart';
import '../../../core/routes/app_pages.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: ResponsiveLayout(
        // Mobile: Single column centered form
        mobileBody: const _SignInFormSection(),
        // Desktop: Split layout (Visual Left, Form Right)
        desktopBody: Row(
          children: [
            Expanded(
              flex: 1, // 50% width as per HTML "lg:w-1/2"
              child: const _HeroVisualSection(),
            ),
            const Expanded(
              flex: 1, // 50% width
              child: _SignInFormSection(),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// RIGHT SECTION: LOGIN FORM
// -----------------------------------------------------------------------------
class _SignInFormSection extends StatelessWidget {
  const _SignInFormSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundDark,
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400.w), // lg:w-96
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mobile Logo (Hidden on desktop in visual match, but useful for context)
              if (!ResponsiveLayout.isDesktop(context)) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.candlestick_chart,
                      color: AppColors.primary,
                      size: 32.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "TradeJournal AI",
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
              ],

              // Heading
              Text(
                "Welcome Back",
                style: GoogleFonts.inter(
                  fontSize: 30.sp, // ~ text-3xl
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
                textAlign: ResponsiveLayout.isDesktop(context)
                    ? TextAlign.left
                    : TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                "Access your intelligent trading dashboard.",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.textSecondary,
                ),
                textAlign: ResponsiveLayout.isDesktop(context)
                    ? TextAlign.left
                    : TextAlign.center,
              ),
              SizedBox(height: 32.h),

              // Google Sign In Button
              _buildSocialButton(),

              SizedBox(height: 32.h),

              // Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(color: AppColors.borderDark, thickness: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "Or continue with",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: AppColors.borderDark, thickness: 1),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              // Email Field
              _buildLabel("Email Address"),
              SizedBox(height: 8.h),
              _buildInputField(
                hint: "trader@example.com",
                icon: Icons.mail_outline,
              ),
              SizedBox(height: 24.h),

              // Password Field
              _buildLabel("Password"),
              SizedBox(height: 8.h),
              _buildInputField(
                hint: "••••••••",
                icon: Icons.lock_outline,
                isPassword: true,
              ),

              SizedBox(height: 24.h),

              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 24.h,
                        width: 24.h,
                        child: Checkbox(
                          value: false,
                          onChanged: (v) {},
                          activeColor: AppColors.primary,
                          checkColor: AppColors.backgroundDark,
                          side: BorderSide(color: AppColors.borderDark),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Remember me",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              // Login Button
              PrimaryButton(
                text: "Log In",
                onPressed: () {
                  Get.offAllNamed(Routes.DASHBOARD);
                },
              ),

              SizedBox(height: 32.h),

              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.SIGNUP),
                    child: Text(
                      "Sign up for free",
                      style: TextStyle(
                        color: Colors
                            .white, // Matches HTML "text-white" hover:primary
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildInputField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.borderDark,
        ), // Matches ring-border-dark
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
          prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20.sp),
          suffixIcon: isPassword
              ? Icon(
                  Icons.visibility_outlined,
                  color: AppColors.textSecondary,
                  size: 20.sp,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
          isDense: true,
        ),
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
          hoverColor: const Color(0xFF203a3f), // Matches hover:bg-[#203a3f]
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Google Icon SVG
              SvgPicture.string(
                '''<svg width="20" height="20" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path d="M12.0003 20.45c4.656 0 8.556-3.213 9.972-7.65H12.0003v-3.825h13.929c.141.675.213 1.383.213 2.138 0 7.275-5.043 12.938-12.141 12.938-6.99 0-12.651-5.663-12.651-12.65 0-6.988 5.661-12.65 12.651-12.65 3.393 0 6.453 1.244 8.835 3.488l-3.684 3.681c-1.353-1.294-3.159-2.069-5.151-2.069-4.269 0-7.854 2.944-9.156 6.863l-0.006 0.044-3.818 0.294-0.266-0.038c-1.365-2.706-2.127-5.781-2.127-9.094C1.3473 6.69 6.1143 1.925 12.0003 1.925c3.279 0 6.24 1.325 8.355 3.469l4.524-4.525C21.7533 -1.9 17.1543 -3.575 12.0003 -3.575 3.3993 -3.575 -3.5757 3.397 -3.5757 12s6.975 15.575 15.576 15.575z" fill="white" transform="translate(3.5757 3.575) scale(0.72)"></path>
                </svg>''',
              ),
              SizedBox(width: 12.w),
              Text(
                "Sign in with Google",
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
// LEFT SECTION: HERO VISUAL (Visual/Marketing)
// -----------------------------------------------------------------------------
class _HeroVisualSection extends StatelessWidget {
  const _HeroVisualSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceDark,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Image Placeholder with Overlays
          // Since we can't load the exact URL, we simulate the "Abstract dark financial data" look
          // using a gradient and opacity as described in HTML.
          Container(
            decoration: const BoxDecoration(
              color: AppColors.surfaceDark,
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1642543492481-44e81e3914a7?q=80&w=2070&auto=format&fit=crop",
                ), // Placeholder for abstract chart
                fit: BoxFit.cover,
                opacity: 0.4, // mix-blend-overlay simulation
              ),
            ),
          ),
          // Gradients
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.backgroundDark,
                  AppColors.backgroundDark.withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // 2. Content Overlay
          Padding(
            padding: EdgeInsets.all(48.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Brand
                Row(
                  children: [
                    Icon(
                      Icons.candlestick_chart,
                      color: AppColors.primary,
                      size: 32.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "TradeJournal AI",
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),

                // Testimonial
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "“The AI analysis has completely transformed my risk management strategy. I can finally see the patterns in my trading behavior.”",
                      style: GoogleFonts.inter(
                        fontSize: 24.sp, // text-xl / leading-8
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        // Avatar
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.borderDark),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://randomuser.me/api/portraits/men/32.jpg",
                              ), // Placeholder
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alex Chen",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              "Professional Forex Trader",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
