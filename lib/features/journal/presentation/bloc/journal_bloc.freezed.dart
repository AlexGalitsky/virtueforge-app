// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JournalEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JournalEvent()';
}


}

/// @nodoc
class $JournalEventCopyWith<$Res>  {
$JournalEventCopyWith(JournalEvent _, $Res Function(JournalEvent) __);
}


/// Adds pattern-matching-related methods to [JournalEvent].
extension JournalEventPatterns on JournalEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( JournalStarted value)?  started,TResult Function( JournalWeekShifted value)?  weekShifted,TResult Function( StrikeUpdated value)?  strikeUpdated,TResult Function( ReflectionSaved value)?  reflectionSaved,TResult Function( JournalActionErrorCleared value)?  actionErrorCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case JournalStarted() when started != null:
return started(_that);case JournalWeekShifted() when weekShifted != null:
return weekShifted(_that);case StrikeUpdated() when strikeUpdated != null:
return strikeUpdated(_that);case ReflectionSaved() when reflectionSaved != null:
return reflectionSaved(_that);case JournalActionErrorCleared() when actionErrorCleared != null:
return actionErrorCleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( JournalStarted value)  started,required TResult Function( JournalWeekShifted value)  weekShifted,required TResult Function( StrikeUpdated value)  strikeUpdated,required TResult Function( ReflectionSaved value)  reflectionSaved,required TResult Function( JournalActionErrorCleared value)  actionErrorCleared,}){
final _that = this;
switch (_that) {
case JournalStarted():
return started(_that);case JournalWeekShifted():
return weekShifted(_that);case StrikeUpdated():
return strikeUpdated(_that);case ReflectionSaved():
return reflectionSaved(_that);case JournalActionErrorCleared():
return actionErrorCleared(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( JournalStarted value)?  started,TResult? Function( JournalWeekShifted value)?  weekShifted,TResult? Function( StrikeUpdated value)?  strikeUpdated,TResult? Function( ReflectionSaved value)?  reflectionSaved,TResult? Function( JournalActionErrorCleared value)?  actionErrorCleared,}){
final _that = this;
switch (_that) {
case JournalStarted() when started != null:
return started(_that);case JournalWeekShifted() when weekShifted != null:
return weekShifted(_that);case StrikeUpdated() when strikeUpdated != null:
return strikeUpdated(_that);case ReflectionSaved() when reflectionSaved != null:
return reflectionSaved(_that);case JournalActionErrorCleared() when actionErrorCleared != null:
return actionErrorCleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( DateTime? week)?  started,TResult Function( int delta)?  weekShifted,TResult Function( int virtueId,  int dayIndex,  int amount)?  strikeUpdated,TResult Function( String noteUncontrolled,  String noteControlled)?  reflectionSaved,TResult Function()?  actionErrorCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case JournalStarted() when started != null:
return started(_that.week);case JournalWeekShifted() when weekShifted != null:
return weekShifted(_that.delta);case StrikeUpdated() when strikeUpdated != null:
return strikeUpdated(_that.virtueId,_that.dayIndex,_that.amount);case ReflectionSaved() when reflectionSaved != null:
return reflectionSaved(_that.noteUncontrolled,_that.noteControlled);case JournalActionErrorCleared() when actionErrorCleared != null:
return actionErrorCleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( DateTime? week)  started,required TResult Function( int delta)  weekShifted,required TResult Function( int virtueId,  int dayIndex,  int amount)  strikeUpdated,required TResult Function( String noteUncontrolled,  String noteControlled)  reflectionSaved,required TResult Function()  actionErrorCleared,}) {final _that = this;
switch (_that) {
case JournalStarted():
return started(_that.week);case JournalWeekShifted():
return weekShifted(_that.delta);case StrikeUpdated():
return strikeUpdated(_that.virtueId,_that.dayIndex,_that.amount);case ReflectionSaved():
return reflectionSaved(_that.noteUncontrolled,_that.noteControlled);case JournalActionErrorCleared():
return actionErrorCleared();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( DateTime? week)?  started,TResult? Function( int delta)?  weekShifted,TResult? Function( int virtueId,  int dayIndex,  int amount)?  strikeUpdated,TResult? Function( String noteUncontrolled,  String noteControlled)?  reflectionSaved,TResult? Function()?  actionErrorCleared,}) {final _that = this;
switch (_that) {
case JournalStarted() when started != null:
return started(_that.week);case JournalWeekShifted() when weekShifted != null:
return weekShifted(_that.delta);case StrikeUpdated() when strikeUpdated != null:
return strikeUpdated(_that.virtueId,_that.dayIndex,_that.amount);case ReflectionSaved() when reflectionSaved != null:
return reflectionSaved(_that.noteUncontrolled,_that.noteControlled);case JournalActionErrorCleared() when actionErrorCleared != null:
return actionErrorCleared();case _:
  return null;

}
}

}

