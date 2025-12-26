import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradeapp/core/constants/size_extensions.dart';
import 'package:tradeapp/core/routes/app_pages.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_header.dart';
import '../../../core/widgets/custom_sidebar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/responsive_layout.dart';

class TradeLogsScreen extends StatelessWidget {
  const TradeLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: ResponsiveLayout(
        mobileBody: const _TradeLogsContent(showSidebar: false),
        desktopBody: Row(
          children: [
            const CustomSidebar(),
            Expanded(child: const _TradeLogsContent(showSidebar: true)),
          ],
        ),
      ),
    );
  }
}

class _TradeLogsContent extends StatelessWidget {
  final bool showSidebar;

  const _TradeLogsContent({required this.showSidebar});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomHeader(title: "Trade Logs"),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                // Header & Actions
                _buildPageHeader(context),
                SizedBox(height: 24.h),

                // KPI Strip
                _buildKPIStrip(context),
                SizedBox(height: 24.h),

                // Toolbar (Search & Filters)
                _buildToolbar(context),
                SizedBox(height: 16.h),

                // Data Table
                _buildDataTable(context),

                // Pagination
                _buildPagination(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 1. PAGE HEADER
  // ---------------------------------------------------------------------------
  Widget _buildPageHeader(BuildContext context) {
    bool isDesktop = ResponsiveLayout.isDesktop(context);
    return Flex(
      direction: isDesktop ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trade Logs",
              style: GoogleFonts.inter(
                fontSize: 32.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Detailed historical record of your trading performance across all connected exchanges.",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        if (!isDesktop) SizedBox(height: 16.h),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.download,
                size: 18.sp,
                color: AppColors.textMuted,
              ),
              label: Text(
                "Export CSV",
                style: TextStyle(color: AppColors.textMuted),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.borderDark),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            PrimaryButton(
              text: "Add Manual Trade",
              icon: Icons.add,
              fullWidth: false,
              onPressed: () {
                Get.toNamed(Routes.ADD_TRADE);
              },
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 2. KPI STRIP
  // ---------------------------------------------------------------------------
  Widget _buildKPIStrip(BuildContext context) {
    int crossAxisCount = ResponsiveLayout.isDesktop(context)
        ? 4
        : (ResponsiveLayout.isTablet(context) ? 2 : 1);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate width dynamically
        double itemWidth =
            (constraints.maxWidth - (crossAxisCount - 1) * 16.w) /
            crossAxisCount;

        return Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          children: [
            SizedBox(
              width: itemWidth,
              child: _buildKPICard(
                "Total PnL",
                "+\$12,450",
                "+15%",
                Icons.payments,
                AppColors.success,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _buildKPICard(
                "Win Rate",
                "68%",
                "+2.5%",
                Icons.verified,
                AppColors.primary,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _buildKPICard(
                "Profit Factor",
                "2.4",
                "0.0%",
                Icons.scale,
                AppColors.textMuted,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _buildKPICard(
                "Avg R:R",
                "1:3.2",
                "+0.2%",
                Icons.trending_up,
                AppColors.success,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKPICard(
    String label,
    String value,
    String change,
    IconData icon,
    Color changeColor,
  ) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withOpacity(0.5),
        border: Border.all(color: AppColors.borderDark),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Icon(
              icon,
              color: AppColors.primary.withOpacity(0.1),
              size: 48.sp,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMuted,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: changeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      children: [
                        if (changeColor == AppColors.success)
                          Icon(
                            Icons.trending_up,
                            size: 14.sp,
                            color: changeColor,
                          ),
                        Text(
                          change,
                          style: TextStyle(
                            color: changeColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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

  // ---------------------------------------------------------------------------
  // 3. TOOLBAR
  // ---------------------------------------------------------------------------
  Widget _buildToolbar(BuildContext context) {
    bool isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderDark.withOpacity(0.5)),
      ),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        children: [
          // Search
          Container(
            width: isDesktop ? 300.w : double.infinity,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.borderDark.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.borderDark),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Icon(Icons.search, color: AppColors.textMuted, size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: "Search ticker (e.g. BTC)...",
                      hintStyle: TextStyle(color: AppColors.textMuted),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        bottom: 12.h,
                      ), // Adjust alignment
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          if (!isDesktop) SizedBox(height: 16.h),

          // Filters
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _buildDropdownFilter("Last 30 Days", Icons.calendar_today),
              _buildDropdownFilter("All Markets", Icons.expand_more),
              _buildDropdownFilter("Status: Closed", Icons.expand_more),
            ],
          ),

          if (isDesktop) const Spacer(),
          if (!isDesktop) SizedBox(height: 16.h),

          // Sort
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sort by: ",
                style: GoogleFonts.inter(
                  color: AppColors.textMuted,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Date Closed",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(Icons.arrow_downward, color: Colors.white, size: 16.sp),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter(String label, IconData icon) {
    return Container(
      height: 36.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.borderDark,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 6.w),
          Icon(icon, color: AppColors.textMuted, size: 18.sp),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. DATA TABLE
  // ---------------------------------------------------------------------------
  Widget _buildDataTable(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withOpacity(0.2),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 1000.w,
          ), // Ensure table doesn't shrink too much
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(
              AppColors.borderDark.withOpacity(0.3),
            ),
            dataRowColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.hovered))
                return AppColors.borderDark.withOpacity(0.3);
              return Colors.transparent;
            }),
            columnSpacing: 24.w,
            horizontalMargin: 24.w,
            columns: const [
              DataColumn(
                label: Text(
                  "Date & Time",
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  "Instrument",
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  "Side",
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  "Entry / Exit",
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                numeric: true,
              ),
              DataColumn(
                label: Text(
                  "Size",
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                numeric: true,
              ),
              DataColumn(
                label: Text(
                  "Net PnL",
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                numeric: true,
              ),
              DataColumn(
                label: Center(
                  child: Text(
                    "Status",
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              DataColumn(label: Text("")), // Actions
            ],
            rows: [
              _buildDataRow(
                date: "Oct 24, 2023",
                time: "14:32:05 EST",
                symbol: "BTC/USDT",
                market: "Crypto • Binance",
                iconColor: const Color(0xFFF7931A),
                side: "SHORT",
                entry: "34,500.00",
                exit: "34,050.00",
                size: "1.5 BTC",
                pnl: "+\$675.00",
                pnlPct: "+1.30%",
                pnlColor: AppColors.success,
                status: "Win",
                statusColor: AppColors.success,
              ),
              _buildDataRow(
                date: "Oct 23, 2023",
                time: "09:15:22 EST",
                symbol: "AAPL",
                market: "Stocks • IBKR",
                iconColor: Colors.black,
                side: "LONG",
                entry: "172.50",
                exit: "171.80",
                size: "200 Shares",
                pnl: "-\$140.00",
                pnlPct: "-0.41%",
                pnlColor: AppColors.danger,
                status: "Loss",
                statusColor: AppColors.danger,
              ),
              _buildDataRow(
                date: "Oct 23, 2023",
                time: "08:45:00 EST",
                symbol: "EUR/USD",
                market: "Forex • Oanda",
                iconColor: const Color(0xFF003399),
                side: "LONG",
                entry: "1.0540",
                exit: "1.0565",
                isLive: true,
                size: "1.0 Lot",
                pnl: "+\$250.00",
                pnlPct: "Open",
                pnlColor: AppColors.primary,
                status: "Open",
                statusColor: AppColors.primary,
              ),
              _buildDataRow(
                date: "Oct 22, 2023",
                time: "16:20:10 EST",
                symbol: "ETH/USDT",
                market: "Crypto • Bybit",
                iconColor: const Color(0xFF627EEA),
                side: "SHORT",
                entry: "1,780.00",
                exit: "1,780.00",
                size: "10 ETH",
                pnl: "\$0.00",
                pnlPct: "0.00%",
                pnlColor: AppColors.textMuted,
                status: "BE",
                statusColor: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow({
    required String date,
    required String time,
    required String symbol,
    required String market,
    required Color iconColor,
    required String side,
    required String entry,
    required String exit,
    bool isLive = false,
    required String size,
    required String pnl,
    required String pnlPct,
    required Color pnlColor,
    required String status,
    required Color statusColor,
  }) {
    Color sideColor = side == "LONG" ? AppColors.success : AppColors.danger;

    return DataRow(
      cells: [
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                time,
                style: TextStyle(color: AppColors.textMuted, fontSize: 10.sp),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  symbol.substring(0, 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    symbol,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    market,
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: sideColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  side == "LONG" ? Icons.trending_up : Icons.trending_down,
                  size: 14.sp,
                  color: sideColor,
                ),
                SizedBox(width: 4.w),
                Text(
                  side,
                  style: TextStyle(
                    color: sideColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "In: $entry",
                style: TextStyle(color: AppColors.textMuted, fontSize: 11.sp),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: isLive ? "Curr: " : "Out: ",
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11.sp,
                      ),
                    ),
                    TextSpan(
                      text: exit,
                      style: TextStyle(
                        color: isLive ? AppColors.primary : Colors.white,
                        fontSize: 11.sp,
                        fontWeight: isLive
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(size, style: const TextStyle(color: Colors.white))),
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                pnl,
                style: TextStyle(
                  color: pnlColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: pnlColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: Text(
                  pnlPct,
                  style: TextStyle(color: pnlColor, fontSize: 10.sp),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: statusColor.withOpacity(0.2)),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        DataCell(
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textMuted),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 5. PAGINATION
  // ---------------------------------------------------------------------------
  Widget _buildPagination(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.borderDark.withOpacity(0.2),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
        border: Border(
          top: BorderSide.none,
          left: BorderSide(color: AppColors.borderDark),
          right: BorderSide(color: AppColors.borderDark),
          bottom: BorderSide(color: AppColors.borderDark),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Showing 1 to 4 of 128 results",
            style: TextStyle(color: AppColors.textMuted, fontSize: 12.sp),
          ),
          Row(
            children: [
              _buildPaginationBtn(Icons.chevron_left, active: false),
              _buildPaginationNum("1", active: true),
              _buildPaginationNum("2"),
              _buildPaginationNum("3"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  "...",
                  style: TextStyle(color: AppColors.textMuted),
                ),
              ),
              _buildPaginationNum("8"),
              _buildPaginationBtn(Icons.chevron_right, active: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationBtn(IconData icon, {bool active = false}) {
    return Container(
      width: 32.w,
      height: 32.w,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderDark),
        borderRadius: BorderRadius.circular(4.r),
        color: active ? AppColors.borderDark : Colors.transparent,
      ),
      child: Icon(icon, color: AppColors.textMuted, size: 18.sp),
    );
  }

  Widget _buildPaginationNum(String num, {bool active = false}) {
    return Container(
      width: 32.w,
      height: 32.w,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: active ? AppColors.primary : AppColors.borderDark,
        ),
        borderRadius: BorderRadius.circular(4.r),
        color: active ? AppColors.primary : Colors.transparent,
      ),
      child: Text(
        num,
        style: TextStyle(
          color: active ? AppColors.backgroundDark : AppColors.textMuted,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
