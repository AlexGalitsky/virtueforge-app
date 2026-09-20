// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_stoic_pillar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UIStoicPillar {

 int get id; String get nameKey; String get descriptionKey;/// Lifetime level (Temple — classical growth).
 int get level;/// XP within the current lifetime level.
 int get currentLevelXp;/// XP required to finish the current lifetime level.
 int get nextLevelXp;/// 0–1 fill of the lifetime bar (`currentLevelXp / nextLevelXp`).
 double get lifetimeProgress;/// 0–1 integrity of **this week** for the pillar (inverse: starts at 1.0).
 double get weekIntegrity;
/// Create a copy of UIStoicPillar
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStoicPillarCopyWith<UIStoicPillar> get copyWith => _$UIStoicPillarCopyWithImpl<UIStoicPillar>(this as UIStoicPillar, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStoicPillar&&(identical(other.id, id) || other.id == id)&&(identical(other.nameKey, nameKey) || other.nameKey == nameKey)&&(identical(other.descriptionKey, descriptionKey) || other.descriptionKey == descriptionKey)&&(identical(other.level, level) || other.level == level)&&(identical(other.currentLevelXp, currentLevelXp) || other.currentLevelXp == currentLevelXp)&&(identical(other.nextLevelXp, nextLevelXp) || other.nextLevelXp == nextLevelXp)&&(identical(other.lifetimeProgress, lifetimeProgress) || other.lifetimeProgress == lifetimeProgress)&&(identical(other.weekIntegrity, weekIntegrity) || other.weekIntegrity == weekIntegrity));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameKey,descriptionKey,level,currentLevelXp,nextLevelXp,lifetimeProgress,weekIntegrity);

@override
String toString() {
  return 'UIStoicPillar(id: $id, nameKey: $nameKey, descriptionKey: $descriptionKey, level: $level, currentLevelXp: $currentLevelXp, nextLevelXp: $nextLevelXp, lifetimeProgress: $lifetimeProgress, weekIntegrity: $weekIntegrity)';
}


}

/// @nodoc
abstract mixin class $UIStoicPillarCopyWith<$Res>  {
  factory $UIStoicPillarCopyWith(UIStoicPillar value, $Res Function(UIStoicPillar) _then) = _$UIStoicPillarCopyWithImpl;
@useResult
$Res call({
 int id, String nameKey, String descriptionKey, int level, int currentLevelXp, int nextLevelXp, double lifetimeProgress, double weekIntegrity
});




}
/// @nodoc
class _$UIStoicPillarCopyWithImpl<$Res>
    implements $UIStoicPillarCopyWith<$Res> {
  _$UIStoicPillarCopyWithImpl(this._self, this._then);

  final UIStoicPillar _self;
  final $Res Function(UIStoicPillar) _then;

/// Create a copy of UIStoicPillar
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameKey = null,Object? descriptionKey = null,Object? level = null,Object? currentLevelXp = null,Object? nextLevelXp = null,Object? lifetimeProgress = null,Object? weekIntegrity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameKey: null == nameKey ? _self.nameKey : nameKey // ignore: cast_nullable_to_non_nullable
as String,descriptionKey: null == descriptionKey ? _self.descriptionKey : descriptionKey // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,currentLevelXp: null == currentLevelXp ? _self.currentLevelXp : currentLevelXp // ignore: cast_nullable_to_non_nullable
as int,nextLevelXp: null == nextLevelXp ? _self.nextLevelXp : nextLevelXp // ignore: cast_nullable_to_non_nullable
as int,lifetimeProgress: null == lifetimeProgress ? _self.lifetimeProgress : lifetimeProgress // ignore: cast_nullable_to_non_nullable
as double,weekIntegrity: null == weekIntegrity ? _self.weekIntegrity : weekIntegrity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [UIStoicPillar].
extension UIStoicPillarPatterns on UIStoicPillar {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UIStoicPillar value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UIStoicPillar() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UIStoicPillar value)  $default,){
final _that = this;
switch (_that) {
case _UIStoicPillar():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UIStoicPillar value)?  $default,){
final _that = this;
switch (_that) {
case _UIStoicPillar() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nameKey,  String descriptionKey,  int level,  int currentLevelXp,  int nextLevelXp,  double lifetimeProgress,  double weekIntegrity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UIStoicPillar() when $default != null:
return $default(_that.id,_that.nameKey,_that.descriptionKey,_that.level,_that.currentLevelXp,_that.nextLevelXp,_that.lifetimeProgress,_that.weekIntegrity);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nameKey,  String descriptionKey,  int level,  int currentLevelXp,  int nextLevelXp,  double lifetimeProgress,  double weekIntegrity)  $default,) {final _that = this;
switch (_that) {
case _UIStoicPillar():
return $default(_that.id,_that.nameKey,_that.descriptionKey,_that.level,_that.currentLevelXp,_that.nextLevelXp,_that.lifetimeProgress,_that.weekIntegrity);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nameKey,  String descriptionKey,  int level,  int currentLevelXp,  int nextLevelXp,  double lifetimeProgress,  double weekIntegrity)?  $default,) {final _that = this;
switch (_that) {
case _UIStoicPillar() when $default != null:
return $default(_that.id,_that.nameKey,_that.descriptionKey,_that.level,_that.currentLevelXp,_that.nextLevelXp,_that.lifetimeProgress,_that.weekIntegrity);case _:
  return null;

}
}

}