/// @nodoc


class JournalStarted implements JournalEvent {
  const JournalStarted({this.week});
  

 final  DateTime? week;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalStartedCopyWith<JournalStarted> get copyWith => _$JournalStartedCopyWithImpl<JournalStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalStarted&&(identical(other.week, week) || other.week == week));
}


@override
int get hashCode => Object.hash(runtimeType,week);

@override
String toString() {
  return 'JournalEvent.started(week: $week)';
}


}

/// @nodoc
abstract mixin class $JournalStartedCopyWith<$Res> implements $JournalEventCopyWith<$Res> {
  factory $JournalStartedCopyWith(JournalStarted value, $Res Function(JournalStarted) _then) = _$JournalStartedCopyWithImpl;
@useResult
$Res call({
 DateTime? week
});




}
/// @nodoc
class _$JournalStartedCopyWithImpl<$Res>
    implements $JournalStartedCopyWith<$Res> {
  _$JournalStartedCopyWithImpl(this._self, this._then);

  final JournalStarted _self;
  final $Res Function(JournalStarted) _then;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? week = freezed,}) {
  return _then(JournalStarted(
week: freezed == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class JournalWeekShifted implements JournalEvent {
  const JournalWeekShifted({required this.delta});
  

 final  int delta;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalWeekShiftedCopyWith<JournalWeekShifted> get copyWith => _$JournalWeekShiftedCopyWithImpl<JournalWeekShifted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalWeekShifted&&(identical(other.delta, delta) || other.delta == delta));
}


@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'JournalEvent.weekShifted(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $JournalWeekShiftedCopyWith<$Res> implements $JournalEventCopyWith<$Res> {
  factory $JournalWeekShiftedCopyWith(JournalWeekShifted value, $Res Function(JournalWeekShifted) _then) = _$JournalWeekShiftedCopyWithImpl;
@useResult
$Res call({
 int delta
});




}
/// @nodoc
class _$JournalWeekShiftedCopyWithImpl<$Res>
    implements $JournalWeekShiftedCopyWith<$Res> {
  _$JournalWeekShiftedCopyWithImpl(this._self, this._then);

  final JournalWeekShifted _self;
  final $Res Function(JournalWeekShifted) _then;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? delta = null,}) {
  return _then(JournalWeekShifted(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class StrikeUpdated implements JournalEvent {
  const StrikeUpdated({required this.virtueId, required this.dayIndex, required this.amount});
  

 final  int virtueId;
 final  int dayIndex;
 final  int amount;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StrikeUpdatedCopyWith<StrikeUpdated> get copyWith => _$StrikeUpdatedCopyWithImpl<StrikeUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StrikeUpdated&&(identical(other.virtueId, virtueId) || other.virtueId == virtueId)&&(identical(other.dayIndex, dayIndex) || other.dayIndex == dayIndex)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,virtueId,dayIndex,amount);

@override
String toString() {
  return 'JournalEvent.strikeUpdated(virtueId: $virtueId, dayIndex: $dayIndex, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $StrikeUpdatedCopyWith<$Res> implements $JournalEventCopyWith<$Res> {
  factory $StrikeUpdatedCopyWith(StrikeUpdated value, $Res Function(StrikeUpdated) _then) = _$StrikeUpdatedCopyWithImpl;
@useResult
$Res call({
 int virtueId, int dayIndex, int amount
});




}
/// @nodoc
class _$StrikeUpdatedCopyWithImpl<$Res>
    implements $StrikeUpdatedCopyWith<$Res> {
  _$StrikeUpdatedCopyWithImpl(this._self, this._then);

  final StrikeUpdated _self;
  final $Res Function(StrikeUpdated) _then;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? virtueId = null,Object? dayIndex = null,Object? amount = null,}) {
  return _then(StrikeUpdated(
virtueId: null == virtueId ? _self.virtueId : virtueId // ignore: cast_nullable_to_non_nullable
as int,dayIndex: null == dayIndex ? _self.dayIndex : dayIndex // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ReflectionSaved implements JournalEvent {
  const ReflectionSaved({required this.noteUncontrolled, required this.noteControlled});
  

 final  String noteUncontrolled;
 final  String noteControlled;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReflectionSavedCopyWith<ReflectionSaved> get copyWith => _$ReflectionSavedCopyWithImpl<ReflectionSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReflectionSaved&&(identical(other.noteUncontrolled, noteUncontrolled) || other.noteUncontrolled == noteUncontrolled)&&(identical(other.noteControlled, noteControlled) || other.noteControlled == noteControlled));
}


@override
int get hashCode => Object.hash(runtimeType,noteUncontrolled,noteControlled);

@override
String toString() {
  return 'JournalEvent.reflectionSaved(noteUncontrolled: $noteUncontrolled, noteControlled: $noteControlled)';
}


}

/// @nodoc
abstract mixin class $ReflectionSavedCopyWith<$Res> implements $JournalEventCopyWith<$Res> {
  factory $ReflectionSavedCopyWith(ReflectionSaved value, $Res Function(ReflectionSaved) _then) = _$ReflectionSavedCopyWithImpl;
@useResult
$Res call({
 String noteUncontrolled, String noteControlled
});




}
/// @nodoc
class _$ReflectionSavedCopyWithImpl<$Res>
    implements $ReflectionSavedCopyWith<$Res> {
  _$ReflectionSavedCopyWithImpl(this._self, this._then);

  final ReflectionSaved _self;
  final $Res Function(ReflectionSaved) _then;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? noteUncontrolled = null,Object? noteControlled = null,}) {
  return _then(ReflectionSaved(
noteUncontrolled: null == noteUncontrolled ? _self.noteUncontrolled : noteUncontrolled // ignore: cast_nullable_to_non_nullable
as String,noteControlled: null == noteControlled ? _self.noteControlled : noteControlled // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class JournalActionErrorCleared implements JournalEvent {
  const JournalActionErrorCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalActionErrorCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JournalEvent.actionErrorCleared()';
}


}




/// @nodoc
mixin _$JournalState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JournalState()';
}


}

