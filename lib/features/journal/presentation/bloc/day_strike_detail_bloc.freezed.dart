// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_strike_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DayStrikeDetailEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayStrikeDetailEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DayStrikeDetailEvent()';
}


}

/// @nodoc
class $DayStrikeDetailEventCopyWith<$Res>  {
$DayStrikeDetailEventCopyWith(DayStrikeDetailEvent _, $Res Function(DayStrikeDetailEvent) __);
}


/// Adds pattern-matching-related methods to [DayStrikeDetailEvent].
extension DayStrikeDetailEventPatterns on DayStrikeDetailEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DayStrikeDetailStarted value)?  started,TResult Function( DayStrikeDetailStrikeUpdated value)?  strikeUpdated,TResult Function( DayStrikeDetailNoteSaved value)?  noteSaved,TResult Function( DayStrikeDetailNoteDeleted value)?  noteDeleted,TResult Function( DayStrikeDetailActionErrorCleared value)?  actionErrorCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DayStrikeDetailStarted() when started != null:
return started(_that);case DayStrikeDetailStrikeUpdated() when strikeUpdated != null:
return strikeUpdated(_that);case DayStrikeDetailNoteSaved() when noteSaved != null:
return noteSaved(_that);case DayStrikeDetailNoteDeleted() when noteDeleted != null:
return noteDeleted(_that);case DayStrikeDetailActionErrorCleared() when actionErrorCleared != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DayStrikeDetailStarted value)  started,required TResult Function( DayStrikeDetailStrikeUpdated value)  strikeUpdated,required TResult Function( DayStrikeDetailNoteSaved value)  noteSaved,required TResult Function( DayStrikeDetailNoteDeleted value)  noteDeleted,required TResult Function( DayStrikeDetailActionErrorCleared value)  actionErrorCleared,}){
final _that = this;
switch (_that) {
case DayStrikeDetailStarted():
return started(_that);case DayStrikeDetailStrikeUpdated():
return strikeUpdated(_that);case DayStrikeDetailNoteSaved():
return noteSaved(_that);case DayStrikeDetailNoteDeleted():
return noteDeleted(_that);case DayStrikeDetailActionErrorCleared():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DayStrikeDetailStarted value)?  started,TResult? Function( DayStrikeDetailStrikeUpdated value)?  strikeUpdated,TResult? Function( DayStrikeDetailNoteSaved value)?  noteSaved,TResult? Function( DayStrikeDetailNoteDeleted value)?  noteDeleted,TResult? Function( DayStrikeDetailActionErrorCleared value)?  actionErrorCleared,}){
final _that = this;
switch (_that) {
case DayStrikeDetailStarted() when started != null:
return started(_that);case DayStrikeDetailStrikeUpdated() when strikeUpdated != null:
return strikeUpdated(_that);case DayStrikeDetailNoteSaved() when noteSaved != null:
return noteSaved(_that);case DayStrikeDetailNoteDeleted() when noteDeleted != null:
return noteDeleted(_that);case DayStrikeDetailActionErrorCleared() when actionErrorCleared != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int virtueId,  DateTime date)?  started,TResult Function( int amount)?  strikeUpdated,TResult Function( int ordinal,  String body)?  noteSaved,TResult Function( int ordinal)?  noteDeleted,TResult Function()?  actionErrorCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DayStrikeDetailStarted() when started != null:
return started(_that.virtueId,_that.date);case DayStrikeDetailStrikeUpdated() when strikeUpdated != null:
return strikeUpdated(_that.amount);case DayStrikeDetailNoteSaved() when noteSaved != null:
return noteSaved(_that.ordinal,_that.body);case DayStrikeDetailNoteDeleted() when noteDeleted != null:
return noteDeleted(_that.ordinal);case DayStrikeDetailActionErrorCleared() when actionErrorCleared != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int virtueId,  DateTime date)  started,required TResult Function( int amount)  strikeUpdated,required TResult Function( int ordinal,  String body)  noteSaved,required TResult Function( int ordinal)  noteDeleted,required TResult Function()  actionErrorCleared,}) {final _that = this;
switch (_that) {
case DayStrikeDetailStarted():
return started(_that.virtueId,_that.date);case DayStrikeDetailStrikeUpdated():
return strikeUpdated(_that.amount);case DayStrikeDetailNoteSaved():
return noteSaved(_that.ordinal,_that.body);case DayStrikeDetailNoteDeleted():
return noteDeleted(_that.ordinal);case DayStrikeDetailActionErrorCleared():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int virtueId,  DateTime date)?  started,TResult? Function( int amount)?  strikeUpdated,TResult? Function( int ordinal,  String body)?  noteSaved,TResult? Function( int ordinal)?  noteDeleted,TResult? Function()?  actionErrorCleared,}) {final _that = this;
switch (_that) {
case DayStrikeDetailStarted() when started != null:
return started(_that.virtueId,_that.date);case DayStrikeDetailStrikeUpdated() when strikeUpdated != null:
return strikeUpdated(_that.amount);case DayStrikeDetailNoteSaved() when noteSaved != null:
return noteSaved(_that.ordinal,_that.body);case DayStrikeDetailNoteDeleted() when noteDeleted != null:
return noteDeleted(_that.ordinal);case DayStrikeDetailActionErrorCleared() when actionErrorCleared != null:
return actionErrorCleared();case _:
  return null;

}
}

}

