// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'virtue_editor_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VirtueEditorEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VirtueEditorEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VirtueEditorEvent()';
}


}

/// @nodoc
class $VirtueEditorEventCopyWith<$Res>  {
$VirtueEditorEventCopyWith(VirtueEditorEvent _, $Res Function(VirtueEditorEvent) __);
}


/// Adds pattern-matching-related methods to [VirtueEditorEvent].
extension VirtueEditorEventPatterns on VirtueEditorEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VirtueEditorStarted value)?  started,TResult Function( VirtueDescriptionSaved value)?  descriptionSaved,TResult Function( VirtueEditorActionErrorCleared value)?  actionErrorCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VirtueEditorStarted() when started != null:
return started(_that);case VirtueDescriptionSaved() when descriptionSaved != null:
return descriptionSaved(_that);case VirtueEditorActionErrorCleared() when actionErrorCleared != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VirtueEditorStarted value)  started,required TResult Function( VirtueDescriptionSaved value)  descriptionSaved,required TResult Function( VirtueEditorActionErrorCleared value)  actionErrorCleared,}){
final _that = this;
switch (_that) {
case VirtueEditorStarted():
return started(_that);case VirtueDescriptionSaved():
return descriptionSaved(_that);case VirtueEditorActionErrorCleared():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VirtueEditorStarted value)?  started,TResult? Function( VirtueDescriptionSaved value)?  descriptionSaved,TResult? Function( VirtueEditorActionErrorCleared value)?  actionErrorCleared,}){
final _that = this;
switch (_that) {
case VirtueEditorStarted() when started != null:
return started(_that);case VirtueDescriptionSaved() when descriptionSaved != null:
return descriptionSaved(_that);case VirtueEditorActionErrorCleared() when actionErrorCleared != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( int virtueId,  String? customDescription)?  descriptionSaved,TResult Function()?  actionErrorCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VirtueEditorStarted() when started != null:
return started();case VirtueDescriptionSaved() when descriptionSaved != null:
return descriptionSaved(_that.virtueId,_that.customDescription);case VirtueEditorActionErrorCleared() when actionErrorCleared != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( int virtueId,  String? customDescription)  descriptionSaved,required TResult Function()  actionErrorCleared,}) {final _that = this;
switch (_that) {
case VirtueEditorStarted():
return started();case VirtueDescriptionSaved():
return descriptionSaved(_that.virtueId,_that.customDescription);case VirtueEditorActionErrorCleared():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( int virtueId,  String? customDescription)?  descriptionSaved,TResult? Function()?  actionErrorCleared,}) {final _that = this;
switch (_that) {
case VirtueEditorStarted() when started != null:
return started();case VirtueDescriptionSaved() when descriptionSaved != null:
return descriptionSaved(_that.virtueId,_that.customDescription);case VirtueEditorActionErrorCleared() when actionErrorCleared != null:
return actionErrorCleared();case _:
  return null;

}
}

}

/// @nodoc


class VirtueEditorStarted implements VirtueEditorEvent {
  const VirtueEditorStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VirtueEditorStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VirtueEditorEvent.started()';
}


}




/// @nodoc


class VirtueDescriptionSaved implements VirtueEditorEvent {
  const VirtueDescriptionSaved({required this.virtueId, required this.customDescription});
  

 final  int virtueId;
 final  String? customDescription;

/// Create a copy of VirtueEditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VirtueDescriptionSavedCopyWith<VirtueDescriptionSaved> get copyWith => _$VirtueDescriptionSavedCopyWithImpl<VirtueDescriptionSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VirtueDescriptionSaved&&(identical(other.virtueId, virtueId) || other.virtueId == virtueId)&&(identical(other.customDescription, customDescription) || other.customDescription == customDescription));
}


@override
int get hashCode => Object.hash(runtimeType,virtueId,customDescription);

@override
String toString() {
  return 'VirtueEditorEvent.descriptionSaved(virtueId: $virtueId, customDescription: $customDescription)';
}


}

/// @nodoc
abstract mixin class $VirtueDescriptionSavedCopyWith<$Res> implements $VirtueEditorEventCopyWith<$Res> {
  factory $VirtueDescriptionSavedCopyWith(VirtueDescriptionSaved value, $Res Function(VirtueDescriptionSaved) _then) = _$VirtueDescriptionSavedCopyWithImpl;
@useResult
$Res call({
 int virtueId, String? customDescription
});




}
/// @nodoc
class _$VirtueDescriptionSavedCopyWithImpl<$Res>
    implements $VirtueDescriptionSavedCopyWith<$Res> {
  _$VirtueDescriptionSavedCopyWithImpl(this._self, this._then);

  final VirtueDescriptionSaved _self;
  final $Res Function(VirtueDescriptionSaved) _then;

/// Create a copy of VirtueEditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? virtueId = null,Object? customDescription = freezed,}) {
  return _then(VirtueDescriptionSaved(
virtueId: null == virtueId ? _self.virtueId : virtueId // ignore: cast_nullable_to_non_nullable
as int,customDescription: freezed == customDescription ? _self.customDescription : customDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class VirtueEditorActionErrorCleared implements VirtueEditorEvent {
  const VirtueEditorActionErrorCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VirtueEditorActionErrorCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VirtueEditorEvent.actionErrorCleared()';
}


}




/// @nodoc
mixin _$VirtueEditorState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VirtueEditorState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VirtueEditorState()';
}


}

/// @nodoc
class $VirtueEditorStateCopyWith<$Res>  {
$VirtueEditorStateCopyWith(VirtueEditorState _, $Res Function(VirtueEditorState) __);
}