/// @nodoc
class $JournalStateCopyWith<$Res>  {
$JournalStateCopyWith(JournalState _, $Res Function(JournalState) __);
}


/// Adds pattern-matching-related methods to [JournalState].
extension JournalStatePatterns on JournalState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( JournalInitial value)?  initial,TResult Function( JournalLoading value)?  loading,TResult Function( JournalLoaded value)?  loaded,TResult Function( JournalFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case JournalInitial() when initial != null:
return initial(_that);case JournalLoading() when loading != null:
return loading(_that);case JournalLoaded() when loaded != null:
return loaded(_that);case JournalFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( JournalInitial value)  initial,required TResult Function( JournalLoading value)  loading,required TResult Function( JournalLoaded value)  loaded,required TResult Function( JournalFailure value)  failure,}){
final _that = this;
switch (_that) {
case JournalInitial():
return initial(_that);case JournalLoading():
return loading(_that);case JournalLoaded():
return loaded(_that);case JournalFailure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( JournalInitial value)?  initial,TResult? Function( JournalLoading value)?  loading,TResult? Function( JournalLoaded value)?  loaded,TResult? Function( JournalFailure value)?  failure,}){
final _that = this;
switch (_that) {
case JournalInitial() when initial != null:
return initial(_that);case JournalLoading() when loading != null:
return loading(_that);case JournalLoaded() when loaded != null:
return loaded(_that);case JournalFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<UIFranklinVirtue> virtues,  int focusWeekNumber,  DateTime weekStart,  bool canGoPrev,  bool canGoNext,  String? actionError)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case JournalInitial() when initial != null:
return initial();case JournalLoading() when loading != null:
return loading();case JournalLoaded() when loaded != null:
return loaded(_that.virtues,_that.focusWeekNumber,_that.weekStart,_that.canGoPrev,_that.canGoNext,_that.actionError);case JournalFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<UIFranklinVirtue> virtues,  int focusWeekNumber,  DateTime weekStart,  bool canGoPrev,  bool canGoNext,  String? actionError)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case JournalInitial():
return initial();case JournalLoading():
return loading();case JournalLoaded():
return loaded(_that.virtues,_that.focusWeekNumber,_that.weekStart,_that.canGoPrev,_that.canGoNext,_that.actionError);case JournalFailure():
return failure(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<UIFranklinVirtue> virtues,  int focusWeekNumber,  DateTime weekStart,  bool canGoPrev,  bool canGoNext,  String? actionError)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case JournalInitial() when initial != null:
return initial();case JournalLoading() when loading != null:
return loading();case JournalLoaded() when loaded != null:
return loaded(_that.virtues,_that.focusWeekNumber,_that.weekStart,_that.canGoPrev,_that.canGoNext,_that.actionError);case JournalFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class JournalInitial implements JournalState {
  const JournalInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JournalState.initial()';
}


}




