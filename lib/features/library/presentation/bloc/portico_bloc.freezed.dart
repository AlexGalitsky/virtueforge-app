// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portico_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PorticoEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PorticoEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PorticoEvent()';
}


}

/// @nodoc
class $PorticoEventCopyWith<$Res>  {
$PorticoEventCopyWith(PorticoEvent _, $Res Function(PorticoEvent) __);
}


/// Adds pattern-matching-related methods to [PorticoEvent].
extension PorticoEventPatterns on PorticoEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PorticoStarted value)?  started,TResult Function( PorticoRandomThoughtRequested value)?  randomThoughtRequested,TResult Function( PorticoActionErrorCleared value)?  actionErrorCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PorticoStarted() when started != null:
return started(_that);case PorticoRandomThoughtRequested() when randomThoughtRequested != null:
return randomThoughtRequested(_that);case PorticoActionErrorCleared() when actionErrorCleared != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PorticoStarted value)  started,required TResult Function( PorticoRandomThoughtRequested value)  randomThoughtRequested,required TResult Function( PorticoActionErrorCleared value)  actionErrorCleared,}){
final _that = this;
switch (_that) {
case PorticoStarted():
return started(_that);case PorticoRandomThoughtRequested():
return randomThoughtRequested(_that);case PorticoActionErrorCleared():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PorticoStarted value)?  started,TResult? Function( PorticoRandomThoughtRequested value)?  randomThoughtRequested,TResult? Function( PorticoActionErrorCleared value)?  actionErrorCleared,}){
final _that = this;
switch (_that) {
case PorticoStarted() when started != null:
return started(_that);case PorticoRandomThoughtRequested() when randomThoughtRequested != null:
return randomThoughtRequested(_that);case PorticoActionErrorCleared() when actionErrorCleared != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  randomThoughtRequested,TResult Function()?  actionErrorCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PorticoStarted() when started != null:
return started();case PorticoRandomThoughtRequested() when randomThoughtRequested != null:
return randomThoughtRequested();case PorticoActionErrorCleared() when actionErrorCleared != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  randomThoughtRequested,required TResult Function()  actionErrorCleared,}) {final _that = this;
switch (_that) {
case PorticoStarted():
return started();case PorticoRandomThoughtRequested():
return randomThoughtRequested();case PorticoActionErrorCleared():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  randomThoughtRequested,TResult? Function()?  actionErrorCleared,}) {final _that = this;
switch (_that) {
case PorticoStarted() when started != null:
return started();case PorticoRandomThoughtRequested() when randomThoughtRequested != null:
return randomThoughtRequested();case PorticoActionErrorCleared() when actionErrorCleared != null:
return actionErrorCleared();case _:
  return null;

}
}

}

/// @nodoc


class PorticoStarted implements PorticoEvent {
  const PorticoStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PorticoStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PorticoEvent.started()';
}


}




/// @nodoc


class PorticoRandomThoughtRequested implements PorticoEvent {
  const PorticoRandomThoughtRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PorticoRandomThoughtRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PorticoEvent.randomThoughtRequested()';
}


}




/// @nodoc


class PorticoActionErrorCleared implements PorticoEvent {
  const PorticoActionErrorCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PorticoActionErrorCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PorticoEvent.actionErrorCleared()';
}


}




/// @nodoc
mixin _$PorticoState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PorticoState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PorticoState()';
}


}

/// @nodoc
class $PorticoStateCopyWith<$Res>  {
$PorticoStateCopyWith(PorticoState _, $Res Function(PorticoState) __);
}


/// Adds pattern-matching-related methods to [PorticoState].
extension PorticoStatePatterns on PorticoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PorticoInitial value)?  initial,TResult Function( PorticoLoading value)?  loading,TResult Function( PorticoLoaded value)?  loaded,TResult Function( PorticoFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PorticoInitial() when initial != null:
return initial(_that);case PorticoLoading() when loading != null:
return loading(_that);case PorticoLoaded() when loaded != null:
return loaded(_that);case PorticoFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PorticoInitial value)  initial,required TResult Function( PorticoLoading value)  loading,required TResult Function( PorticoLoaded value)  loaded,required TResult Function( PorticoFailure value)  failure,}){
final _that = this;
switch (_that) {
case PorticoInitial():
return initial(_that);case PorticoLoading():
return loading(_that);case PorticoLoaded():
return loaded(_that);case PorticoFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PorticoInitial value)?  initial,TResult? Function( PorticoLoading value)?  loading,TResult? Function( PorticoLoaded value)?  loaded,TResult? Function( PorticoFailure value)?  failure,}){
final _that = this;
switch (_that) {
case PorticoInitial() when initial != null:
return initial(_that);case PorticoLoading() when loading != null:
return loading(_that);case PorticoLoaded() when loaded != null:
return loaded(_that);case PorticoFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Essay> essays,  int focusWeekNumber,  Essay? randomThought,  String? actionError)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PorticoInitial() when initial != null:
return initial();case PorticoLoading() when loading != null:
return loading();case PorticoLoaded() when loaded != null:
return loaded(_that.essays,_that.focusWeekNumber,_that.randomThought,_that.actionError);case PorticoFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Essay> essays,  int focusWeekNumber,  Essay? randomThought,  String? actionError)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case PorticoInitial():
return initial();case PorticoLoading():
return loading();case PorticoLoaded():
return loaded(_that.essays,_that.focusWeekNumber,_that.randomThought,_that.actionError);case PorticoFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Essay> essays,  int focusWeekNumber,  Essay? randomThought,  String? actionError)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case PorticoInitial() when initial != null:
return initial();case PorticoLoading() when loading != null:
return loading();case PorticoLoaded() when loaded != null:
return loaded(_that.essays,_that.focusWeekNumber,_that.randomThought,_that.actionError);case PorticoFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class PorticoInitial implements PorticoState {
  const PorticoInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PorticoInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PorticoState.initial()';
}


}




