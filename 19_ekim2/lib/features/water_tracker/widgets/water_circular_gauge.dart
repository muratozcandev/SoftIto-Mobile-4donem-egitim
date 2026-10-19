import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/water_tracker_controller.dart';

class WaterCircularGauge extends StatelessWidget {
  final WaterTrackerController controller;

  const WaterCircularGauge({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ValueListenableBuilder<int>(
      valueListenable: controller.currentWater,
      builder: (context, currentWater, _) {
        final progress = (currentWater / controller.dailyGoal).clamp(0.0, 1.0);
        return Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _GaugePainterWidget(progress: progress, isDark: isDark),
                _GaugeContent(
                  currentWater: currentWater,
                  dailyGoal: controller.dailyGoal,
                  isDark: isDark,
                  onReset: controller.resetWater,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GaugePainterWidget extends StatelessWidget {
  final double progress;
  final bool isDark;

  const _GaugePainterWidget({
    required this.progress,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(250, 250),
      painter: _CircleGaugePainter(progress: progress, isDark: isDark),
    );
  }
}

class _GaugeContent extends StatelessWidget {
  final int currentWater;
  final int dailyGoal;
  final bool isDark;
  final VoidCallback onReset;

  const _GaugeContent({
    required this.currentWater,
    required this.dailyGoal,
    required this.isDark,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final percent = ((currentWater / dailyGoal) * 100).toInt();
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.water_drop,
          color: isDark ? AppColors.neonCyan : AppColors.neonBlue,
          size: 28,
        ),
        const SizedBox(height: 4),
        Text(
          '$currentWater',
          style: textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          '/ $dailyGoal ml (%$percent)',
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _ResetButton(isDark: isDark, onReset: onReset),
      ],
    );
  }
}

class _ResetButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onReset;

  const _ResetButton({
    required this.isDark,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onReset,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceElevated : AppColors.lightSurfaceElevated,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.error.withAlpha(128),
            width: 1,
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh, size: 14, color: AppColors.error),
            SizedBox(width: 4),
            Text(
              'Sıfırla',
              style: TextStyle(
                color: AppColors.error,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleGaugePainter extends CustomPainter {
  final double progress;
  final bool isDark;

  _CircleGaugePainter({
    required this.progress,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 24) / 2;

    // Arka plan izi
    final backgroundPaint = Paint()
      ..color = isDark ? AppColors.surfaceElevated : AppColors.lightSurfaceElevated
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Neon Cyan İlerleme İzi & Parıltı
    final glowPaint = Paint()
      ..color = (isDark ? AppColors.neonCyan : AppColors.neonBlue).withAlpha(90)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..shader = SweepGradient(
        colors: isDark
            ? const [AppColors.neonBlue, AppColors.neonCyan]
            : const [AppColors.neonCyan, AppColors.neonBlue],
        startAngle: 0.0,
        endAngle: math.pi * 2,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = math.pi * 2 * progress;

    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        glowPaint,
      );
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircleGaugePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isDark != isDark;
  }
}
