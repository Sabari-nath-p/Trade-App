import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class CustomHeader extends StatelessWidget {
  final String title;

  const CustomHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundDarker.withOpacity(0.9),
        border: const Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Menu Button (Mobile) & Title
          Row(
            children: [
              // Mobile Menu Button would go here conditionally
              Icon(Icons.analytics, color: AppColors.primary, size: 24.sp),
              SizedBox(width: 8.w),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.015,
                ),
              ),
            ],
          ),

          // Right: Search & Actions
          Row(
            children: [
              // Search Bar (Hidden on small mobile if strictly following Tailwind 'hidden md:flex')
              Container(
                width: 220.w,
                height: 36.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.borderDark),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: AppColors.textMuted, size: 20.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search symbol...",
                          hintStyle: GoogleFonts.inter(
                            color: AppColors.textMuted,
                            fontSize: 13.sp,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13.sp,
                        ),
                        cursorColor: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),

              // Notification Icon
              Stack(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDark,
                      border: Border.all(color: AppColors.borderDark),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: AppColors.textMuted,
                      size: 20.sp,
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8.w),
              // Help Icon
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  border: Border.all(color: AppColors.borderDark),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.help,
                  color: AppColors.textMuted,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
