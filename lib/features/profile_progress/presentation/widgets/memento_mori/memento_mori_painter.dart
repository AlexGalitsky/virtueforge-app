import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

enum MementoWeekStatus {
  past,       // Прожито до приложения (мраморно-серый)
  forgeCycle, // Выковано в приложении (терракотовый)
  current,    // Текущая неделя (пульсирующее ядро)
  future      // Будущее (едва заметный пепельный контур)
}

class MementoMoriPainter extends CustomPainter {
  final int livedWeeks;                 // Сколько недель прожито всего
  final Set<int> forgeCycleWeeks;       // Индексы недель, пройденных в приложении
  final int currentWeekIndex;           // Индекс текущей недели жизни (0..4159)
  final double pulseValue;              // Значение анимации пульсации текущей недели (0.0 -> 1.0)
  final Offset? touchPosition;          // Текущая координата пальца пользователя для эффекта линзы
  
  // Цветовая палитра из стоической дизайн-системы
  final Color pastColor;
  final Color forgeColor;
  final Color futureColor;

  MementoMoriPainter({
    required this.livedWeeks,
    required this.forgeCycleWeeks,
    required this.currentWeekIndex,
    required this.pulseValue,
    required this.touchPosition,
    required this.pastColor,
    required this.forgeColor,
    required this.futureColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const int weeksPerYear = 52;
    const int totalYears = 80;

    // Рассчитываем динамический шаг сетки исходя из размеров доступного холста
    final double cellSpacingX = size.width / weeksPerYear;
    final double cellSpacingY = size.height / totalYears;
    final double baseRadius = math.min(cellSpacingX, cellSpacingY) * 0.35;

    // Списки точек для пакетной отрисовки через drawPoints (максимальный FPS на GPU)
    final List<Offset> pastPoints = [];
    final List<Offset> forgePoints = [];
    final List<Offset> futurePoints = [];

    // Переменные для отрисовки увеличенной информации (Тултип над пальцем)
    int? hoveredWeek;
    int? hoveredYear;
    Offset? hoveredPointOffset;
    MementoWeekStatus? hoveredStatus;

    // Константы эффекта Фишай-Линзы
    const double lensRadius = 75.0; // Радиус действия линзы в пикселях
    const double maxMagnification = 1.8; // Максимальное увеличение размера точки
    // Эпицентр над пальцем, чтобы палец не перекрывал увеличенные точки.
    const double lensFingerOffsetY = 56.0;

    final Offset? lensCenter = touchPosition == null
        ? null
        : Offset(
            touchPosition!.dx,
            (touchPosition!.dy - lensFingerOffsetY).clamp(0.0, size.height),
          );

    for (int year = 0; year < totalYears; year++) {
      for (int week = 0; week < weeksPerYear; week++) {
        final int index = (year * weeksPerYear) + week;

        // Исходное положение точки на холсте
        double rawX = (week * cellSpacingX) + (cellSpacingX / 2);
        double rawY = (year * cellSpacingY) + (cellSpacingY / 2);
        Offset pointOffset = Offset(rawX, rawY);

        double currentRadius = baseRadius;

        // Математика эффекта интерактивной линзы (Fisheye Lens)
        if (lensCenter != null) {
          final double distance = (pointOffset - lensCenter).distance;

          if (distance < lensRadius) {
            // Мягкая функция Гаусса для плавного изменения размера по радиусу
            final double power =
                math.exp(-math.pow(distance / (lensRadius * 0.6), 2));

            // Точки под линзой плавно раздвигаются и увеличиваются
            currentRadius =
                baseRadius * (1.0 + (maxMagnification - 1.0) * power);

            // Ячейка в эпицентре линзы (над пальцем) — для тултипа
            if (distance < cellSpacingX * 0.8) {
              hoveredWeek = week + 1;
              hoveredYear = year;
              hoveredPointOffset = pointOffset;
            }
          }
        }

        // Классифицируем точку по времени жизни
        if (index == currentWeekIndex) {
          // Текущая неделя рендерится отдельно (радиальный пульсирующий градиент)
          _drawCurrentWeek(canvas, pointOffset, currentRadius);
          if (hoveredPointOffset == pointOffset) hoveredStatus = MementoWeekStatus.current;
        } else if (forgeCycleWeeks.contains(index)) {
          forgePoints.add(pointOffset);
          // Если точка под линзой, рисуем её индивидуально, чтобы применить измененный радиус
          if (currentRadius > baseRadius) {
            _drawSinglePoint(canvas, pointOffset, currentRadius, forgeColor);
          }
          if (hoveredPointOffset == pointOffset) hoveredStatus = MementoWeekStatus.forgeCycle;
        } else if (index < livedWeeks) {
          pastPoints.add(pointOffset);
          if (currentRadius > baseRadius) {
            _drawSinglePoint(canvas, pointOffset, currentRadius, pastColor);
          }
          if (hoveredPointOffset == pointOffset) hoveredStatus = MementoWeekStatus.past;
        } else {
          futurePoints.add(pointOffset);
          if (currentRadius > baseRadius) {
            _drawSinglePoint(canvas, pointOffset, currentRadius, futureColor.withOpacity(0.4));
          }
          if (hoveredPointOffset == pointOffset) hoveredStatus = MementoWeekStatus.future;
        }
      }
    }

    // Рендерим всю статичную матрицу тремя атомарными командами на GPU
    final Paint paintBatch = Paint()..strokeCap = StrokeCap.round;

    if (pastPoints.isNotEmpty) {
      canvas.drawPoints(PointMode.points, pastPoints, paintBatch..color = pastColor..strokeWidth = baseRadius * 2);
    }
    if (forgePoints.isNotEmpty) {
      canvas.drawPoints(PointMode.points, forgePoints, paintBatch..color = forgeColor..strokeWidth = baseRadius * 2);
    }
    if (futurePoints.isNotEmpty) {
      canvas.drawPoints(PointMode.points, futurePoints, paintBatch..color = futureColor.withOpacity(0.15)..strokeWidth = baseRadius * 2);
    }

    // Отрисовка интеллектуального стоического тултипа
    if (hoveredWeek != null && hoveredYear != null && hoveredPointOffset != null && hoveredStatus != null) {
      _drawStoicTooltip(canvas, size, hoveredPointOffset, hoveredWeek, hoveredYear, hoveredStatus);
    }
  }

  // Отрисовка единичной точки (для эффекта линзы)
  void _drawSinglePoint(Canvas canvas, Offset offset, double radius, Color color) {
    canvas.drawCircle(offset, radius, Paint()..color = color..style = PaintingStyle.fill);
  }

  // Отрисовка «дышащей» точки настоящего момента (Hic et Nunc)
  void _drawCurrentWeek(Canvas canvas, Offset offset, double radius) {
    final double pulseRadius = radius * (1.1 + math.sin(pulseValue * math.pi * 2) * 0.25);
    
    // Внутреннее яркое ядро
    canvas.drawCircle(offset, radius * 0.8, Paint()..color = forgeColor..style = PaintingStyle.fill);
    
    // Внешняя пульсирующая аура тепла уходящего времени
    canvas.drawCircle(
      offset, 
      pulseRadius, 
      Paint()
        ..color = forgeColor.withOpacity(0.35 * (1.0 - pulseValue))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
    );
  }

  // Рендеринг минималистичного информационного окна поверх холста
  void _drawStoicTooltip(Canvas canvas, Size size, Offset point, int week, int year, MementoWeekStatus status) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    
    String label = '${year} лет, ${week} нед.';
    Color badgeColor = pastColor;

    switch (status) {
      case MementoWeekStatus.past:
        label += ' • Прожитое время';
        badgeColor = pastColor;
        break;
      case MementoWeekStatus.forgeCycle:
        label += ' • Цикл Выкован';
        badgeColor = forgeColor;
        break;
      case MementoWeekStatus.current:
        label += ' • Здесь и Сейчас';
        badgeColor = forgeColor;
        break;
      case MementoWeekStatus.future:
        label += ' • Неизвестность';
        badgeColor = futureColor.withOpacity(0.5);
        break;
    }

    textPainter.text = TextSpan(
      text: label,
      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400, fontFamily: 'Mono', letterSpacing: 0.5),
    );
    textPainter.layout();

