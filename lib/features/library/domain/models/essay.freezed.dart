// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'essay.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Essay {

 String get id; String get authorKey; String get title; String get snippet; List<int> get virtueWeekNumbers; String? get bodyPath; String? get sourceWork; String? get stoicCategory; String get locale; String? get analysisPath; bool get hasAnalysis;
/// Create a copy of Essay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EssayCopyWith<Essay> get copyWith => _$EssayCopyWithImpl<Essay>(this as Essay, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Essay&&(identical(other.id, id) || other.id == id)&&(identical(other.authorKey, authorKey) || other.authorKey == authorKey)&&(identical(other.title, title) || other.title == title)&&(identical(other.snippet, snippet) || other.snippet == snippet)&&const DeepCollectionEquality().equals(other.virtueWeekNumbers, virtueWeekNumbers)&&(identical(other.bodyPath, bodyPath) || other.bodyPath == bodyPath)&&(identical(other.sourceWork, sourceWork) || other.sourceWork == sourceWork)&&(identical(other.stoicCategory, stoicCategory) || other.stoicCategory == stoicCategory)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.analysisPath, analysisPath) || other.analysisPath == analysisPath)&&(identical(other.hasAnalysis, hasAnalysis) || other.hasAnalysis == hasAnalysis));
}


@override
int get hashCode => Object.hash(runtimeType,id,authorKey,title,snippet,const DeepCollectionEquality().hash(virtueWeekNumbers),bodyPath,sourceWork,stoicCategory,locale,analysisPath,hasAnalysis);

@override
String toString() {
  return 'Essay(id: $id, authorKey: $authorKey, title: $title, snippet: $snippet, virtueWeekNumbers: $virtueWeekNumbers, bodyPath: $bodyPath, sourceWork: $sourceWork, stoicCategory: $stoicCategory, locale: $locale, analysisPath: $analysisPath, hasAnalysis: $hasAnalysis)';
}


}

/// @nodoc
abstract mixin class $EssayCopyWith<$Res>  {
  factory $EssayCopyWith(Essay value, $Res Function(Essay) _then) = _$EssayCopyWithImpl;
@useResult
$Res call({
 String id, String authorKey, String title, String snippet, List<int> virtueWeekNumbers, String? bodyPath, String? sourceWork, String? stoicCategory, String locale, String? analysisPath, bool hasAnalysis
});




}
/// @nodoc
class _$EssayCopyWithImpl<$Res>
    implements $EssayCopyWith<$Res> {
  _$EssayCopyWithImpl(this._self, this._then);

  final Essay _self;
  final $Res Function(Essay) _then;

/// Create a copy of Essay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorKey = null,Object? title = null,Object? snippet = null,Object? virtueWeekNumbers = null,Object? bodyPath = freezed,Object? sourceWork = freezed,Object? stoicCategory = freezed,Object? locale = null,Object? analysisPath = freezed,Object? hasAnalysis = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorKey: null == authorKey ? _self.authorKey : authorKey // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,snippet: null == snippet ? _self.snippet : snippet // ignore: cast_nullable_to_non_nullable
as String,virtueWeekNumbers: null == virtueWeekNumbers ? _self.virtueWeekNumbers : virtueWeekNumbers // ignore: cast_nullable_to_non_nullable
as List<int>,bodyPath: freezed == bodyPath ? _self.bodyPath : bodyPath // ignore: cast_nullable_to_non_nullable
as String?,sourceWork: freezed == sourceWork ? _self.sourceWork : sourceWork // ignore: cast_nullable_to_non_nullable
as String?,stoicCategory: freezed == stoicCategory ? _self.stoicCategory : stoicCategory // ignore: cast_nullable_to_non_nullable
as String?,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,analysisPath: freezed == analysisPath ? _self.analysisPath : analysisPath // ignore: cast_nullable_to_non_nullable
as String?,hasAnalysis: null == hasAnalysis ? _self.hasAnalysis : hasAnalysis // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Essay].
extension EssayPatterns on Essay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Essay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Essay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Essay value)  $default,){
final _that = this;
switch (_that) {
case _Essay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Essay value)?  $default,){
final _that = this;
switch (_that) {
case _Essay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String authorKey,  String title,  String snippet,  List<int> virtueWeekNumbers,  String? bodyPath,  String? sourceWork,  String? stoicCategory,  String locale,  String? analysisPath,  bool hasAnalysis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Essay() when $default != null:
return $default(_that.id,_that.authorKey,_that.title,_that.snippet,_that.virtueWeekNumbers,_that.bodyPath,_that.sourceWork,_that.stoicCategory,_that.locale,_that.analysisPath,_that.hasAnalysis);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String authorKey,  String title,  String snippet,  List<int> virtueWeekNumbers,  String? bodyPath,  String? sourceWork,  String? stoicCategory,  String locale,  String? analysisPath,  bool hasAnalysis)  $default,) {final _that = this;
switch (_that) {
case _Essay():
return $default(_that.id,_that.authorKey,_that.title,_that.snippet,_that.virtueWeekNumbers,_that.bodyPath,_that.sourceWork,_that.stoicCategory,_that.locale,_that.analysisPath,_that.hasAnalysis);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String authorKey,  String title,  String snippet,  List<int> virtueWeekNumbers,  String? bodyPath,  String? sourceWork,  String? stoicCategory,  String locale,  String? analysisPath,  bool hasAnalysis)?  $default,) {final _that = this;
switch (_that) {
case _Essay() when $default != null:
return $default(_that.id,_that.authorKey,_that.title,_that.snippet,_that.virtueWeekNumbers,_that.bodyPath,_that.sourceWork,_that.stoicCategory,_that.locale,_that.analysisPath,_that.hasAnalysis);case _:
  return null;

}
}

}

