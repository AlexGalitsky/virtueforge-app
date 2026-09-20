// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'temple_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TempleEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TempleEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TempleEvent()';
}


}

/// @nodoc
class $TempleEventCopyWith<$Res>  {
$TempleEventCopyWith(TempleEvent _, $Res Function(TempleEvent) __);
}


/// Adds pattern-matching-related methods to [TempleEvent].
extension TempleEventPatterns on TempleEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TempleStarted value)?  started,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TempleStarted() when started != null:
return started(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TempleStarted value)  started,}){
final _that = this;
switch (_that) {
case TempleStarted():
return started(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TempleStarted value)?  started,}){
final _that = this;
switch (_that) {
case TempleStarted() when started != null:
return started(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TempleStarted() when started != null:
return started();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,}) {final _that = this;
switch (_that) {
case TempleStarted():
return started();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,}) {final _that = this;
switch (_that) {
case TempleStarted() when started != null:
return started();case _:
  return null;

}
}

}

/// @nodoc


class TempleStarted implements TempleEvent {
  const TempleStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TempleStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TempleEvent.started()';
}


}




/// @nodoc
mixin _$TempleState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TempleState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TempleState()';
}


}

/// @nodoc
class $TempleStateCopyWith<$Res>  {
$TempleStateCopyWith(TempleState _, $Res Function(TempleState) __);
}


/// Adds pattern-matching-related methods to [TempleState].
extension TempleStatePatterns on TempleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TempleInitial value)?  initial,TResult Function( TempleLoading value)?  loading,TResult Function( TempleLoaded value)?  loaded,TResult Function( TempleFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TempleInitial() when initial != null:
return initial(_that);case TempleLoading() when loading != null:
return loading(_that);case TempleLoaded() when loaded != null:
return loaded(_that);case TempleFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TempleInitial value)  initial,required TResult Function( TempleLoading value)  loading,required TResult Function( TempleLoaded value)  loaded,required TResult Function( TempleFailure value)  failure,}){
final _that = this;
switch (_that) {
case TempleInitial():
return initial(_that);case TempleLoading():
return loading(_that);case TempleLoaded():
return loaded(_that);case TempleFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TempleInitial value)?  initial,TResult? Function( TempleLoading value)?  loading,TResult? Function( TempleLoaded value)?  loaded,TResult? Function( TempleFailure value)?  failure,}){
final _that = this;
switch (_that) {
case TempleInitial() when initial != null:
return initial(_that);case TempleLoading() when loading != null:
return loading(_that);case TempleLoaded() when loaded != null:
return loaded(_that);case TempleFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<UIStoicPillar> pillars,  int cycleInYear,  int cyclesPerYear)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TempleInitial() when initial != null:
return initial();case TempleLoading() when loading != null:
return loading();case TempleLoaded() when loaded != null:
return loaded(_that.pillars,_that.cycleInYear,_that.cyclesPerYear);case TempleFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<UIStoicPillar> pillars,  int cycleInYear,  int cyclesPerYear)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case TempleInitial():
return initial();case TempleLoading():
return loading();case TempleLoaded():
return loaded(_that.pillars,_that.cycleInYear,_that.cyclesPerYear);case TempleFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<UIStoicPillar> pillars,  int cycleInYear,  int cyclesPerYear)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case TempleInitial() when initial != null:
return initial();case TempleLoading() when loading != null:
return loading();case TempleLoaded() when loaded != null:
return loaded(_that.pillars,_that.cycleInYear,_that.cyclesPerYear);case TempleFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TempleInitial implements TempleState {
  const TempleInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TempleInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TempleState.initial()';
}


}




/// @nodoc


class TempleLoading implements TempleState {
  const TempleLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TempleLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TempleState.loading()';
}


}




/// @nodoc


class TempleLoaded implements TempleState {
  const TempleLoaded({required final  List<UIStoicPillar> pillars, required this.cycleInYear, required this.cyclesPerYear}): _pillars = pillars;
  

 final  List<UIStoicPillar> _pillars;
 List<UIStoicPillar> get pillars {
  if (_pillars is EqualUnmodifiableListView) return _pillars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pillars);
}

 final  int cycleInYear;
 final  int cyclesPerYear;

/// Create a copy of TempleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TempleLoadedCopyWith<TempleLoaded> get copyWith => _$TempleLoadedCopyWithImpl<TempleLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TempleLoaded&&const DeepCollectionEquality().equals(other._pillars, _pillars)&&(identical(other.cycleInYear, cycleInYear) || other.cycleInYear == cycleInYear)&&(identical(other.cyclesPerYear, cyclesPerYear) || other.cyclesPerYear == cyclesPerYear));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pillars),cycleInYear,cyclesPerYear);

@override
String toString() {
  return 'TempleState.loaded(pillars: $pillars, cycleInYear: $cycleInYear, cyclesPerYear: $cyclesPerYear)';
}


}

/// @nodoc
abstract mixin class $TempleLoadedCopyWith<$Res> implements $TempleStateCopyWith<$Res> {
  factory $TempleLoadedCopyWith(TempleLoaded value, $Res Function(TempleLoaded) _then) = _$TempleLoadedCopyWithImpl;
@useResult
$Res call({
 List<UIStoicPillar> pillars, int cycleInYear, int cyclesPerYear
});




}
/// @nodoc
class _$TempleLoadedCopyWithImpl<$Res>
    implements $TempleLoadedCopyWith<$Res> {
  _$TempleLoadedCopyWithImpl(this._self, this._then);

  final TempleLoaded _self;
  final $Res Function(TempleLoaded) _then;

/// Create a copy of TempleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pillars = null,Object? cycleInYear = null,Object? cyclesPerYear = null,}) {
  return _then(TempleLoaded(
pillars: null == pillars ? _self._pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<UIStoicPillar>,cycleInYear: null == cycleInYear ? _self.cycleInYear : cycleInYear // ignore: cast_nullable_to_non_nullable
as int,cyclesPerYear: null == cyclesPerYear ? _self.cyclesPerYear : cyclesPerYear // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class TempleFailure implements TempleState {
  const TempleFailure(this.message);
  

 final  String message;

/// Create a copy of TempleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TempleFailureCopyWith<TempleFailure> get copyWith => _$TempleFailureCopyWithImpl<TempleFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TempleFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TempleState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $TempleFailureCopyWith<$Res> implements $TempleStateCopyWith<$Res> {
  factory $TempleFailureCopyWith(TempleFailure value, $Res Function(TempleFailure) _then) = _$TempleFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TempleFailureCopyWithImpl<$Res>
    implements $TempleFailureCopyWith<$Res> {
  _$TempleFailureCopyWithImpl(this._self, this._then);

  final TempleFailure _self;
  final $Res Function(TempleFailure) _then;

/// Create a copy of TempleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TempleFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
