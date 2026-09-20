import 'package:flutter/material.dart';
import 'package:virtue_forge/features/journal/presentation/widgets/strike/strike_particle.dart';

class StrikePainter extends CustomPainter {
  final List<StrikeParticle> particles;
  final double strikeProgress; // Анимация появления креста (0.0 -> 1.0)
  final Color baseColor;

  StrikePainter({required this.particles, required this.strikeProgress, required this.baseColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (particles.isEmpty) return;

    final particlePaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < particles.length; i++) {
      final particle = particles[i];
      final lifeRatio = (particle.life / particle.maxLife).clamp(0.0, 1.0);
      final opacity = (1.0 - lifeRatio).clamp(0.0, 1.0);

      if (particle.isAsh) {
        // Палитра пепла: от темно-серого угля к размытому бледному дыму
        final ashColor = Color.lerp(Colors.grey.shade800, Colors.grey.shade500, lifeRatio)!;
        particlePaint.color = ashColor.withOpacity(opacity * 0.7); // Делаем дым полупрозрачным
      } else {
        // Палитра искр (при добавлении)
        Color particleColor;
        if (lifeRatio < 0.25) {
          particleColor = Color.lerp(Colors.amber.shade100, Colors.orangeAccent.shade700, lifeRatio / 0.25)!;
        } else if (lifeRatio < 0.65) {
          particleColor = Color.lerp(Colors.orangeAccent.shade700, Colors.red.shade900, (lifeRatio - 0.25) / 0.4)!;
        } else {
          particleColor = Color.lerp(Colors.red.shade900, Colors.grey.shade800, (lifeRatio - 0.65) / 0.3)!;
        }
        particlePaint.color = particleColor.withOpacity(opacity);

        if (lifeRatio < 0.15) {
          canvas.drawCircle(
            particle.position, 
            particle.size * 2.0, 
            Paint()
              ..color = Colors.orange.withOpacity(0.2)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5)
          );
        }
      }

      canvas.drawCircle(particle.position, particle.size, particlePaint);
    }
  }
  
  @override
  bool shouldRepaint(StrikePainter oldDelegate) {
    return particles.isNotEmpty || oldDelegate.particles.isNotEmpty || strikeProgress < 1.0;
  }
}