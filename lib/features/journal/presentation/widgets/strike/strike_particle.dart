import 'dart:math' as math;
import 'dart:ui';

class StrikeParticle {
    Offset position;
    Offset velocity;
    double size;
    final double maxLife;
    double life = 0.0;
    final bool isAsh;

    StrikeParticle({required Offset center, this.isAsh = false, math.Random? random})
      : position = center,
        maxLife = (random ?? math.Random()).nextDouble() * (isAsh ? 0.6 : 0.35) + (isAsh ? 0.4 : 0.3),
        size = (random ?? math.Random()).nextDouble() * (isAsh ? 3.5 : 3.0) + (isAsh ? 2.0 : 1.2),
        velocity = _generateVelocity(random, isAsh);

    static Offset _generateVelocity(math.Random? random, bool isAsh) {
        final rand = random ?? math.Random();

        if (isAsh) {
            // Пепел летит медленно и строго вверх (поток теплого воздуха)
            final double angle = -math.pi / 2 + (rand.nextDouble() * 0.6 - 0.3); // Вверх +/- 17 градусов
            final double speed = rand.nextDouble() * 30 + 15; // Медленная скорость
            return Offset(math.cos(angle) * speed, math.sin(angle) * speed);
        } else {
            // Обычная искра при ударе молота
            final double angle = rand.nextDouble() * 2 * math.pi;
            final double speed = rand.nextDouble() * 160 + 60;
            return Offset(math.cos(angle) * speed, math.sin(angle) * speed);
        }
    }
  
    void update(double deltaTime) {
        life += deltaTime;

        if (isAsh) {
            // Пепел плавно замедляется по горизонтали и продолжает лететь вверх
            velocity = Offset(velocity.dx * 0.9, velocity.dy - 20 * deltaTime);
        } else {
            // Искры падают вниз под силой гравитации
            velocity = Offset(velocity.dx * 0.95, velocity.dy + 350 * deltaTime);
        }
        
        // Движение
        position += velocity * deltaTime;
        // Уменьшение размера
        size = math.max(0.1, size * (1.0 - (life / maxLife) * 0.08));
    }

    bool isAlive() => life < maxLife;
}