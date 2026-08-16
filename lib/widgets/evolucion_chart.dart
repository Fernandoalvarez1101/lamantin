import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/sesion.dart';
import '../theme.dart';
import '../utils/formato.dart';

/// Gráfica de línea con la evolución de la puntuación de un instrumento a lo
/// largo de las sesiones (más antigua → más reciente).
///
/// Se muestra solo cuando hay al menos 2 sesiones del mismo instrumento.
class EvolucionChart extends StatelessWidget {
  const EvolucionChart({super.key, required this.sesiones, this.height = 180});

  /// Sesiones del instrumento, de más antigua a más reciente (mínimo 2).
  final List<Sesion> sesiones;

  final double height;

  @override
  Widget build(BuildContext context) {
    if (sesiones.length < 2) return const SizedBox.shrink();

    final valores = [for (final s in sesiones) s.resultadoTotal];
    final minVal = valores.reduce(math.min);
    final maxVal = valores.reduce(math.max);
    final rango = maxVal - minVal;
    final margen = math.max(1.0, rango * 0.2);
    final n = sesiones.length;
    final intervaloTitulos = math.max(1, (n / 4).ceil());
    const color = LamantinColors.dustyViolet;

    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (n - 1).toDouble(),
          minY: minVal - margen,
          maxY: maxVal + margen,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: rango == 0 ? 1 : null,
            getDrawingHorizontalLine: (value) => FlLine(
              color: color.withValues(alpha: 0.15),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 34,
                getTitlesWidget: (value, meta) {
                  if (value == meta.max || value == meta.min) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      fontSize: 11,
                      color: color.withValues(alpha: 0.7),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: intervaloTitulos.toDouble(),
                getTitlesWidget: (value, meta) {
                  final idx = value.round();
                  if (idx < 0 || idx >= n) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      formatearFecha(sesiones[idx].fechaAplicacion),
                      style: TextStyle(
                        fontSize: 10,
                        color: color.withValues(alpha: 0.7),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (spots) => [
                for (final spot in spots)
                  LineTooltipItem(
                    'Sesión ${spot.x.round() + 1}: ${spot.y.round()}\n'
                    '${formatearFecha(sesiones[spot.x.round()].fechaAplicacion)}',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (var i = 0; i < n; i++)
                  FlSpot(i.toDouble(), sesiones[i].resultadoTotal.toDouble()),
              ],
              isCurved: true,
              curveSmoothness: 0.25,
              barWidth: 3,
              color: color,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 4,
                  color: color,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    color.withValues(alpha: 0.30),
                    color.withValues(alpha: 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