/// @nodoc


class DayStrikeDetailStarted implements DayStrikeDetailEvent {
  const DayStrikeDetailStarted({required this.virtueId, required this.date});
  

 final  int virtueId;
 final  DateTime date;

/// Create a copy of DayStrikeDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayStrikeDetailStartedCopyWith<DayStrikeDetailStarted> get copyWith => _$DayStrikeDetailStartedCopyWithImpl<DayStrikeDetailStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayStrikeDetailStarted&&(identical(other.virtueId, virtueId) || other.virtueId == virtueId)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,virtueId,date);

@override
String toString() {
  return 'DayStrikeDetailEvent.started(virtueId: $virtueId, date: $date)';
}


}

/// @nodoc
abstract mixin class $DayStrikeDetailStartedCopyWith<$Res> implements $DayStrikeDetailEventCopyWith<$Res> {
  factory $DayStrikeDetailStartedCopyWith(DayStrikeDetailStarted value, $Res Function(DayStrikeDetailStarted) _then) = _$DayStrikeDetailStartedCopyWithImpl;
@useResult
$Res call({
 int virtueId, DateTime date
});




}
/// @nodoc
class _$DayStrikeDetailStartedCopyWithImpl<$Res>
    implements $DayStrikeDetailStartedCopyWith<$Res> {
  _$DayStrikeDetailStartedCopyWithImpl(this._self, this._then);

  final DayStrikeDetailStarted _self;
  final $Res Function(DayStrikeDetailStarted) _then;

/// Create a copy of DayStrikeDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? virtueId = null,Object? date = null,}) {
  return _then(DayStrikeDetailStarted(
virtueId: null == virtueId ? _self.virtueId : virtueId // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class DayStrikeDetailStrikeUpdated implements DayStrikeDetailEvent {
  const DayStrikeDetailStrikeUpdated({required this.amount});
  

 final  int amount;

/// Create a copy of DayStrikeDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayStrikeDetailStrikeUpdatedCopyWith<DayStrikeDetailStrikeUpdated> get copyWith => _$DayStrikeDetailStrikeUpdatedCopyWithImpl<DayStrikeDetailStrikeUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayStrikeDetailStrikeUpdated&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'DayStrikeDetailEvent.strikeUpdated(amount: $amount)';
}


}

/// @nodoc
abstract mixin class $DayStrikeDetailStrikeUpdatedCopyWith<$Res> implements $DayStrikeDetailEventCopyWith<$Res> {
  factory $DayStrikeDetailStrikeUpdatedCopyWith(DayStrikeDetailStrikeUpdated value, $Res Function(DayStrikeDetailStrikeUpdated) _then) = _$DayStrikeDetailStrikeUpdatedCopyWithImpl;
@useResult
$Res call({
 int amount
});




}
/// @nodoc
class _$DayStrikeDetailStrikeUpdatedCopyWithImpl<$Res>
    implements $DayStrikeDetailStrikeUpdatedCopyWith<$Res> {
  _$DayStrikeDetailStrikeUpdatedCopyWithImpl(this._self, this._then);

  final DayStrikeDetailStrikeUpdated _self;
  final $Res Function(DayStrikeDetailStrikeUpdated) _then;

/// Create a copy of DayStrikeDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? amount = null,}) {
  return _then(DayStrikeDetailStrikeUpdated(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class DayStrikeDetailNoteSaved implements DayStrikeDetailEvent {
  const DayStrikeDetailNoteSaved({required this.ordinal, required this.body});
  

 final  int ordinal;
 final  String body;

/// Create a copy of DayStrikeDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayStrikeDetailNoteSavedCopyWith<DayStrikeDetailNoteSaved> get copyWith => _$DayStrikeDetailNoteSavedCopyWithImpl<DayStrikeDetailNoteSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayStrikeDetailNoteSaved&&(identical(other.ordinal, ordinal) || other.ordinal == ordinal)&&(identical(other.body, body) || other.body == body));
}


@override
int get hashCode => Object.hash(runtimeType,ordinal,body);

@override
String toString() {
  return 'DayStrikeDetailEvent.noteSaved(ordinal: $ordinal, body: $body)';
}


}

/// @nodoc
abstract mixin class $DayStrikeDetailNoteSavedCopyWith<$Res> implements $DayStrikeDetailEventCopyWith<$Res> {
  factory $DayStrikeDetailNoteSavedCopyWith(DayStrikeDetailNoteSaved value, $Res Function(DayStrikeDetailNoteSaved) _then) = _$DayStrikeDetailNoteSavedCopyWithImpl;
@useResult
$Res call({
 int ordinal, String body
});




}
/// @nodoc
class _$DayStrikeDetailNoteSavedCopyWithImpl<$Res>
    implements $DayStrikeDetailNoteSavedCopyWith<$Res> {
  _$DayStrikeDetailNoteSavedCopyWithImpl(this._self, this._then);

  final DayStrikeDetailNoteSaved _self;
  final $Res Function(DayStrikeDetailNoteSaved) _then;

/// Create a copy of DayStrikeDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ordinal = null,Object? body = null,}) {
  return _then(DayStrikeDetailNoteSaved(
ordinal: null == ordinal ? _self.ordinal : ordinal // ignore: cast_nullable_to_non_nullable
as int,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DayStrikeDetailNoteDeleted implements DayStrikeDetailEvent {
  const DayStrikeDetailNoteDeleted({required this.ordinal});
  

 final  int ordinal;

/// Create a copy of DayStrikeDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayStrikeDetailNoteDeletedCopyWith<DayStrikeDetailNoteDeleted> get copyWith => _$DayStrikeDetailNoteDeletedCopyWithImpl<DayStrikeDetailNoteDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayStrikeDetailNoteDeleted&&(identical(other.ordinal, ordinal) || other.ordinal == ordinal));
}


@override
int get hashCode => Object.hash(runtimeType,ordinal);

@override
String toString() {
  return 'DayStrikeDetailEvent.noteDeleted(ordinal: $ordinal)';
}


}

/// @nodoc
abstract mixin class $DayStrikeDetailNoteDeletedCopyWith<$Res> implements $DayStrikeDetailEventCopyWith<$Res> {
  factory $DayStrikeDetailNoteDeletedCopyWith(DayStrikeDetailNoteDeleted value, $Res Function(DayStrikeDetailNoteDeleted) _then) = _$DayStrikeDetailNoteDeletedCopyWithImpl;
@useResult
$Res call({
 int ordinal
});




}
/// @nodoc
class _$DayStrikeDetailNoteDeletedCopyWithImpl<$Res>
    implements $DayStrikeDetailNoteDeletedCopyWith<$Res> {
  _$DayStrikeDetailNoteDeletedCopyWithImpl(this._self, this._then);

  final DayStrikeDetailNoteDeleted _self;
  final $Res Function(DayStrikeDetailNoteDeleted) _then;

/// Create a copy of DayStrikeDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ordinal = null,}) {
  return _then(DayStrikeDetailNoteDeleted(
ordinal: null == ordinal ? _self.ordinal : ordinal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class DayStrikeDetailActionErrorCleared implements DayStrikeDetailEvent {
  const DayStrikeDetailActionErrorCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayStrikeDetailActionErrorCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DayStrikeDetailEvent.actionErrorCleared()';
}


}




/// @nodoc
mixin _$DayStrikeDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayStrikeDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DayStrikeDetailState()';
}


}

/// @nodoc
class $DayStrikeDetailStateCopyWith<$Res>  {
$DayStrikeDetailStateCopyWith(DayStrikeDetailState _, $Res Function(DayStrikeDetailState) __);
}


/// Adds pattern-matching-related methods to [DayStrikeDetailState].
extension DayStrikeDetailStatePatterns on DayStrikeDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DayStrikeDetailInitial value)?  initial,TResult Function( DayStrikeDetailLoading value)?  loading,TResult Function( DayStrikeDetailLoaded value)?  loaded,TResult Function( DayStrikeDetailFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DayStrikeDetailInitial() when initial != null:
return initial(_that);case DayStrikeDetailLoading() when loading != null:
return loading(_that);case DayStrikeDetailLoaded() when loaded != null:
return loaded(_that);case DayStrikeDetailFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DayStrikeDetailInitial value)  initial,required TResult Function( DayStrikeDetailLoading value)  loading,required TResult Function( DayStrikeDetailLoaded value)  loaded,required TResult Function( DayStrikeDetailFailure value)  failure,}){
final _that = this;
switch (_that) {
case DayStrikeDetailInitial():
return initial(_that);case DayStrikeDetailLoading():
return loading(_that);case DayStrikeDetailLoaded():
return loaded(_that);case DayStrikeDetailFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DayStrikeDetailInitial value)?  initial,TResult? Function( DayStrikeDetailLoading value)?  loading,TResult? Function( DayStrikeDetailLoaded value)?  loaded,TResult? Function( DayStrikeDetailFailure value)?  failure,}){
final _that = this;
switch (_that) {
case DayStrikeDetailInitial() when initial != null:
return initial(_that);case DayStrikeDetailLoading() when loading != null:
return loading(_that);case DayStrikeDetailLoaded() when loaded != null:
return loaded(_that);case DayStrikeDetailFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( FranklinVirtue virtue,  DateTime date,  int strikesCount,  List<StrikeNoteEntry> notes,  bool canEdit,  String? actionError)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DayStrikeDetailInitial() when initial != null:
return initial();case DayStrikeDetailLoading() when loading != null:
return loading();case DayStrikeDetailLoaded() when loaded != null:
return loaded(_that.virtue,_that.date,_that.strikesCount,_that.notes,_that.canEdit,_that.actionError);case DayStrikeDetailFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( FranklinVirtue virtue,  DateTime date,  int strikesCount,  List<StrikeNoteEntry> notes,  bool canEdit,  String? actionError)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case DayStrikeDetailInitial():
return initial();case DayStrikeDetailLoading():
return loading();case DayStrikeDetailLoaded():
return loaded(_that.virtue,_that.date,_that.strikesCount,_that.notes,_that.canEdit,_that.actionError);case DayStrikeDetailFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( FranklinVirtue virtue,  DateTime date,  int strikesCount,  List<StrikeNoteEntry> notes,  bool canEdit,  String? actionError)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case DayStrikeDetailInitial() when initial != null:
return initial();case DayStrikeDetailLoading() when loading != null:
return loading();case DayStrikeDetailLoaded() when loaded != null:
return loaded(_that.virtue,_that.date,_that.strikesCount,_that.notes,_that.canEdit,_that.actionError);case DayStrikeDetailFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class DayStrikeDetailInitial implements DayStrikeDetailState {
  const DayStrikeDetailInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayStrikeDetailInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DayStrikeDetailState.initial()';
}


}




/// @nodoc


class DayStrikeDetailLoading implements DayStrikeDetailState {
  const DayStrikeDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayStrikeDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DayStrikeDetailState.loading()';
}


}




/// @nodoc


class DayStrikeDetailLoaded implements DayStrikeDetailState {
  const DayStrikeDetailLoaded({required this.virtue, required this.date, required this.strikesCount, required final  List<StrikeNoteEntry> notes, required this.canEdit, this.actionError}): _notes = notes;
  

 final  FranklinVirtue virtue;
 final  DateTime date;
 final  int strikesCount;
 final  List<StrikeNoteEntry> _notes;
 List<StrikeNoteEntry> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}

 final  bool canEdit;
 final  String? actionError;

/// Create a copy of DayStrikeDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayStrikeDetailLoadedCopyWith<DayStrikeDetailLoaded> get copyWith => _$DayStrikeDetailLoadedCopyWithImpl<DayStrikeDetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayStrikeDetailLoaded&&(identical(other.virtue, virtue) || other.virtue == virtue)&&(identical(other.date, date) || other.date == date)&&(identical(other.strikesCount, strikesCount) || other.strikesCount == strikesCount)&&const DeepCollectionEquality().equals(other._notes, _notes)&&(identical(other.canEdit, canEdit) || other.canEdit == canEdit)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,virtue,date,strikesCount,const DeepCollectionEquality().hash(_notes),canEdit,actionError);

@override
String toString() {
  return 'DayStrikeDetailState.loaded(virtue: $virtue, date: $date, strikesCount: $strikesCount, notes: $notes, canEdit: $canEdit, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class $DayStrikeDetailLoadedCopyWith<$Res> implements $DayStrikeDetailStateCopyWith<$Res> {
  factory $DayStrikeDetailLoadedCopyWith(DayStrikeDetailLoaded value, $Res Function(DayStrikeDetailLoaded) _then) = _$DayStrikeDetailLoadedCopyWithImpl;
@useResult
$Res call({
 FranklinVirtue virtue, DateTime date, int strikesCount, List<StrikeNoteEntry> notes, bool canEdit, String? actionError
});




}
/// @nodoc
class _$DayStrikeDetailLoadedCopyWithImpl<$Res>
    implements $DayStrikeDetailLoadedCopyWith<$Res> {
  _$DayStrikeDetailLoadedCopyWithImpl(this._self, this._then);

  final DayStrikeDetailLoaded _self;
  final $Res Function(DayStrikeDetailLoaded) _then;

/// Create a copy of DayStrikeDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? virtue = null,Object? date = null,Object? strikesCount = null,Object? notes = null,Object? canEdit = null,Object? actionError = freezed,}) {
  return _then(DayStrikeDetailLoaded(
virtue: null == virtue ? _self.virtue : virtue // ignore: cast_nullable_to_non_nullable
as FranklinVirtue,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,strikesCount: null == strikesCount ? _self.strikesCount : strikesCount // ignore: cast_nullable_to_non_nullable
as int,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<StrikeNoteEntry>,canEdit: null == canEdit ? _self.canEdit : canEdit // ignore: cast_nullable_to_non_nullable
as bool,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class DayStrikeDetailFailure implements DayStrikeDetailState {
  const DayStrikeDetailFailure(this.message);
  

 final  String message;

/// Create a copy of DayStrikeDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayStrikeDetailFailureCopyWith<DayStrikeDetailFailure> get copyWith => _$DayStrikeDetailFailureCopyWithImpl<DayStrikeDetailFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayStrikeDetailFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DayStrikeDetailState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $DayStrikeDetailFailureCopyWith<$Res> implements $DayStrikeDetailStateCopyWith<$Res> {
  factory $DayStrikeDetailFailureCopyWith(DayStrikeDetailFailure value, $Res Function(DayStrikeDetailFailure) _then) = _$DayStrikeDetailFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DayStrikeDetailFailureCopyWithImpl<$Res>
    implements $DayStrikeDetailFailureCopyWith<$Res> {
  _$DayStrikeDetailFailureCopyWithImpl(this._self, this._then);

  final DayStrikeDetailFailure _self;
  final $Res Function(DayStrikeDetailFailure) _then;

/// Create a copy of DayStrikeDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DayStrikeDetailFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
