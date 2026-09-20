import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_stoic_pillar.freezed.dart';

@freezed
abstract class UIStoicPillar with _$UIStoicPillar {
  const factory UIStoicPillar({
    required int id,
    required String nameKey,
    required String descriptionKey,
    /// Lifetime level (Temple — classical growth).
    required int level,
    /// XP within the current lifetime level.
    required int currentLevelXp,
    /// XP required to finish the current lifetime level.
    required int nextLevelXp,
    /// 0–1 fill of the lifetime bar (`currentLevelXp / nextLevelXp`).
    required double lifetimeProgress,
    /// 0–1 integrity of **this week** for the pillar (inverse: starts at 1.0).
    required double weekIntegrity,
  }) = _UIStoicPillar;
}
