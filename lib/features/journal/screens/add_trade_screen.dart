import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_header.dart';
import '../../../core/widgets/custom_sidebar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/responsive_layout.dart';

class AddTradeScreen extends StatelessWidget {
  const AddTradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: ResponsiveLayout(
        mobileBody: const _AddTradeContent(showSidebar: false),
        desktopBody: Row(
          children: [
            const CustomSidebar(),
            Expanded(child: const _AddTradeContent(showSidebar: true)),
          ],
        ),
      ),
    );
  }
}

class _AddTradeContent extends StatelessWidget {
  final bool showSidebar;

  const _AddTradeContent({required this.showSidebar});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomHeader(title: "New Trade Entry"),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                // Top Actions (Breadcrumbs & Buttons)
                _buildTopActions(context),
                SizedBox(height: 24.h),

                // Main Grid Layout
                _buildMainLayout(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopActions(BuildContext context) {
    bool isMobile = ResponsiveLayout.isMobile(context);

    return Flex(
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Journal",
                  style: GoogleFonts.inter(
                    color: AppColors.textMuted,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    "/",
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Text(
                  "New Entry",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              "New Trade Entry",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (isMobile) SizedBox(height: 16.h),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.upload_file,
                size: 18.sp,
                color: AppColors.textMuted,
              ),
              label: Text(
                "Import",
                style: TextStyle(color: AppColors.textMuted),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.borderDark),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: AppColors.surfaceDark,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                "Reset",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            PrimaryButton(
              text: "Save Entry",
              fullWidth: false,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // MAIN GRID LAYOUT
  // ---------------------------------------------------------------------------
  Widget _buildMainLayout(BuildContext context) {
    // Desktop: 8 cols left, 4 cols right.
    // We achieve this using Flex or Row with Expanded ratios.
    if (ResponsiveLayout.isDesktop(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column (Form Inputs) - Flex 8
          Expanded(
            flex: 8,
            child: Column(
              children: [
                _buildContextSection(),
                SizedBox(height: 24.h),
                _buildExecutionSection(),
                SizedBox(height: 24.h),
                _buildOutcomeSection(),
                SizedBox(height: 24.h),
                _buildNotesSection(),
              ],
            ),
          ),
          SizedBox(width: 24.w),
          // Right Column (Sidebar Widgets) - Flex 4
          Expanded(
            flex: 4,
            child: Column(
              children: [
                _buildRiskAnalysisCard(),
                SizedBox(height: 24.h),
                _buildPsychologySection(),
                SizedBox(height: 24.h),
                _buildScreenshotSection(),
                SizedBox(height: 24.h),
                _buildProTipCard(),
              ],
            ),
          ),
        ],
      );
    }

    // Mobile/Tablet: Stacked
    return Column(
      children: [
        _buildContextSection(),
        SizedBox(height: 24.h),
        _buildExecutionSection(),
        SizedBox(height: 24.h),
        _buildOutcomeSection(),
        SizedBox(height: 24.h),
        _buildNotesSection(),
        SizedBox(height: 24.h),
        _buildRiskAnalysisCard(),
        SizedBox(height: 24.h),
        _buildPsychologySection(),
        SizedBox(height: 24.h),
        _buildScreenshotSection(),
        SizedBox(height: 24.h),
        _buildProTipCard(),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // FORM SECTIONS
  // ---------------------------------------------------------------------------
  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.h),
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24.sp),
          SizedBox(width: 8.w),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContextSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF16262A), // Specific dark surface
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        children: [
          _buildSectionHeader("Trade Context", Icons.candlestick_chart),
          Row(
            children: [
              // Date Time
              Expanded(
                child: _buildInputLabel(
                  "Date & Time",
                  child: _buildStyledInput(
                    initialValue: "2023-10-24T09:30",
                    type: TextInputType.datetime,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              // Instrument (Select + Input)
              Expanded(
                child: _buildInputLabel(
                  "Instrument",
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDark,
                      border: Border.all(color: AppColors.borderDark),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        // Fake Dropdown
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(color: AppColors.borderDark),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: "Crypto",
                              dropdownColor: AppColors.surfaceDark,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              items: ["Forex", "Crypto", "Stock"]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) {},
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            style: GoogleFonts.jetBrainsMono(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                            decoration: InputDecoration(
                              hintText: "e.g. BTC/USD",
                              hintStyle: TextStyle(color: AppColors.textMuted),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // Direction Toggle
          _buildInputLabel(
            "Direction",
            child: Row(
              children: [
                Expanded(
                  child: _buildToggleButton(
                    "Long / Buy",
                    Icons.trending_up,
                    isActive: true,
                    activeColor: const Color(0xFF1D9E74),
                  ), // Greenish
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildToggleButton(
                    "Short / Sell",
                    Icons.trending_down,
                    isActive: false,
                    activeColor: AppColors.danger,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExecutionSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF16262A),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        children: [
          _buildSectionHeader("Execution & Risk", Icons.tune),
          Wrap(
            spacing: 20.w,
            runSpacing: 20.h,
            children: [
              _buildSizedInput("Entry Price", prefix: "\$"),
              _buildSizedInput("Position Size", suffix: "LOTS"),
              _buildSizedInput(
                "Stop Loss",
                prefix: "\$",
                borderColor: AppColors.danger.withOpacity(0.5),
              ),
              _buildSizedInput(
                "Take Profit",
                prefix: "\$",
                borderColor: AppColors.success.withOpacity(0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOutcomeSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF16262A),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        children: [
          _buildSectionHeader("Trade Outcome", Icons.flag),
          Wrap(
            spacing: 20.w,
            runSpacing: 20.h,
            children: [
              // Result Dropdown
              SizedBox(
                width: 250.w, // Fixed width for wrap
                child: _buildInputLabel(
                  "Result",
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDark,
                      border: Border.all(color: AppColors.borderDark),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text(
                          "Select Outcome",
                          style: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: AppColors.surfaceDark,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(
                            value: "win",
                            child: Text(
                              "Win",
                              style: TextStyle(color: AppColors.success),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "loss",
                            child: Text(
                              "Loss",
                              style: TextStyle(color: AppColors.danger),
                            ),
                          ),
                        ],
                        onChanged: (v) {},
                      ),
                    ),
                  ),
                ),
              ),
              _buildSizedInput("Realized PnL", suffix: "USD"),
              _buildSizedInput("Fees & Swap", suffix: "USD"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF16262A),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.edit_note, color: AppColors.primary, size: 24.sp),
                  SizedBox(width: 8.w),
                  Text(
                    "Mistakes & Notes",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Toolbar Icons
              Row(
                children: [
                  _buildToolbarIcon(Icons.format_bold),
                  _buildToolbarIcon(Icons.format_italic),
                  _buildToolbarIcon(Icons.format_list_bulleted),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 120.h,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundDark,
              border: Border.all(color: AppColors.borderDark),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: TextField(
              maxLines: null,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText:
                    "Describe your thought process, mistakes made, and lessons learned...",
                hintStyle: TextStyle(color: AppColors.textMuted),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SIDEBAR WIDGETS
  // ---------------------------------------------------------------------------
  Widget _buildRiskAnalysisCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF193238), Color(0xFF16262A)],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "RISK ANALYSIS",
            style: GoogleFonts.inter(
              color: AppColors.textMuted,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 16.h),
          _buildRiskRow("Risk Amount", "\$0.00", Colors.white),
          SizedBox(height: 12.h),
          _buildRiskRow("Risk %", "0.0%", AppColors.textMuted),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reward to Risk",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  "1 : 3.5",
                  style: GoogleFonts.jetBrainsMono(
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(color: AppColors.borderDark),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Projected PnL",
                style: TextStyle(color: AppColors.textMuted, fontSize: 12.sp),
              ),
              Text(
                "+\$450.00",
                style: GoogleFonts.jetBrainsMono(
                  color: AppColors.primary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPsychologySection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF16262A),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: AppColors.primary, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                "Emotional State",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _buildEmotionChip("Calm", true),
              _buildEmotionChip("Anxious", false),
              _buildEmotionChip("Greedy", false),
              _buildEmotionChip("Fearful", false),
              _buildEmotionChip("FOMO", false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScreenshotSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF16262A),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.image, color: AppColors.primary, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    "Screenshots",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                "0/2",
                style: TextStyle(color: AppColors.textMuted, fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.borderDark,
              ), // dashed effect needs custom paint, sticking to solid for simplicity
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF16262A),
                  child: Icon(Icons.cloud_upload, color: AppColors.primary),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Click to upload",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "or drag and drop here",
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProTipCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF192F33),
        border: const Border(
          left: BorderSide(color: AppColors.primary, width: 4),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Pro Tip:\n",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            TextSpan(
              text:
                  "Always wait for the candle close before executing your entry to avoid fakeouts.",
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER WIDGETS
  // ---------------------------------------------------------------------------
  Widget _buildInputLabel(String label, {required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(
            color: AppColors.textMuted,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        child,
      ],
    );
  }

  Widget _buildStyledInput({String? initialValue, TextInputType? type}) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        border: Border.all(color: AppColors.borderDark),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: initialValue != null
            ? TextEditingController(text: initialValue)
            : null,
        keyboardType: type,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(
    String label,
    IconData icon, {
    required bool isActive,
    required Color activeColor,
  }) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: isActive ? activeColor : Colors.transparent,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.white : AppColors.textMuted,
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : AppColors.textMuted,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizedInput(
    String label, {
    String? prefix,
    String? suffix,
    Color? borderColor,
  }) {
    return SizedBox(
      width: 180.w, // Half width approx for desktop column
      child: _buildInputLabel(
        label,
        child: Container(
          height: 48.h,
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            border: Border.all(color: borderColor ?? AppColors.borderDark),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              if (prefix != null)
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Text(
                    prefix,
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                ),
              Expanded(
                child: TextField(
                  style: GoogleFonts.jetBrainsMono(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "0.00",
                    hintStyle: TextStyle(color: AppColors.textMuted),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 14.h,
                    ),
                  ),
                ),
              ),
              if (suffix != null)
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Text(
                    suffix,
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolbarIcon(IconData icon) {
    return Container(
      margin: EdgeInsets.only(left: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: Colors.transparent,
      ),
      child: Icon(icon, color: AppColors.textMuted, size: 18.sp),
    );
  }

  Widget _buildRiskRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
        Text(
          value,
          style: GoogleFonts.jetBrainsMono(
            color: color,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildEmotionChip(String label, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.borderDark,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.backgroundDark : AppColors.textMuted,
          fontSize: 12.sp,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