    // Корректируем координаты, чтобы тултип не вылетал за границы экрана
    double tooltipX = (point.dx - textPainter.width / 2).clamp(8.0, size.width - textPainter.width - 8.0);
    double tooltipY = point.dy - 28.0;
    if (tooltipY < 4.0) tooltipY = point.dy + 18.0;

    final RRect tooltipRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(tooltipX - 6, tooltipY - 4, textPainter.width + 12, textPainter.height + 8),
      const Radius.circular(4),
    );

    // Рисуем строгую плашку угля
    canvas.drawRRect(tooltipRect, Paint()..color = const Color(0xFF121212)..style = PaintingStyle.fill);
    canvas.drawRRect(tooltipRect, Paint()..color = badgeColor.withOpacity(0.3)..style = PaintingStyle.stroke..strokeWidth = 1.0);
    
    textPainter.paint(canvas, Offset(tooltipX, tooltipY));
  }

  // Оптимизация перерисовки холста
  @override
  bool shouldRepaint(MementoMoriPainter oldDelegate) {
    return oldDelegate.touchPosition != touchPosition || 
           oldDelegate.pulseValue != pulseValue || 
           oldDelegate.livedWeeks != livedWeeks ||
           oldDelegate.forgeCycleWeeks.length != forgeCycleWeeks.length;
  }
}