/// @nodoc


class _Essay extends Essay {
  const _Essay({required this.id, required this.authorKey, required this.title, required this.snippet, final  List<int> virtueWeekNumbers = const [], this.bodyPath, this.sourceWork, this.stoicCategory, this.locale = 'ru', this.analysisPath, this.hasAnalysis = false}): _virtueWeekNumbers = virtueWeekNumbers,super._();
  

@override final  String id;
@override final  String authorKey;
@override final  String title;
@override final  String snippet;
 final  List<int> _virtueWeekNumbers;
@override@JsonKey() List<int> get virtueWeekNumbers {
  if (_virtueWeekNumbers is EqualUnmodifiableListView) return _virtueWeekNumbers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_virtueWeekNumbers);
}

@override final  String? bodyPath;
@override final  String? sourceWork;
@override final  String? stoicCategory;
@override@JsonKey() final  String locale;
@override final  String? analysisPath;
@override@JsonKey() final  bool hasAnalysis;

/// Create a copy of Essay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EssayCopyWith<_Essay> get copyWith => __$EssayCopyWithImpl<_Essay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Essay&&(identical(other.id, id) || other.id == id)&&(identical(other.authorKey, authorKey) || other.authorKey == authorKey)&&(identical(other.title, title) || other.title == title)&&(identical(other.snippet, snippet) || other.snippet == snippet)&&const DeepCollectionEquality().equals(other._virtueWeekNumbers, _virtueWeekNumbers)&&(identical(other.bodyPath, bodyPath) || other.bodyPath == bodyPath)&&(identical(other.sourceWork, sourceWork) || other.sourceWork == sourceWork)&&(identical(other.stoicCategory, stoicCategory) || other.stoicCategory == stoicCategory)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.analysisPath, analysisPath) || other.analysisPath == analysisPath)&&(identical(other.hasAnalysis, hasAnalysis) || other.hasAnalysis == hasAnalysis));
}


@override
int get hashCode => Object.hash(runtimeType,id,authorKey,title,snippet,const DeepCollectionEquality().hash(_virtueWeekNumbers),bodyPath,sourceWork,stoicCategory,locale,analysisPath,hasAnalysis);

@override
String toString() {
  return 'Essay(id: $id, authorKey: $authorKey, title: $title, snippet: $snippet, virtueWeekNumbers: $virtueWeekNumbers, bodyPath: $bodyPath, sourceWork: $sourceWork, stoicCategory: $stoicCategory, locale: $locale, analysisPath: $analysisPath, hasAnalysis: $hasAnalysis)';
}


}

/// @nodoc
abstract mixin class _$EssayCopyWith<$Res> implements $EssayCopyWith<$Res> {
  factory _$EssayCopyWith(_Essay value, $Res Function(_Essay) _then) = __$EssayCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorKey, String title, String snippet, List<int> virtueWeekNumbers, String? bodyPath, String? sourceWork, String? stoicCategory, String locale, String? analysisPath, bool hasAnalysis
});




}
/// @nodoc
class __$EssayCopyWithImpl<$Res>
    implements _$EssayCopyWith<$Res> {
  __$EssayCopyWithImpl(this._self, this._then);

  final _Essay _self;
  final $Res Function(_Essay) _then;

/// Create a copy of Essay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorKey = null,Object? title = null,Object? snippet = null,Object? virtueWeekNumbers = null,Object? bodyPath = freezed,Object? sourceWork = freezed,Object? stoicCategory = freezed,Object? locale = null,Object? analysisPath = freezed,Object? hasAnalysis = null,}) {
  return _then(_Essay(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorKey: null == authorKey ? _self.authorKey : authorKey // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,snippet: null == snippet ? _self.snippet : snippet // ignore: cast_nullable_to_non_nullable
as String,virtueWeekNumbers: null == virtueWeekNumbers ? _self._virtueWeekNumbers : virtueWeekNumbers // ignore: cast_nullable_to_non_nullable
as List<int>,bodyPath: freezed == bodyPath ? _self.bodyPath : bodyPath // ignore: cast_nullable_to_non_nullable
as String?,sourceWork: freezed == sourceWork ? _self.sourceWork : sourceWork // ignore: cast_nullable_to_non_nullable
as String?,stoicCategory: freezed == stoicCategory ? _self.stoicCategory : stoicCategory // ignore: cast_nullable_to_non_nullable
as String?,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,analysisPath: freezed == analysisPath ? _self.analysisPath : analysisPath // ignore: cast_nullable_to_non_nullable
as String?,hasAnalysis: null == hasAnalysis ? _self.hasAnalysis : hasAnalysis // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