/// @nodoc


class _UIStoicPillar implements UIStoicPillar {
  const _UIStoicPillar({required this.id, required this.nameKey, required this.descriptionKey, required this.level, required this.currentLevelXp, required this.nextLevelXp, required this.lifetimeProgress, required this.weekIntegrity});
  

@override final  int id;
@override final  String nameKey;
@override final  String descriptionKey;
/// Lifetime level (Temple — classical growth).
@override final  int level;
/// XP within the current lifetime level.
@override final  int currentLevelXp;
/// XP required to finish the current lifetime level.
@override final  int nextLevelXp;
/// 0–1 fill of the lifetime bar (`currentLevelXp / nextLevelXp`).
@override final  double lifetimeProgress;
/// 0–1 integrity of **this week** for the pillar (inverse: starts at 1.0).
@override final  double weekIntegrity;

/// Create a copy of UIStoicPillar
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UIStoicPillarCopyWith<_UIStoicPillar> get copyWith => __$UIStoicPillarCopyWithImpl<_UIStoicPillar>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UIStoicPillar&&(identical(other.id, id) || other.id == id)&&(identical(other.nameKey, nameKey) || other.nameKey == nameKey)&&(identical(other.descriptionKey, descriptionKey) || other.descriptionKey == descriptionKey)&&(identical(other.level, level) || other.level == level)&&(identical(other.currentLevelXp, currentLevelXp) || other.currentLevelXp == currentLevelXp)&&(identical(other.nextLevelXp, nextLevelXp) || other.nextLevelXp == nextLevelXp)&&(identical(other.lifetimeProgress, lifetimeProgress) || other.lifetimeProgress == lifetimeProgress)&&(identical(other.weekIntegrity, weekIntegrity) || other.weekIntegrity == weekIntegrity));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameKey,descriptionKey,level,currentLevelXp,nextLevelXp,lifetimeProgress,weekIntegrity);

@override
String toString() {
  return 'UIStoicPillar(id: $id, nameKey: $nameKey, descriptionKey: $descriptionKey, level: $level, currentLevelXp: $currentLevelXp, nextLevelXp: $nextLevelXp, lifetimeProgress: $lifetimeProgress, weekIntegrity: $weekIntegrity)';
}


}

/// @nodoc
abstract mixin class _$UIStoicPillarCopyWith<$Res> implements $UIStoicPillarCopyWith<$Res> {
  factory _$UIStoicPillarCopyWith(_UIStoicPillar value, $Res Function(_UIStoicPillar) _then) = __$UIStoicPillarCopyWithImpl;
@override @useResult
$Res call({
 int id, String nameKey, String descriptionKey, int level, int currentLevelXp, int nextLevelXp, double lifetimeProgress, double weekIntegrity
});




}
/// @nodoc
class __$UIStoicPillarCopyWithImpl<$Res>
    implements _$UIStoicPillarCopyWith<$Res> {
  __$UIStoicPillarCopyWithImpl(this._self, this._then);

  final _UIStoicPillar _self;
  final $Res Function(_UIStoicPillar) _then;

/// Create a copy of UIStoicPillar
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameKey = null,Object? descriptionKey = null,Object? level = null,Object? currentLevelXp = null,Object? nextLevelXp = null,Object? lifetimeProgress = null,Object? weekIntegrity = null,}) {
  return _then(_UIStoicPillar(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameKey: null == nameKey ? _self.nameKey : nameKey // ignore: cast_nullable_to_non_nullable
as String,descriptionKey: null == descriptionKey ? _self.descriptionKey : descriptionKey // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,currentLevelXp: null == currentLevelXp ? _self.currentLevelXp : currentLevelXp // ignore: cast_nullable_to_non_nullable
as int,nextLevelXp: null == nextLevelXp ? _self.nextLevelXp : nextLevelXp // ignore: cast_nullable_to_non_nullable
as int,lifetimeProgress: null == lifetimeProgress ? _self.lifetimeProgress : lifetimeProgress // ignore: cast_nullable_to_non_nullable
as double,weekIntegrity: null == weekIntegrity ? _self.weekIntegrity : weekIntegrity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
