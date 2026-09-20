import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class PillarDecayPainter extends CustomPainter {
  final double progress;       // Текущий прогресс (1.0 — монолит, 0.0 — разрушен)
  final int virtueId;          // Seed для фиксации трещин
  final Color themeSurfaceColor; // Цвет подложки для правильного наложения теней

  PillarDecayPainter({
    required this.progress,
    required this.virtueId,
    required this.themeSurfaceColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double urog = (1.0 - progress).clamp(0.0, 1.0); // Уровень урона
    final double w = size.width;
    final double h = size.height;

    final double baseWidth = w * 0.8;
    final double shaftWidth = w * 0.5;

    // Базовые благородные краски стоического мрамора
    final Color marbleColor = const Color(0xFFF5F5F7).withOpacity(0.9); // Светлый премиальный мрамор
    final Color shadowColor = Colors.black.withOpacity(0.45);
    final Color magmaColor = Colors.orangeAccent.shade700; // Раскаленное нутро характера

    // 1. НАСТРОЙКА КИСЕЙ И СВЕТОТЕНИ
    final paintFill = Paint()..style = PaintingStyle.fill;
    final paintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    // Мягкий градиент для придания колонне цилиндрического объема
    final Rect shaftRect = Rect.fromLTWH((w - shaftWidth) / 2, h * 0.22, shaftWidth, h * 0.65);
    final LinearGradient columnGradient = LinearGradient(
      colors: [
        marbleColor.withOpacity(0.7),
        marbleColor,
        marbleColor.withOpacity(0.8),
        marbleColor.withOpacity(0.4),
      ],
      stops: const [0.0, 0.3, 0.7, 1.0],
    );

    // 2. ОТРИСОВКА ПЬЕДЕСТАЛА С ОБЪЕМОМ
    paintFill.shader = null;
    paintFill.color = marbleColor.withOpacity(0.85);
    final RRect baseRRect = RRect.fromRectAndRadius(
      Rect.fromLTRB((w - baseWidth) / 2, h - 14, (w + baseWidth) / 2, h),
      const Radius.circular(3),
    );
    canvas.drawRRect(baseRRect, paintFill);
    canvas.drawRRect(baseRRect, paintStroke..color = Colors.white.withOpacity(0.15));

    // Ступень пьедестала повыше
    canvas.drawRect(Rect.fromLTRB((w - shaftWidth * 1.2) / 2, h - 22, (w + shaftWidth * 1.2) / 2, h - 14), paintFill);

    // 3. ОТРИСОВКА СТВОЛА КОЛОННЫ (Объемный Мрамор)
    paintFill.shader = columnGradient.createShader(shaftRect);
    
    // Если урон критический, верхушка ствола скалывается динамически
    final double shaftTop = urog > 0.75 ? h * 0.45 : h * 0.22;
    final Rect currentShaftRect = Rect.fromLTRB((w - shaftWidth) / 2, shaftTop, (w + shaftWidth) / 2, h - 22);
    
    canvas.drawRect(currentShaftRect, paintFill);

    // Текстурные желоба (Каннелюры) — делаем их тонкими тенями для глубины
    const int flutesCount = 3;
    final double fluteSpace = shaftWidth / (flutesCount + 1);
    for (int i = 1; i <= flutesCount; i++) {
      final double fluteX = (w - shaftWidth) / 2 + (i * fluteSpace);
      canvas.drawLine(
        Offset(fluteX, h - 22), 
        Offset(fluteX, shaftTop), 
        paintStroke..color = Colors.black.withOpacity(0.12)..strokeWidth = 1.5,
      );
      // Блик рядом с тенью желоба для 3D-эффекта
      canvas.drawLine(
        Offset(fluteX + 1, h - 22), 
        Offset(fluteX + 1, shaftTop), 
        paintStroke..color = Colors.white.withOpacity(0.2)..strokeWidth = 0.8,
      );
    }

    // 4. ДИНАМИЧЕСКИЙ СКОЛ КАПИТЕЛИ (Эффект разрушения)
    if (urog <= 0.75) {
      // Монолитная капитель с мягкими тенями
      paintFill.shader = null;
      paintFill.color = marbleColor;
      canvas.drawRect(Rect.fromLTRB((w - shaftWidth * 1.3) / 2, h * 0.14, (w + shaftWidth * 1.3) / 2, h * 0.22), paintFill);
      
      // Закрученные волюты (Ионический ордер) с объемом
      canvas.drawCircle(Offset((w - shaftWidth * 1.05) / 2, h * 0.18), h * 0.03, paintFill);
      canvas.drawCircle(Offset((w - shaftWidth * 1.05) / 2, h * 0.18), h * 0.015, paintStroke..color = Colors.black.withOpacity(0.15));
      canvas.drawCircle(Offset((w + shaftWidth * 1.05) / 2, h * 0.18), h * 0.03, paintFill);
      canvas.drawCircle(Offset((w + shaftWidth * 1.05) / 2, h * 0.18), h * 0.015, paintStroke..color = Colors.black.withOpacity(0.15));
      
      canvas.drawRect(Rect.fromLTRB((w - baseWidth) / 2, h * 0.07, (w + baseWidth) / 2, h * 0.14), paintFill);
    } else {
      // ВАУ-ЭФФЕКТ: Кусок капители физически откололся и сполз в сторону!
      canvas.save();
      // Сдвигаем матрицу рендера отколовшегося куска вниз и вбок
      canvas.translate(6.0, 14.0);
      canvas.rotate(0.08); // Легкий наклон обломка
      
      paintFill.shader = null;
      paintFill.color = marbleColor.withOpacity(0.5); // Становится блеклым мертвым осколком
      
      final Path fragmentPath = Path()
        ..moveTo((w - shaftWidth) / 2, h * 0.22)
        ..lineTo((w + shaftWidth) / 2, h * 0.22)
        ..lineTo((w + shaftWidth * 1.3) / 2, h * 0.14)
        ..lineTo((w - shaftWidth * 1.3) / 2, h * 0.14)
        ..close();
      canvas.drawPath(fragmentPath, paintFill);
      canvas.drawPath(fragmentPath, paintStroke..color = Colors.black.withOpacity(0.2));
      canvas.restore();
    }

    // 5. КИНЕМАТОГРАФИЧЕСКИЕ ОБЪЕМНЫЕ ТРЕЩИНЫ (Эффект Кинцуги / Разлом угля)
    if (urog >= 0.15) {
      final rand = math.Random(virtueId);
      final int cracksCount = urog > 0.55 ? 3 : 1;

      for (int c = 0; c < cracksCount; c++) {
        double currentX = (w - shaftWidth) / 2 + rand.nextDouble() * shaftWidth;
        double currentY = h * 0.35 + rand.nextDouble() * (h * 0.3);

        final Path crackPath = Path()..moveTo(currentX, currentY);
        final int segments = (7 * urog).floor().clamp(3, 9);

        for (int s = 0; s < segments; s++) {
          final double angle = (rand.nextDouble() * math.pi * 0.5) - (math.pi * 0.25);
          final double length = rand.nextDouble() * 14 + 6;

          currentX += math.sin(angle) * length;
          currentY += math.cos(angle) * length;

          if (currentX > (w - shaftWidth) / 2 && currentX < (w + shaftWidth) / 2 && currentY < h - 22) {
            crackPath.lineTo(currentX, currentY);
          }
        }

        // --- МАГИЯ СЛОЕВ РАЗЛОМА ---
        // Слой 1: Глубокая тень разлома (рисуем трещину жирной и черной с размытием)
        canvas.drawPath(
          crackPath,
          Paint()
            ..color = shadowColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3.5
            ..strokeCap = StrokeCap.round
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0),
        );

        // Слой 2: Раскаленное нутро (внутри трещины течет жидкое золото/магма)
        canvas.drawPath(
          crackPath,
          Paint()
            ..color = Color.lerp(magmaColor, Colors.amber.shade400, rand.nextDouble())!
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.2
            ..strokeCap = StrokeCap.round,
        );
      }
    }
  }

  @override
  bool shouldRepaint(PillarDecayPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
