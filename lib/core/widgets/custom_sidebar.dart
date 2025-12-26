import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradeapp/core/routes/app_pages.dart';
import '../constants/app_colors.dart';

class CustomSidebar extends StatelessWidget {
  const CustomSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260.w, // Matches w-64 (~256px)
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.backgroundDarker,
        border: Border(
          right: BorderSide(color: AppColors.borderDark, width: 1),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Branding
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Row(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primary,
                        Color(0xFF1D4ED8),
                      ], // blue-600
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: const Icon(
                    Icons.show_chart,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TraderPro",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Pro Plan",
                      style: GoogleFonts.inter(
                        color: AppColors.primary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          _SidebarItem(
            icon: Icons.bar_chart,
            label: "Dashboard",
            isActive: Get.currentRoute == Routes.DASHBOARD,
            onTap: () => Get.offNamed(
              Routes.DASHBOARD,
            ), // offNamed prevents back stack buildup
          ),
          _SidebarItem(
            icon: Icons.book,
            label: "Journal",
            isActive:
                Get.currentRoute == Routes.TRADE_LOGS ||
                Get.currentRoute == Routes.ADD_TRADE,
            onTap: () => Get.offNamed(Routes.TRADE_LOGS),
          ),
          _SidebarItem(
            icon: Icons.psychology,
            label: "AI Assistant",
            isActive: Get.currentRoute == Routes.AI_ASSISTANT,
            onTap: () => Get.offNamed(Routes.AI_ASSISTANT),
          ),

          const Spacer(),

          // Bottom Actions
          _SidebarItem(icon: Icons.settings, label: "Settings", onTap: () {}),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 16.h),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.borderDark)),
            ),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.logout,
                size: 18,
                color: AppColors.textMuted,
              ),
              label: Text(
                "Sign Out",
                style: TextStyle(color: AppColors.textMuted),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.borderDark),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.accentTeal : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : AppColors.textMuted,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isActive ? Colors.white : AppColors.textMuted,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
