import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_header.dart';
import '../../../core/widgets/custom_sidebar.dart';
import '../../../core/widgets/responsive_layout.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: ResponsiveLayout(
        mobileBody: const _DashboardContent(showSidebar: false),
        desktopBody: Row(
          children: [
            const CustomSidebar(),
            Expanded(child: const _DashboardContent(showSidebar: true)),
          ],
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final bool showSidebar;

  const _DashboardContent({required this.showSidebar});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomHeader(title: "Analytics Overview"),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Action Bar
                _buildActionBar(context),
                SizedBox(height: 24.h),

                // KPI Grid (Responsive)
                _buildKPIGrid(context),
                SizedBox(height: 24.h),

                // Open Trades Section
                _buildSectionHeader("Open Trades", badge: "3 Active"),
                SizedBox(height: 16.h),
                _buildOpenTradesGrid(context),
                SizedBox(height: 24.h),

                // Charts Section (Equity & Distribution)
                _buildChartsSection(context),
                SizedBox(height: 24.h),

                // Bottom Grid (Days & Table)
                _buildBottomGrid(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 1. TOP ACTION BAR
  // ---------------------------------------------------------------------------
  Widget _buildActionBar(BuildContext context) {
    // On Mobile, we stack; Desktop we row.
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Flex(
      direction: isDesktop ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Performance Analytics",
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "Real-time trading insights and account health",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        if (!isDesktop) SizedBox(height: 16.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            _buildFilterChip("Last 30 Days", Icons.calendar_today),
            _buildFilterChip("Main Margin", Icons.account_balance_wallet),
            _buildFilterChip("All Markets", Icons.candlestick_chart),
            Container(
              height: 36.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 15,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                "Generate Report",
                style: GoogleFonts.inter(
                  color: AppColors.backgroundDark,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    return Container(
      height: 36.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.accentTeal),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 18.sp),
          SizedBox(width: 8.w),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(Icons.expand_more, color: AppColors.textSecondary, size: 16.sp),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. KPI GRID
  // ---------------------------------------------------------------------------
  Widget _buildKPIGrid(BuildContext context) {
    // Grid count changes based on width
    int crossAxisCount = ResponsiveLayout.isDesktop(context)
        ? 4
        : (ResponsiveLayout.isTablet(context) ? 2 : 1);

    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth =
            (constraints.maxWidth - (crossAxisCount - 1) * 16.w) /
            crossAxisCount;
        // Fixed aspect ratio usually doesn't work well for variable text content,
        // but creating a Wrap or Row/Column structure is safer than GridView here.
        // Let's use a Wrap for responsiveness without GridView's strict aspect ratio issues.

        return Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          children: [
            SizedBox(
              width: itemWidth,
              child: _buildKPICard(
                "Total Balance",
                "\$124,592.00",
                "+5.2%",
                Icons.account_balance,
                AppColors.primary,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _buildKPICard(
                "Net PnL",
                "+\$12,400",
                "+12.4%",
                Icons.payments,
                AppColors.success,
                valueColor: AppColors.success,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _buildKPICard(
                "Profit Factor",
                "2.41",
                "Good",
                Icons.query_stats,
                AppColors.primary,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _buildKPICard(
                "Win Rate",
                "62%",
                "48 Trades",
                Icons.pie_chart,
                AppColors.textSecondary,
                isChart: true,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKPICard(
    String title,
    String value,
    String badge,
    IconData icon,
    Color accent, {
    Color? valueColor,
    bool isChart = false,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.accentTeal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      color: valueColor ?? Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.accentTeal.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: isChart
                    ? SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: CircularProgressIndicator(
                          value: 0.62,
                          color: AppColors.primary,
                          backgroundColor: AppColors.accentTeal,
                          strokeWidth: 3,
                        ),
                      )
                    : Icon(icon, color: accent, size: 24.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.inter(
                    color: AppColors.success,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                "vs last month",
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. OPEN TRADES
  // ---------------------------------------------------------------------------
  Widget _buildOpenTradesGrid(BuildContext context) {
    int crossAxisCount = ResponsiveLayout.isDesktop(context) ? 3 : 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth =
            (constraints.maxWidth - (crossAxisCount - 1) * 16.w) /
            crossAxisCount;
        return Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          children: [
            SizedBox(
              width: itemWidth,
              child: _buildTradeCard(
                "BTC/USDT",
                "Perpetual",
                "Long",
                "\$64,230.50",
                "\$65,102.20",
                "+\$871.70 (1.35%)",
                AppColors.success,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _buildTradeCard(
                "ETH/USDT",
                "Perpetual",
                "Short",
                "\$3,450.00",
                "\$3,458.20",
                "-\$82.00 (-0.23%)",
                AppColors.danger,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _buildTradeCard(
                "SOL/USDT",
                "Spot",
                "Long",
                "\$142.50",
                "\$148.10",
                "+\$560.00 (3.92%)",
                AppColors.success,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTradeCard(
    String pair,
    String type,
    String side,
    String entry,
    String current,
    String pnl,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark, // surface-darker
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.accentTeal),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.accentTeal,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      pair.substring(0, 1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pair,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        type,
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  side.toUpperCase(),
                  style: GoogleFonts.inter(
                    color: color,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Data Grid
          Row(
            children: [
              Expanded(
                child: _buildTradeDataCell("Entry Price", entry, Colors.white),
              ),
              Expanded(
                child: _buildTradeDataCell(
                  "Current",
                  current,
                  AppColors.primary,
                  alignRight: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(height: 1, color: AppColors.accentTeal.withOpacity(0.5)),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: _buildTradeDataCell(
                  "Unrealized PnL",
                  "",
                  Colors.transparent,
                ),
              ), // Label only
              Expanded(
                child: Text(
                  pnl,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                    color: color,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTradeDataCell(
    String label,
    String value,
    Color valueColor, {
    bool alignRight = false,
  }) {
    return Column(
      crossAxisAlignment: alignRight
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 12.sp,
          ),
        ),
        if (value.isNotEmpty)
          Text(
            value,
            style: GoogleFonts.inter(
              color: valueColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 4. CHARTS SECTION
  // ---------------------------------------------------------------------------
  Widget _buildChartsSection(BuildContext context) {
    bool isDesktop = ResponsiveLayout.isDesktop(context);

    return Flex(
      direction: isDesktop ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Equity Curve (Line Chart)
        Expanded(
          flex: 2,
          child: Container(
            height: 350.h,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.accentTeal),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Equity Curve",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Cumulative PnL over time",
                          style: GoogleFonts.inter(
                            color: AppColors.textSecondary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    // Toggle Buttons simplified
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundDark,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        " Line ",
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: AppColors.accentTeal,
                          strokeWidth: 1,
                          dashArray: [5, 5],
                        ),
                      ),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 20),
                            FlSpot(1, 40),
                            FlSpot(2, 35),
                            FlSpot(3, 60),
                            FlSpot(4, 55),
                            FlSpot(5, 80),
                            FlSpot(6, 95),
                          ],
                          isCurved: true,
                          color: AppColors.primary,
                          barWidth: 3,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: AppColors.chartGradient,
                          ),
                          dotData: FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.w, height: 16.h),
        // Trade Distribution (Pie Chart)
        Expanded(
          flex: 1,
          child: Container(
            height: 350.h,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.accentTeal),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Trade Distribution",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 0,
                            centerSpaceRadius: 40.r,
                            sections: [
                              PieChartSectionData(
                                color: AppColors.primary,
                                value: 60,
                                title: '',
                                radius: 20.r,
                              ),
                              PieChartSectionData(
                                color: Colors.blue,
                                value: 25,
                                title: '',
                                radius: 20.r,
                              ),
                              PieChartSectionData(
                                color: AppColors.accentTeal,
                                value: 15,
                                title: '',
                                radius: 20.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLegendItem(
                            AppColors.primary,
                            "BTC/USDT",
                            "60%",
                          ),
                          SizedBox(height: 8.h),
                          _buildLegendItem(Colors.blue, "ETH/USDT", "25%"),
                          SizedBox(height: 8.h),
                          _buildLegendItem(
                            AppColors.accentTeal,
                            "Other",
                            "15%",
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
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label, String pct) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          pct,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 5. BOTTOM GRID (DAYS & TABLE)
  // ---------------------------------------------------------------------------
  Widget _buildBottomGrid(BuildContext context) {
    bool isDesktop = ResponsiveLayout.isDesktop(context);

    return Flex(
      direction: isDesktop ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Best/Worst Days Bar Chart
        Expanded(
          flex: 1,
          child: Container(
            height: 350.h,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.accentTeal),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Best & Worst Trading Days",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildDayBar(
                        "Mon",
                        0.4,
                        AppColors.success.withOpacity(0.8),
                      ),
                      _buildDayBar("Tue", 0.9, AppColors.success), // Best Day
                      _buildDayBar(
                        "Wed",
                        0.3,
                        AppColors.success.withOpacity(0.6),
                      ),
                      _buildDayBar(
                        "Thu",
                        0.2,
                        AppColors.danger.withOpacity(0.5),
                      ),
                      _buildDayBar("Fri", 0.45, AppColors.danger), // Worst Day
                      _buildDayBar("Sat", 0.02, AppColors.accentTeal),
                      _buildDayBar("Sun", 0.02, AppColors.accentTeal),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.w, height: 16.h),
        // Recent Trades Table
        Expanded(
          flex: 1,
          child: Container(
            height: 350.h,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.accentTeal),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Trades",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                      },
                      children: [
                        _buildTableHeader(),
                        _buildTableRow(
                          "BTC/USDT",
                          "Long",
                          "1.2",
                          "+\$450.00",
                          AppColors.success,
                        ),
                        _buildTableRow(
                          "ETH/USDT",
                          "Short",
                          "10.0",
                          "-\$120.00",
                          AppColors.danger,
                        ),
                        _buildTableRow(
                          "SOL/USDT",
                          "Long",
                          "150.0",
                          "+\$210.50",
                          AppColors.success,
                        ),
                        _buildTableRow(
                          "BTC/USDT",
                          "Long",
                          "0.5",
                          "+\$85.00",
                          AppColors.success,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayBar(String day, double pct, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 24.w,
          height: 180.h * pct, // Scale bar height
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          day,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
        ),
      ],
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.accentTeal)),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            "Symbol",
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
          ),
        ),
        Text(
          "Type",
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
        ),
        Text(
          "Size",
          textAlign: TextAlign.right,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
        ),
        Text(
          "PnL",
          textAlign: TextAlign.right,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
        ),
      ],
    );
  }

  TableRow _buildTableRow(
    String symbol,
    String type,
    String size,
    String pnl,
    Color pnlColor,
  ) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF234248))),
      ), // faint border
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Text(
            symbol,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: pnlColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              type.toUpperCase(),
              style: TextStyle(
                color: pnlColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Text(
          size,
          textAlign: TextAlign.right,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        ),
        Text(
          pnl,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: pnlColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {String? badge}) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (badge != null) ...[
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              badge,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
