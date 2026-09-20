// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_franklin_virtue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UIFranklinVirtue {

 int get id;/// Ключ локализации из БД (`virtueAbstinence`).
 String get name;/// Ключ описания добродетели.
 String get description; int get weekNumber; bool get isCurrentWeekFocus;/// Ровно 7 элементов: Пн…Вс.
 List<int> get weeklyStrikes;/// Ровно 7 элементов: сколько заметок на день (для бейджа в сетке).
 List<int> get weeklyNoteCounts;
/// Create a copy of UIFranklinVirtue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIFranklinVirtueCopyWith<UIFranklinVirtue> get copyWith => _$UIFranklinVirtueCopyWithImpl<UIFranklinVirtue>(this as UIFranklinVirtue, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIFranklinVirtue&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.isCurrentWeekFocus, isCurrentWeekFocus) || other.isCurrentWeekFocus == isCurrentWeekFocus)&&const DeepCollectionEquality().equals(other.weeklyStrikes, weeklyStrikes)&&const DeepCollectionEquality().equals(other.weeklyNoteCounts, weeklyNoteCounts));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,weekNumber,isCurrentWeekFocus,const DeepCollectionEquality().hash(weeklyStrikes),const DeepCollectionEquality().hash(weeklyNoteCounts));

@override
String toString() {
  return 'UIFranklinVirtue(id: $id, name: $name, description: $description, weekNumber: $weekNumber, isCurrentWeekFocus: $isCurrentWeekFocus, weeklyStrikes: $weeklyStrikes, weeklyNoteCounts: $weeklyNoteCounts)';
}


}

/// @nodoc
abstract mixin class $UIFranklinVirtueCopyWith<$Res>  {
  factory $UIFranklinVirtueCopyWith(UIFranklinVirtue value, $Res Function(UIFranklinVirtue) _then) = _$UIFranklinVirtueCopyWithImpl;
@useResult
$Res call({
 int id, String name, String description, int weekNumber, bool isCurrentWeekFocus, List<int> weeklyStrikes, List<int> weeklyNoteCounts
});




}
/// @nodoc
class _$UIFranklinVirtueCopyWithImpl<$Res>
    implements $UIFranklinVirtueCopyWith<$Res> {
  _$UIFranklinVirtueCopyWithImpl(this._self, this._then);

  final UIFranklinVirtue _self;
  final $Res Function(UIFranklinVirtue) _then;

/// Create a copy of UIFranklinVirtue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? weekNumber = null,Object? isCurrentWeekFocus = null,Object? weeklyStrikes = null,Object? weeklyNoteCounts = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,isCurrentWeekFocus: null == isCurrentWeekFocus ? _self.isCurrentWeekFocus : isCurrentWeekFocus // ignore: cast_nullable_to_non_nullable
as bool,weeklyStrikes: null == weeklyStrikes ? _self.weeklyStrikes : weeklyStrikes // ignore: cast_nullable_to_non_nullable
as List<int>,weeklyNoteCounts: null == weeklyNoteCounts ? _self.weeklyNoteCounts : weeklyNoteCounts // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [UIFranklinVirtue].
extension UIFranklinVirtuePatterns on UIFranklinVirtue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UIFranklinVirtue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UIFranklinVirtue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UIFranklinVirtue value)  $default,){
final _that = this;
switch (_that) {
case _UIFranklinVirtue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UIFranklinVirtue value)?  $default,){
final _that = this;
switch (_that) {
case _UIFranklinVirtue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String description,  int weekNumber,  bool isCurrentWeekFocus,  List<int> weeklyStrikes,  List<int> weeklyNoteCounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UIFranklinVirtue() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.weekNumber,_that.isCurrentWeekFocus,_that.weeklyStrikes,_that.weeklyNoteCounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String description,  int weekNumber,  bool isCurrentWeekFocus,  List<int> weeklyStrikes,  List<int> weeklyNoteCounts)  $default,) {final _that = this;
switch (_that) {
case _UIFranklinVirtue():
return $default(_that.id,_that.name,_that.description,_that.weekNumber,_that.isCurrentWeekFocus,_that.weeklyStrikes,_that.weeklyNoteCounts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String description,  int weekNumber,  bool isCurrentWeekFocus,  List<int> weeklyStrikes,  List<int> weeklyNoteCounts)?  $default,) {final _that = this;
switch (_that) {
case _UIFranklinVirtue() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.weekNumber,_that.isCurrentWeekFocus,_that.weeklyStrikes,_that.weeklyNoteCounts);case _:
  return null;

}
}

}

