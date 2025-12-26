import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradeapp/core/constants/size_extensions.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_header.dart'; // Using the global header
import '../../../core/widgets/custom_sidebar.dart'; // Using the global sidebar
import '../../../core/widgets/responsive_layout.dart';
import '../../../core/routes/app_pages.dart'; // For navigation

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: ResponsiveLayout(
        // Mobile: Content only (Header + List)
        mobileBody: Column(
          children: [
            const CustomHeader(title: "Accounts"),
            Expanded(child: const _AccountsContent(showSidebar: false)),
          ],
        ),
        // Desktop: Global Sidebar + Content
        desktopBody: Row(
          children: [
            const CustomSidebar(), // Unified App Navigation
            Expanded(
              child: Column(
                children: [
                  const CustomHeader(
                    title: "Account Management",
                  ), // Unified Header
                  Expanded(child: const _AccountsContent(showSidebar: true)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// MAIN CONTENT
// -----------------------------------------------------------------------------
class _AccountsContent extends StatelessWidget {
  final bool showSidebar;
  const _AccountsContent({required this.showSidebar});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(showSidebar ? 32.w : 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumbs (Optional visual aid)
          if (showSidebar) ...[
            Row(
              children: [
                Text(
                  "App",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.borderDark,
                  size: 16.sp,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.borderDark,
                  size: 16.sp,
                ),
                Text(
                  "Trading Accounts",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
          ],

          // Title & Action Header
          Flex(
            direction: ResponsiveLayout.isMobile(context)
                ? Axis.vertical
                : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: ResponsiveLayout.isMobile(context)
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trading Portfolios",
                    style: GoogleFonts.inter(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: 600.w,
                    child: Text(
                      "Manage your connected exchanges, API keys, and track individual portfolio performance.",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16.sp,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              if (ResponsiveLayout.isMobile(context)) SizedBox(height: 16.h),

              // "Connect Exchange" Button
              InkWell(
                onTap: () {
                  // Navigate to Create Account Screen
                  // Note: Ensure this route is defined or use Get.to(() => const CreateAccountScreen());
                },
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  height: 44.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark,
                    border: Border.all(color: AppColors.borderDark),
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_link,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Connect Exchange",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 32.h),
          Divider(color: AppColors.borderDark),
          SizedBox(height: 32.h),

          // Profile Quick Edit Section
          Row(
            children: [
              Icon(Icons.badge, color: AppColors.primary, size: 24.sp),
              SizedBox(width: 8.w),
              Text(
                "Profile Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              border: Border.all(color: AppColors.borderDark),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Wrap(
              spacing: 24.w,
              runSpacing: 24.h,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                _buildProfileInput("Display Name", "Alex Sterling"),
                _buildProfileInput(
                  "Email Address",
                  "alex.sterling@tradeai.com",
                ),
                Container(
                  height: 48.h,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                    color: AppColors.borderDark,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Save Changes",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Accounts Grid Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.monitor, color: AppColors.primary, size: 24.sp),
                  SizedBox(width: 8.w),
                  Text(
                    "Connected Portfolios",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // View Toggles
              Row(
                children: [
                  _iconBtn(Icons.grid_view, active: true),
                  SizedBox(width: 8.w),
                  _iconBtn(Icons.list, active: false),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Responsive Grid of Account Cards
          LayoutBuilder(
            builder: (context, constraints) {
              // Responsive Column Count Logic
              int crossAxisCount = constraints.maxWidth > 1100
                  ? 3
                  : (constraints.maxWidth > 700 ? 2 : 1);
              // Calculate width considering spacing
              double itemWidth =
                  (constraints.maxWidth - (crossAxisCount - 1) * 20.w) /
                  crossAxisCount;

              return Wrap(
                spacing: 20.w,
                runSpacing: 20.h,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: _buildAccountCard(
                      title: "Binance Spot",
                      balance: "\$24,592.00",
                      pnl: "+12.5%",
                      winRate: "68.4%",
                      status: "Active",
                      iconColor: const Color(0xFFF3BA2F),
                      statusColor: AppColors.success,
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _buildAccountCard(
                      title: "MetaTrader 4",
                      balance: "\$4,200.50",
                      pnl: "-2.1%",
                      winRate: "45.2%",
                      status: "Active",
                      iconColor: Colors.white,
                      statusColor: AppColors.success,
                      isLoss: true,
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _buildAccountCard(
                      title: "Coinbase Pro",
                      balance: "\$850.00",
                      pnl: "0.0%",
                      winRate: "--",
                      status: "Paused",
                      iconColor: Colors.blue,
                      statusColor: AppColors.warning,
                      isNeutral: true,
                    ),
                  ),
                  // "Connect New" Card
                  SizedBox(width: itemWidth, child: _buildAddAccountCard()),
                ],
              );
            },
          ),

          SizedBox(height: 32.h),

          // Security Warning Footer
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info, color: AppColors.primary, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "Security Notice: Your API keys are encrypted using AES-256 standard. TradeAI never requests withdrawal permissions. Please ensure your connected exchange keys have \"Trade\" and \"View\" permissions only.",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER WIDGETS
  // ---------------------------------------------------------------------------

  Widget _buildProfileInput(String label, String value) {
    return SizedBox(
      width: 280.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundDark,
              border: Border.all(color: AppColors.borderDark),
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, {required bool active}) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: active ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        icon,
        color: active ? AppColors.primary : AppColors.textSecondary,
        size: 20.sp,
      ),
    );
  }

  Widget _buildAccountCard({
    required String title,
    required String balance,
    required String pnl,
    required String winRate,
    required String status,
    required Color iconColor,
    required Color statusColor,
    bool isLoss = false,
    bool isNeutral = false,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderDark),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: iconColor,
                    radius: 20.r,
                    child: Icon(
                      Icons.currency_bitcoin,
                      color: Colors.black,
                      size: 20.sp,
                    ),
                  ), // Generic icon fallback
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: statusColor.withOpacity(0.5),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Icon(Icons.more_horiz, color: AppColors.textSecondary),
            ],
          ),
          SizedBox(height: 24.h),

          // Balance Info
          Text(
            "Total Balance".toUpperCase(),
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            balance,
            style: GoogleFonts.jetBrainsMono(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 16.h),
          Divider(color: AppColors.borderDark),
          SizedBox(height: 16.h),

          // Performance Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MONTHLY P&L",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        isNeutral
                            ? Icons.remove
                            : (isLoss
                                  ? Icons.trending_down
                                  : Icons.trending_up),
                        color: isNeutral
                            ? AppColors.textSecondary
                            : (isLoss ? AppColors.danger : AppColors.success),
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        pnl,
                        style: TextStyle(
                          color: isNeutral
                              ? AppColors.textSecondary
                              : (isLoss ? AppColors.danger : AppColors.success),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WIN RATE",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    winRate,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddAccountCard() {
    return Container(
      height: 240
          .h, // Fixed height to roughly match the content-based height of other cards
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.borderDark,
          width: 2,
        ), // Dashed border simulated
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Logic to open "Create Account" modal or screen
          },
          borderRadius: BorderRadius.circular(12.r),
          hoverColor: AppColors.surfaceDark.withOpacity(0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.borderDark,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: AppColors.textSecondary,
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Connect New Account",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Integrate via API or Read-Only Access",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