/// Adds pattern-matching-related methods to [VirtueEditorState].
extension VirtueEditorStatePatterns on VirtueEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VirtueEditorInitial value)?  initial,TResult Function( VirtueEditorLoading value)?  loading,TResult Function( VirtueEditorLoaded value)?  loaded,TResult Function( VirtueEditorFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VirtueEditorInitial() when initial != null:
return initial(_that);case VirtueEditorLoading() when loading != null:
return loading(_that);case VirtueEditorLoaded() when loaded != null:
return loaded(_that);case VirtueEditorFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VirtueEditorInitial value)  initial,required TResult Function( VirtueEditorLoading value)  loading,required TResult Function( VirtueEditorLoaded value)  loaded,required TResult Function( VirtueEditorFailure value)  failure,}){
final _that = this;
switch (_that) {
case VirtueEditorInitial():
return initial(_that);case VirtueEditorLoading():
return loading(_that);case VirtueEditorLoaded():
return loaded(_that);case VirtueEditorFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VirtueEditorInitial value)?  initial,TResult? Function( VirtueEditorLoading value)?  loading,TResult? Function( VirtueEditorLoaded value)?  loaded,TResult? Function( VirtueEditorFailure value)?  failure,}){
final _that = this;
switch (_that) {
case VirtueEditorInitial() when initial != null:
return initial(_that);case VirtueEditorLoading() when loading != null:
return loading(_that);case VirtueEditorLoaded() when loaded != null:
return loaded(_that);case VirtueEditorFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<FranklinVirtue> virtues,  String? actionError)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VirtueEditorInitial() when initial != null:
return initial();case VirtueEditorLoading() when loading != null:
return loading();case VirtueEditorLoaded() when loaded != null:
return loaded(_that.virtues,_that.actionError);case VirtueEditorFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<FranklinVirtue> virtues,  String? actionError)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case VirtueEditorInitial():
return initial();case VirtueEditorLoading():
return loading();case VirtueEditorLoaded():
return loaded(_that.virtues,_that.actionError);case VirtueEditorFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<FranklinVirtue> virtues,  String? actionError)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case VirtueEditorInitial() when initial != null:
return initial();case VirtueEditorLoading() when loading != null:
return loading();case VirtueEditorLoaded() when loaded != null:
return loaded(_that.virtues,_that.actionError);case VirtueEditorFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class VirtueEditorInitial implements VirtueEditorState {
  const VirtueEditorInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VirtueEditorInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VirtueEditorState.initial()';
}


}




/// @nodoc


class VirtueEditorLoading implements VirtueEditorState {
  const VirtueEditorLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VirtueEditorLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VirtueEditorState.loading()';
}


}




/// @nodoc


class VirtueEditorLoaded implements VirtueEditorState {
  const VirtueEditorLoaded({required final  List<FranklinVirtue> virtues, this.actionError}): _virtues = virtues;
  

 final  List<FranklinVirtue> _virtues;
 List<FranklinVirtue> get virtues {
  if (_virtues is EqualUnmodifiableListView) return _virtues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_virtues);
}

 final  String? actionError;

/// Create a copy of VirtueEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VirtueEditorLoadedCopyWith<VirtueEditorLoaded> get copyWith => _$VirtueEditorLoadedCopyWithImpl<VirtueEditorLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VirtueEditorLoaded&&const DeepCollectionEquality().equals(other._virtues, _virtues)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_virtues),actionError);

@override
String toString() {
  return 'VirtueEditorState.loaded(virtues: $virtues, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class $VirtueEditorLoadedCopyWith<$Res> implements $VirtueEditorStateCopyWith<$Res> {
  factory $VirtueEditorLoadedCopyWith(VirtueEditorLoaded value, $Res Function(VirtueEditorLoaded) _then) = _$VirtueEditorLoadedCopyWithImpl;
@useResult
$Res call({
 List<FranklinVirtue> virtues, String? actionError
});




}
/// @nodoc
class _$VirtueEditorLoadedCopyWithImpl<$Res>
    implements $VirtueEditorLoadedCopyWith<$Res> {
  _$VirtueEditorLoadedCopyWithImpl(this._self, this._then);

  final VirtueEditorLoaded _self;
  final $Res Function(VirtueEditorLoaded) _then;

/// Create a copy of VirtueEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? virtues = null,Object? actionError = freezed,}) {
  return _then(VirtueEditorLoaded(
virtues: null == virtues ? _self._virtues : virtues // ignore: cast_nullable_to_non_nullable
as List<FranklinVirtue>,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class VirtueEditorFailure implements VirtueEditorState {
  const VirtueEditorFailure(this.message);
  

 final  String message;

/// Create a copy of VirtueEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VirtueEditorFailureCopyWith<VirtueEditorFailure> get copyWith => _$VirtueEditorFailureCopyWithImpl<VirtueEditorFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VirtueEditorFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VirtueEditorState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $VirtueEditorFailureCopyWith<$Res> implements $VirtueEditorStateCopyWith<$Res> {
  factory $VirtueEditorFailureCopyWith(VirtueEditorFailure value, $Res Function(VirtueEditorFailure) _then) = _$VirtueEditorFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$VirtueEditorFailureCopyWithImpl<$Res>
    implements $VirtueEditorFailureCopyWith<$Res> {
  _$VirtueEditorFailureCopyWithImpl(this._self, this._then);

  final VirtueEditorFailure _self;
  final $Res Function(VirtueEditorFailure) _then;

/// Create a copy of VirtueEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(VirtueEditorFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