/// @nodoc


class JournalLoading implements JournalState {
  const JournalLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JournalState.loading()';
}


}




/// @nodoc


class JournalLoaded implements JournalState {
  const JournalLoaded({required final  List<UIFranklinVirtue> virtues, required this.focusWeekNumber, required this.weekStart, this.canGoPrev = false, this.canGoNext = false, this.actionError}): _virtues = virtues;
  

 final  List<UIFranklinVirtue> _virtues;
 List<UIFranklinVirtue> get virtues {
  if (_virtues is EqualUnmodifiableListView) return _virtues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_virtues);
}

 final  int focusWeekNumber;
 final  DateTime weekStart;
@JsonKey() final  bool canGoPrev;
@JsonKey() final  bool canGoNext;
 final  String? actionError;

/// Create a copy of JournalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalLoadedCopyWith<JournalLoaded> get copyWith => _$JournalLoadedCopyWithImpl<JournalLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalLoaded&&const DeepCollectionEquality().equals(other._virtues, _virtues)&&(identical(other.focusWeekNumber, focusWeekNumber) || other.focusWeekNumber == focusWeekNumber)&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.canGoPrev, canGoPrev) || other.canGoPrev == canGoPrev)&&(identical(other.canGoNext, canGoNext) || other.canGoNext == canGoNext)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_virtues),focusWeekNumber,weekStart,canGoPrev,canGoNext,actionError);

@override
String toString() {
  return 'JournalState.loaded(virtues: $virtues, focusWeekNumber: $focusWeekNumber, weekStart: $weekStart, canGoPrev: $canGoPrev, canGoNext: $canGoNext, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class $JournalLoadedCopyWith<$Res> implements $JournalStateCopyWith<$Res> {
  factory $JournalLoadedCopyWith(JournalLoaded value, $Res Function(JournalLoaded) _then) = _$JournalLoadedCopyWithImpl;
@useResult
$Res call({
 List<UIFranklinVirtue> virtues, int focusWeekNumber, DateTime weekStart, bool canGoPrev, bool canGoNext, String? actionError
});




}
/// @nodoc
class _$JournalLoadedCopyWithImpl<$Res>
    implements $JournalLoadedCopyWith<$Res> {
  _$JournalLoadedCopyWithImpl(this._self, this._then);

  final JournalLoaded _self;
  final $Res Function(JournalLoaded) _then;

/// Create a copy of JournalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? virtues = null,Object? focusWeekNumber = null,Object? weekStart = null,Object? canGoPrev = null,Object? canGoNext = null,Object? actionError = freezed,}) {
  return _then(JournalLoaded(
virtues: null == virtues ? _self._virtues : virtues // ignore: cast_nullable_to_non_nullable
as List<UIFranklinVirtue>,focusWeekNumber: null == focusWeekNumber ? _self.focusWeekNumber : focusWeekNumber // ignore: cast_nullable_to_non_nullable
as int,weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as DateTime,canGoPrev: null == canGoPrev ? _self.canGoPrev : canGoPrev // ignore: cast_nullable_to_non_nullable
as bool,canGoNext: null == canGoNext ? _self.canGoNext : canGoNext // ignore: cast_nullable_to_non_nullable
as bool,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class JournalFailure implements JournalState {
  const JournalFailure(this.message);
  

 final  String message;

/// Create a copy of JournalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalFailureCopyWith<JournalFailure> get copyWith => _$JournalFailureCopyWithImpl<JournalFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'JournalState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $JournalFailureCopyWith<$Res> implements $JournalStateCopyWith<$Res> {
  factory $JournalFailureCopyWith(JournalFailure value, $Res Function(JournalFailure) _then) = _$JournalFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$JournalFailureCopyWithImpl<$Res>
    implements $JournalFailureCopyWith<$Res> {
  _$JournalFailureCopyWithImpl(this._self, this._then);

  final JournalFailure _self;
  final $Res Function(JournalFailure) _then;

/// Create a copy of JournalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(JournalFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