/// @nodoc


class PorticoLoading implements PorticoState {
  const PorticoLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PorticoLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PorticoState.loading()';
}


}




/// @nodoc


class PorticoLoaded implements PorticoState {
  const PorticoLoaded({required final  List<Essay> essays, required this.focusWeekNumber, this.randomThought, this.actionError}): _essays = essays;
  

 final  List<Essay> _essays;
 List<Essay> get essays {
  if (_essays is EqualUnmodifiableListView) return _essays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_essays);
}

 final  int focusWeekNumber;
 final  Essay? randomThought;
 final  String? actionError;

/// Create a copy of PorticoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PorticoLoadedCopyWith<PorticoLoaded> get copyWith => _$PorticoLoadedCopyWithImpl<PorticoLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PorticoLoaded&&const DeepCollectionEquality().equals(other._essays, _essays)&&(identical(other.focusWeekNumber, focusWeekNumber) || other.focusWeekNumber == focusWeekNumber)&&(identical(other.randomThought, randomThought) || other.randomThought == randomThought)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_essays),focusWeekNumber,randomThought,actionError);

@override
String toString() {
  return 'PorticoState.loaded(essays: $essays, focusWeekNumber: $focusWeekNumber, randomThought: $randomThought, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class $PorticoLoadedCopyWith<$Res> implements $PorticoStateCopyWith<$Res> {
  factory $PorticoLoadedCopyWith(PorticoLoaded value, $Res Function(PorticoLoaded) _then) = _$PorticoLoadedCopyWithImpl;
@useResult
$Res call({
 List<Essay> essays, int focusWeekNumber, Essay? randomThought, String? actionError
});


$EssayCopyWith<$Res>? get randomThought;

}
/// @nodoc
class _$PorticoLoadedCopyWithImpl<$Res>
    implements $PorticoLoadedCopyWith<$Res> {
  _$PorticoLoadedCopyWithImpl(this._self, this._then);

  final PorticoLoaded _self;
  final $Res Function(PorticoLoaded) _then;

/// Create a copy of PorticoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? essays = null,Object? focusWeekNumber = null,Object? randomThought = freezed,Object? actionError = freezed,}) {
  return _then(PorticoLoaded(
essays: null == essays ? _self._essays : essays // ignore: cast_nullable_to_non_nullable
as List<Essay>,focusWeekNumber: null == focusWeekNumber ? _self.focusWeekNumber : focusWeekNumber // ignore: cast_nullable_to_non_nullable
as int,randomThought: freezed == randomThought ? _self.randomThought : randomThought // ignore: cast_nullable_to_non_nullable
as Essay?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PorticoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EssayCopyWith<$Res>? get randomThought {
    if (_self.randomThought == null) {
    return null;
  }

  return $EssayCopyWith<$Res>(_self.randomThought!, (value) {
    return _then(_self.copyWith(randomThought: value));
  });
}
}

/// @nodoc


class PorticoFailure implements PorticoState {
  const PorticoFailure(this.message);
  

 final  String message;

/// Create a copy of PorticoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PorticoFailureCopyWith<PorticoFailure> get copyWith => _$PorticoFailureCopyWithImpl<PorticoFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PorticoFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PorticoState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $PorticoFailureCopyWith<$Res> implements $PorticoStateCopyWith<$Res> {
  factory $PorticoFailureCopyWith(PorticoFailure value, $Res Function(PorticoFailure) _then) = _$PorticoFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PorticoFailureCopyWithImpl<$Res>
    implements $PorticoFailureCopyWith<$Res> {
  _$PorticoFailureCopyWithImpl(this._self, this._then);

  final PorticoFailure _self;
  final $Res Function(PorticoFailure) _then;

/// Create a copy of PorticoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PorticoFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