/// @nodoc


class _UIFranklinVirtue implements UIFranklinVirtue {
  const _UIFranklinVirtue({required this.id, required this.name, required this.description, required this.weekNumber, required this.isCurrentWeekFocus, required final  List<int> weeklyStrikes, required final  List<int> weeklyNoteCounts}): _weeklyStrikes = weeklyStrikes,_weeklyNoteCounts = weeklyNoteCounts;
  

@override final  int id;
/// Ключ локализации из БД (`virtueAbstinence`).
@override final  String name;
/// Ключ описания добродетели.
@override final  String description;
@override final  int weekNumber;
@override final  bool isCurrentWeekFocus;
/// Ровно 7 элементов: Пн…Вс.
 final  List<int> _weeklyStrikes;
/// Ровно 7 элементов: Пн…Вс.
@override List<int> get weeklyStrikes {
  if (_weeklyStrikes is EqualUnmodifiableListView) return _weeklyStrikes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyStrikes);
}

/// Ровно 7 элементов: сколько заметок на день (для бейджа в сетке).
 final  List<int> _weeklyNoteCounts;
/// Ровно 7 элементов: сколько заметок на день (для бейджа в сетке).
@override List<int> get weeklyNoteCounts {
  if (_weeklyNoteCounts is EqualUnmodifiableListView) return _weeklyNoteCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyNoteCounts);
}


/// Create a copy of UIFranklinVirtue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UIFranklinVirtueCopyWith<_UIFranklinVirtue> get copyWith => __$UIFranklinVirtueCopyWithImpl<_UIFranklinVirtue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UIFranklinVirtue&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.isCurrentWeekFocus, isCurrentWeekFocus) || other.isCurrentWeekFocus == isCurrentWeekFocus)&&const DeepCollectionEquality().equals(other._weeklyStrikes, _weeklyStrikes)&&const DeepCollectionEquality().equals(other._weeklyNoteCounts, _weeklyNoteCounts));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,weekNumber,isCurrentWeekFocus,const DeepCollectionEquality().hash(_weeklyStrikes),const DeepCollectionEquality().hash(_weeklyNoteCounts));

@override
String toString() {
  return 'UIFranklinVirtue(id: $id, name: $name, description: $description, weekNumber: $weekNumber, isCurrentWeekFocus: $isCurrentWeekFocus, weeklyStrikes: $weeklyStrikes, weeklyNoteCounts: $weeklyNoteCounts)';
}


}

/// @nodoc
abstract mixin class _$UIFranklinVirtueCopyWith<$Res> implements $UIFranklinVirtueCopyWith<$Res> {
  factory _$UIFranklinVirtueCopyWith(_UIFranklinVirtue value, $Res Function(_UIFranklinVirtue) _then) = __$UIFranklinVirtueCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String description, int weekNumber, bool isCurrentWeekFocus, List<int> weeklyStrikes, List<int> weeklyNoteCounts
});




}
/// @nodoc
class __$UIFranklinVirtueCopyWithImpl<$Res>
    implements _$UIFranklinVirtueCopyWith<$Res> {
  __$UIFranklinVirtueCopyWithImpl(this._self, this._then);

  final _UIFranklinVirtue _self;
  final $Res Function(_UIFranklinVirtue) _then;

/// Create a copy of UIFranklinVirtue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? weekNumber = null,Object? isCurrentWeekFocus = null,Object? weeklyStrikes = null,Object? weeklyNoteCounts = null,}) {
  return _then(_UIFranklinVirtue(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,isCurrentWeekFocus: null == isCurrentWeekFocus ? _self.isCurrentWeekFocus : isCurrentWeekFocus // ignore: cast_nullable_to_non_nullable
as bool,weeklyStrikes: null == weeklyStrikes ? _self._weeklyStrikes : weeklyStrikes // ignore: cast_nullable_to_non_nullable
as List<int>,weeklyNoteCounts: null == weeklyNoteCounts ? _self._weeklyNoteCounts : weeklyNoteCounts // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
