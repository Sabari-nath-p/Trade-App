import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_sidebar.dart';
import '../../../core/widgets/responsive_layout.dart';

class AiAssistantScreen extends StatelessWidget {
  const AiAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: ResponsiveLayout(
        // Mobile: Just the Chat Area (History could be a drawer, simplified here)
        mobileBody: const _ChatArea(showHistory: false),
        // Desktop: Main Nav Sidebar + Chat History + Chat Area
        desktopBody: Row(
          children: [
            const CustomSidebar(), // Main App Navigation
            Container(
              width: 280.w, // Chat History Width
              decoration: const BoxDecoration(
                color: AppColors.backgroundDarker,
                border: Border(right: BorderSide(color: AppColors.borderDark)),
              ),
              child: const _ChatHistorySidebar(),
            ),
            Expanded(child: const _ChatArea(showHistory: true)),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// LEFT PANEL: CHAT HISTORY
// -----------------------------------------------------------------------------
class _ChatHistorySidebar extends StatelessWidget {
  const _ChatHistorySidebar();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // New Chat Button
        Padding(
          padding: EdgeInsets.all(16.w),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: AppColors.primary, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    "New Chat",
                    style: GoogleFonts.inter(
                      color: AppColors.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // History List
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHistoryGroup("Today"),
                _buildHistoryItem("Tesla Entry Analysis", isActive: true),
                _buildHistoryItem("Bitcoin Support Levels"),
                SizedBox(height: 24.h),
                _buildHistoryGroup("Yesterday"),
                _buildHistoryItem("Forex Strategy Review"),
                _buildHistoryItem("Gold vs Silver Correlation"),
                _buildHistoryItem("Risk Management Setup"),
                SizedBox(height: 24.h),
                _buildHistoryGroup("Previous 7 Days"),
                _buildHistoryItem("Weekly Portfolio Audit"),
              ],
            ),
          ),
        ),

        // User Profile / Settings stub at bottom of history
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.borderDark)),
          ),
          child: Row(
            children: [
              Icon(Icons.settings, color: AppColors.textMuted, size: 20.sp),
              SizedBox(width: 12.w),
              Text(
                "AI Settings",
                style: TextStyle(color: AppColors.textMuted, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryGroup(String label) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: AppColors.textSecondary,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String title, {bool isActive = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      decoration: BoxDecoration(
        color: isActive ? AppColors.surfaceDark : Colors.transparent,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            color: isActive ? Colors.white : AppColors.textMuted,
            fontSize: 14.sp,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
        trailing: isActive
            ? Icon(Icons.more_horiz, color: AppColors.textMuted, size: 16.sp)
            : null,
        onTap: () {},
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// RIGHT PANEL: CHAT AREA
// -----------------------------------------------------------------------------
class _ChatArea extends StatelessWidget {
  final bool showHistory;
  const _ChatArea({required this.showHistory});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chat Header
        Container(
          height: 64.h,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.borderDark)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "AI Trading Assistant",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceHighlight,
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: AppColors.borderDark),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Model: GPT-4 Turbo",
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.expand_more,
                          color: AppColors.textMuted,
                          size: 14.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.ios_share,
                    color: AppColors.textMuted,
                    size: 20.sp,
                  ),
                  SizedBox(width: 16.w),
                  Icon(
                    Icons.delete_outline,
                    color: AppColors.textMuted,
                    size: 20.sp,
                  ),
                ],
              ),
            ],
          ),
        ),

        // Messages List
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(24.w),
            children: [
              _buildDateDivider("Today, 10:23 AM"),
              _buildUserMessage(
                "Analyze my recent TSLA trade. I entered at \$210 and exited at \$205. Was this a good setup based on my strategy?",
              ),
              _buildAiMessage(
                "Based on your strategy rules defined in Settings:",
                bullets: [
                  "Trend Alignment: The daily trend was bullish, but you entered on a pullback that hadn't confirmed support yet.",
                  "Risk Management: Your stop loss was too tight for TSLA's volatility (ATR was \$4.50, you used \$2.00).",
                  "Execution: Exit was premature. Price rebounded to \$215 shortly after your stop was hit.",
                ],
                suggestion: "Check R:R Ratio",
              ),
              _buildUserMessage(
                "What should I have done differently regarding the stop loss?",
              ),
              _buildAiMessage(
                "You should have placed your stop loss below the recent swing low at \$208.50, giving the trade room to breathe. This would have aligned with a 1.5 ATR buffer.",
              ),
            ],
          ),
        ),

        // Input Area
        _buildInputArea(),
      ],
    );
  }

  Widget _buildDateDivider(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.borderDark)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              text,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
            ),
          ),
          Expanded(child: Divider(color: AppColors.borderDark)),
        ],
      ),
    );
  }

  Widget _buildUserMessage(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h, left: 60.w), // Indent from left
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(2.r),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: AppColors.backgroundDark, // Dark text on bright primary
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildAiMessage(
    String text, {
    List<String>? bullets,
    String? suggestion,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, Colors.blue],
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.auto_awesome, color: Colors.white, size: 18.sp),
          ),
          SizedBox(width: 12.w),

          // Content
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceHighlight,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2.r),
                      topRight: Radius.circular(12.r),
                      bottomLeft: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r),
                    ),
                    border: Border.all(color: AppColors.borderDark),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          height: 1.5,
                        ),
                      ),
                      if (bullets != null) ...[
                        SizedBox(height: 12.h),
                        ...bullets.map(
                          (b) => Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 6.h),
                                  child: CircleAvatar(
                                    radius: 2.r,
                                    backgroundColor: AppColors.textMuted,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    b,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14.sp,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (suggestion != null) ...[
                  SizedBox(height: 12.h),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceHighlight,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.borderDark),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: AppColors.primary,
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            suggestion,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 60.w), // Indent from right
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: const BoxDecoration(color: AppColors.backgroundDark),
      child: Column(
        children: [
          // Input Wrapper with Glow
          Stack(
            children: [
              // Glow Effect
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              // Input Field
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceHighlight,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderDark),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.add_photo_alternate,
                        color: AppColors.textMuted,
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: "Ask about your trading performance...",
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary.withOpacity(0.5),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_upward,
                          color: AppColors.backgroundDark,
                        ),
                        onPressed: () {},
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.all(8.w),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            "AI can make mistakes. Verify important trading information.",
            style: TextStyle(color: AppColors.textSecondary, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}
