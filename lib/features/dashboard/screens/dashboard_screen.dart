import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Ensure these paths match your project
import 'package:tradeapp/core/constants/size_extensions.dart';
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
      drawer: !ResponsiveLayout.isDesktop(context)
          ? const Drawer(
              backgroundColor: AppColors.surfaceDark,
              child: CustomSidebar(),
            )
          : null,
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
        CustomHeader(
          title: "Analytics Overview",
          //   onMenuPressed: () => Scaffold.of(context).openDrawer(),
        ),
        Expanded(
          child: SingleChildScrollView(
            // Use standard padding if .w is unreliable on mobile
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildActionBar(context),
                const SizedBox(height: 24),

                _buildKPIGrid(context),
                const SizedBox(height: 24),

                _buildSectionHeader("Open Trades", badge: "3 Active"),
                const SizedBox(height: 16),
                _buildOpenTradesGrid(context),
                const SizedBox(height: 24),

                // Charts
                _buildChartsSection(context),
                const SizedBox(height: 24),

                // Bottom Grid
                _buildBottomGrid(context),
                const SizedBox(height: 40),
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
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Real-time trading insights and account health",
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        if (!isDesktop) const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildFilterChip("Last 30 Days", Icons.calendar_today),
            _buildFilterChip("Main Margin", Icons.account_balance_wallet),
            _buildFilterChip("All Markets", Icons.candlestick_chart),
            Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
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
                  fontSize: 14,
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
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.accentTeal),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.expand_more, color: AppColors.textSecondary, size: 16),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. KPI GRID
  // ---------------------------------------------------------------------------
  Widget _buildKPIGrid(BuildContext context) {
    int crossAxisCount = ResponsiveLayout.isDesktop(context)
        ? 4
        : (ResponsiveLayout.isTablet(context) ? 2 : 1);

    return LayoutBuilder(
      builder: (context, constraints) {
        double spacing = 16;
        // Calculate width safely
        double availableWidth = constraints.maxWidth;
        double itemWidth =
            (availableWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;

        // Fallback if calculation fails
        if (itemWidth.isNaN || itemWidth <= 0) itemWidth = availableWidth;

        return Wrap(
          spacing: spacing,
          runSpacing: 16,
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      color: valueColor ?? Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accentTeal.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isChart
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: const CircularProgressIndicator(
                          value: 0.62,
                          color: AppColors.primary,
                          backgroundColor: AppColors.accentTeal,
                          strokeWidth: 3,
                        ),
                      )
                    : Icon(icon, color: accent, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.inter(
                    color: AppColors.success,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "vs last month",
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 12,
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
        double spacing = 16;
        double itemWidth =
            (constraints.maxWidth - (crossAxisCount - 1) * spacing) /
            crossAxisCount;
        if (itemWidth <= 0) itemWidth = constraints.maxWidth;

        return Wrap(
          spacing: spacing,
          runSpacing: 16,
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.accentTeal),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.accentTeal,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      pair.substring(0, 1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pair,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        type,
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  side.toUpperCase(),
                  style: GoogleFonts.inter(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
          const SizedBox(height: 8),
          Divider(color: AppColors.accentTeal.withOpacity(0.5), height: 1),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildTradeDataCell(
                  "Unrealized PnL",
                  "",
                  Colors.transparent,
                ),
              ),
              Expanded(
                child: Text(
                  pnl,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                    color: color,
                    fontSize: 12,
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
            fontSize: 12,
          ),
        ),
        if (value.isNotEmpty)
          Text(
            value,
            style: GoogleFonts.inter(
              color: valueColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 4. CHARTS SECTION (Fixed Visibility)
  // ---------------------------------------------------------------------------
  Widget _buildChartsSection(BuildContext context) {
    bool isDesktop = ResponsiveLayout.isDesktop(context);

    // FIX: Use fixed height '320' instead of '350.h' to guarantee rendering on mobile
    Widget equityCurve = Container(
      height: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Cumulative PnL over time",
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  " Line ",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Expanded works here because Parent Container has fixed height (320)
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
                    spots: const [
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
    );

    Widget tradeDistribution = Container(
      height: 320, // Fixed height safe for mobile
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accentTeal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trade Distribution",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: [
                        PieChartSectionData(
                          color: AppColors.primary,
                          value: 60,
                          title: '',
                          radius: 20,
                        ),
                        PieChartSectionData(
                          color: Colors.blue,
                          value: 25,
                          title: '',
                          radius: 20,
                        ),
                        PieChartSectionData(
                          color: AppColors.accentTeal,
                          value: 15,
                          title: '',
                          radius: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(AppColors.primary, "BTC/USDT", "60%"),
                    const SizedBox(height: 8),
                    _buildLegendItem(Colors.blue, "ETH/USDT", "25%"),
                    const SizedBox(height: 8),
                    _buildLegendItem(AppColors.accentTeal, "Other", "15%"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: equityCurve),
          const SizedBox(width: 16),
          Expanded(flex: 1, child: tradeDistribution),
        ],
      );
    } else {
      return Column(
        children: [equityCurve, const SizedBox(height: 16), tradeDistribution],
      );
    }
  }

  Widget _buildLegendItem(Color color, String label, String pct) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          pct,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 5. BOTTOM GRID (Fixed Visibility)
  // ---------------------------------------------------------------------------
  Widget _buildBottomGrid(BuildContext context) {
    bool isDesktop = ResponsiveLayout.isDesktop(context);

    Widget daysChart = Container(
      height: 320, // Fixed height
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accentTeal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Best & Worst Trading Days",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildDayBar("Mon", 0.4, AppColors.success.withOpacity(0.8)),
                _buildDayBar("Tue", 0.9, AppColors.success),
                _buildDayBar("Wed", 0.3, AppColors.success.withOpacity(0.6)),
                _buildDayBar("Thu", 0.2, AppColors.danger.withOpacity(0.5)),
                _buildDayBar("Fri", 0.45, AppColors.danger),
                _buildDayBar("Sat", 0.02, AppColors.accentTeal),
                _buildDayBar("Sun", 0.02, AppColors.accentTeal),
              ],
            ),
          ),
        ],
      ),
    );

    Widget recentTrades = Container(
      height: 320, // Fixed height
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "View All",
                style: TextStyle(color: AppColors.primary, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // FIX: Expanded takes remaining space in 320px container
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  // Ensure table is wide enough to be readable
                  width: isDesktop ? 600 : 600,
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
            ),
          ),
        ],
      ),
    );

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: daysChart),
          const SizedBox(width: 16),
          Expanded(flex: 1, child: recentTrades),
        ],
      );
    } else {
      return Column(
        children: [daysChart, const SizedBox(height: 16), recentTrades],
      );
    }
  }

  Widget _buildDayBar(String day, double pct, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            // Safe height calculation
            return Container(
              width: 24,
              height: 150 * pct,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
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
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "Symbol",
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ),
        Text(
          "Type",
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        Text(
          "Size",
          textAlign: TextAlign.right,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        Text(
          "PnL",
          textAlign: TextAlign.right,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
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
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            symbol,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: pnlColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              type.toUpperCase(),
              style: TextStyle(
                color: pnlColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Text(
          size,
          textAlign: TextAlign.right,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        Text(
          pnl,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: pnlColor,
            fontSize: 14,
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
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (badge != null) ...[
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              badge,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
