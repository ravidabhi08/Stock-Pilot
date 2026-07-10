// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_index_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MarketIndexModel _$MarketIndexModelFromJson(Map<String, dynamic> json) {
  return _MarketIndexModel.fromJson(json);
}

/// @nodoc
mixin _$MarketIndexModel {
  /// The display name of the index (e.g., "Nifty 50", "S&P BSE Sensex").
  String get name => throw _privateConstructorUsedError;

  /// The ticker symbol or short code (e.g., "NIFTY", "SENSEX").
  String get symbol => throw _privateConstructorUsedError;

  /// The current value of the index.
  double get value => throw _privateConstructorUsedError;

  /// The absolute change in the index value from the previous close.
  double get change => throw _privateConstructorUsedError;

  /// The percentage change from the previous close.
  double get changePercent => throw _privateConstructorUsedError;

  /// Optional historical data points for rendering a sparkline chart.
  List<double>? get sparklineData => throw _privateConstructorUsedError;

  /// Serializes this MarketIndexModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarketIndexModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketIndexModelCopyWith<MarketIndexModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketIndexModelCopyWith<$Res> {
  factory $MarketIndexModelCopyWith(
          MarketIndexModel value, $Res Function(MarketIndexModel) then) =
      _$MarketIndexModelCopyWithImpl<$Res, MarketIndexModel>;
  @useResult
  $Res call(
      {String name,
      String symbol,
      double value,
      double change,
      double changePercent,
      List<double>? sparklineData});
}

/// @nodoc
class _$MarketIndexModelCopyWithImpl<$Res, $Val extends MarketIndexModel>
    implements $MarketIndexModelCopyWith<$Res> {
  _$MarketIndexModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketIndexModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? value = null,
    Object? change = null,
    Object? changePercent = null,
    Object? sparklineData = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
      changePercent: null == changePercent
          ? _value.changePercent
          : changePercent // ignore: cast_nullable_to_non_nullable
              as double,
      sparklineData: freezed == sparklineData
          ? _value.sparklineData
          : sparklineData // ignore: cast_nullable_to_non_nullable
              as List<double>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarketIndexModelImplCopyWith<$Res>
    implements $MarketIndexModelCopyWith<$Res> {
  factory _$$MarketIndexModelImplCopyWith(_$MarketIndexModelImpl value,
          $Res Function(_$MarketIndexModelImpl) then) =
      __$$MarketIndexModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String symbol,
      double value,
      double change,
      double changePercent,
      List<double>? sparklineData});
}

/// @nodoc
class __$$MarketIndexModelImplCopyWithImpl<$Res>
    extends _$MarketIndexModelCopyWithImpl<$Res, _$MarketIndexModelImpl>
    implements _$$MarketIndexModelImplCopyWith<$Res> {
  __$$MarketIndexModelImplCopyWithImpl(_$MarketIndexModelImpl _value,
      $Res Function(_$MarketIndexModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MarketIndexModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? value = null,
    Object? change = null,
    Object? changePercent = null,
    Object? sparklineData = freezed,
  }) {
    return _then(_$MarketIndexModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
      changePercent: null == changePercent
          ? _value.changePercent
          : changePercent // ignore: cast_nullable_to_non_nullable
              as double,
      sparklineData: freezed == sparklineData
          ? _value._sparklineData
          : sparklineData // ignore: cast_nullable_to_non_nullable
              as List<double>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MarketIndexModelImpl implements _MarketIndexModel {
  const _$MarketIndexModelImpl(
      {required this.name,
      required this.symbol,
      required this.value,
      required this.change,
      required this.changePercent,
      final List<double>? sparklineData = null})
      : _sparklineData = sparklineData;

  factory _$MarketIndexModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarketIndexModelImplFromJson(json);

  /// The display name of the index (e.g., "Nifty 50", "S&P BSE Sensex").
  @override
  final String name;

  /// The ticker symbol or short code (e.g., "NIFTY", "SENSEX").
  @override
  final String symbol;

  /// The current value of the index.
  @override
  final double value;

  /// The absolute change in the index value from the previous close.
  @override
  final double change;

  /// The percentage change from the previous close.
  @override
  final double changePercent;

  /// Optional historical data points for rendering a sparkline chart.
  final List<double>? _sparklineData;

  /// Optional historical data points for rendering a sparkline chart.
  @override
  @JsonKey()
  List<double>? get sparklineData {
    final value = _sparklineData;
    if (value == null) return null;
    if (_sparklineData is EqualUnmodifiableListView) return _sparklineData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MarketIndexModel(name: $name, symbol: $symbol, value: $value, change: $change, changePercent: $changePercent, sparklineData: $sparklineData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketIndexModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.changePercent, changePercent) ||
                other.changePercent == changePercent) &&
            const DeepCollectionEquality()
                .equals(other._sparklineData, _sparklineData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, symbol, value, change,
      changePercent, const DeepCollectionEquality().hash(_sparklineData));

  /// Create a copy of MarketIndexModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketIndexModelImplCopyWith<_$MarketIndexModelImpl> get copyWith =>
      __$$MarketIndexModelImplCopyWithImpl<_$MarketIndexModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarketIndexModelImplToJson(
      this,
    );
  }
}

abstract class _MarketIndexModel implements MarketIndexModel {
  const factory _MarketIndexModel(
      {required final String name,
      required final String symbol,
      required final double value,
      required final double change,
      required final double changePercent,
      final List<double>? sparklineData}) = _$MarketIndexModelImpl;

  factory _MarketIndexModel.fromJson(Map<String, dynamic> json) =
      _$MarketIndexModelImpl.fromJson;

  /// The display name of the index (e.g., "Nifty 50", "S&P BSE Sensex").
  @override
  String get name;

  /// The ticker symbol or short code (e.g., "NIFTY", "SENSEX").
  @override
  String get symbol;

  /// The current value of the index.
  @override
  double get value;

  /// The absolute change in the index value from the previous close.
  @override
  double get change;

  /// The percentage change from the previous close.
  @override
  double get changePercent;

  /// Optional historical data points for rendering a sparkline chart.
  @override
  List<double>? get sparklineData;

  /// Create a copy of MarketIndexModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketIndexModelImplCopyWith<_$MarketIndexModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
