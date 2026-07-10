// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StockModel _$StockModelFromJson(Map<String, dynamic> json) {
  return _StockModel.fromJson(json);
}

/// @nodoc
mixin _$StockModel {
  /// The stock ticker symbol (e.g., "RELIANCE", "TCS").
  String get symbol => throw _privateConstructorUsedError;

  /// The full name of the company.
  String get companyName => throw _privateConstructorUsedError;

  /// The current market price (Last Traded Price).
  double get currentPrice => throw _privateConstructorUsedError;

  /// The absolute change in price from the previous close.
  double get change => throw _privateConstructorUsedError;

  /// The percentage change from the previous close.
  double get changePercent => throw _privateConstructorUsedError;

  /// The total trading volume.
  double get volume => throw _privateConstructorUsedError;

  /// The market capitalization of the company (in INR).
  double? get marketCap => throw _privateConstructorUsedError;

  /// The 52-week high price.
  double? get high52Week => throw _privateConstructorUsedError;

  /// The 52-week low price.
  double? get low52Week => throw _privateConstructorUsedError;

  /// Optional historical data points for a sparkline chart.
  List<double>? get sparklineData => throw _privateConstructorUsedError;

  /// Serializes this StockModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockModelCopyWith<StockModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockModelCopyWith<$Res> {
  factory $StockModelCopyWith(
          StockModel value, $Res Function(StockModel) then) =
      _$StockModelCopyWithImpl<$Res, StockModel>;
  @useResult
  $Res call(
      {String symbol,
      String companyName,
      double currentPrice,
      double change,
      double changePercent,
      double volume,
      double? marketCap,
      double? high52Week,
      double? low52Week,
      List<double>? sparklineData});
}

/// @nodoc
class _$StockModelCopyWithImpl<$Res, $Val extends StockModel>
    implements $StockModelCopyWith<$Res> {
  _$StockModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? companyName = null,
    Object? currentPrice = null,
    Object? change = null,
    Object? changePercent = null,
    Object? volume = null,
    Object? marketCap = freezed,
    Object? high52Week = freezed,
    Object? low52Week = freezed,
    Object? sparklineData = freezed,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
      changePercent: null == changePercent
          ? _value.changePercent
          : changePercent // ignore: cast_nullable_to_non_nullable
              as double,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      marketCap: freezed == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double?,
      high52Week: freezed == high52Week
          ? _value.high52Week
          : high52Week // ignore: cast_nullable_to_non_nullable
              as double?,
      low52Week: freezed == low52Week
          ? _value.low52Week
          : low52Week // ignore: cast_nullable_to_non_nullable
              as double?,
      sparklineData: freezed == sparklineData
          ? _value.sparklineData
          : sparklineData // ignore: cast_nullable_to_non_nullable
              as List<double>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockModelImplCopyWith<$Res>
    implements $StockModelCopyWith<$Res> {
  factory _$$StockModelImplCopyWith(
          _$StockModelImpl value, $Res Function(_$StockModelImpl) then) =
      __$$StockModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      String companyName,
      double currentPrice,
      double change,
      double changePercent,
      double volume,
      double? marketCap,
      double? high52Week,
      double? low52Week,
      List<double>? sparklineData});
}

/// @nodoc
class __$$StockModelImplCopyWithImpl<$Res>
    extends _$StockModelCopyWithImpl<$Res, _$StockModelImpl>
    implements _$$StockModelImplCopyWith<$Res> {
  __$$StockModelImplCopyWithImpl(
      _$StockModelImpl _value, $Res Function(_$StockModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StockModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? companyName = null,
    Object? currentPrice = null,
    Object? change = null,
    Object? changePercent = null,
    Object? volume = null,
    Object? marketCap = freezed,
    Object? high52Week = freezed,
    Object? low52Week = freezed,
    Object? sparklineData = freezed,
  }) {
    return _then(_$StockModelImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
      changePercent: null == changePercent
          ? _value.changePercent
          : changePercent // ignore: cast_nullable_to_non_nullable
              as double,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      marketCap: freezed == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double?,
      high52Week: freezed == high52Week
          ? _value.high52Week
          : high52Week // ignore: cast_nullable_to_non_nullable
              as double?,
      low52Week: freezed == low52Week
          ? _value.low52Week
          : low52Week // ignore: cast_nullable_to_non_nullable
              as double?,
      sparklineData: freezed == sparklineData
          ? _value._sparklineData
          : sparklineData // ignore: cast_nullable_to_non_nullable
              as List<double>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockModelImpl implements _StockModel {
  const _$StockModelImpl(
      {required this.symbol,
      required this.companyName,
      required this.currentPrice,
      required this.change,
      required this.changePercent,
      required this.volume,
      this.marketCap = null,
      this.high52Week = null,
      this.low52Week = null,
      final List<double>? sparklineData = null})
      : _sparklineData = sparklineData;

  factory _$StockModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockModelImplFromJson(json);

  /// The stock ticker symbol (e.g., "RELIANCE", "TCS").
  @override
  final String symbol;

  /// The full name of the company.
  @override
  final String companyName;

  /// The current market price (Last Traded Price).
  @override
  final double currentPrice;

  /// The absolute change in price from the previous close.
  @override
  final double change;

  /// The percentage change from the previous close.
  @override
  final double changePercent;

  /// The total trading volume.
  @override
  final double volume;

  /// The market capitalization of the company (in INR).
  @override
  @JsonKey()
  final double? marketCap;

  /// The 52-week high price.
  @override
  @JsonKey()
  final double? high52Week;

  /// The 52-week low price.
  @override
  @JsonKey()
  final double? low52Week;

  /// Optional historical data points for a sparkline chart.
  final List<double>? _sparklineData;

  /// Optional historical data points for a sparkline chart.
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
    return 'StockModel(symbol: $symbol, companyName: $companyName, currentPrice: $currentPrice, change: $change, changePercent: $changePercent, volume: $volume, marketCap: $marketCap, high52Week: $high52Week, low52Week: $low52Week, sparklineData: $sparklineData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockModelImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.changePercent, changePercent) ||
                other.changePercent == changePercent) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.marketCap, marketCap) ||
                other.marketCap == marketCap) &&
            (identical(other.high52Week, high52Week) ||
                other.high52Week == high52Week) &&
            (identical(other.low52Week, low52Week) ||
                other.low52Week == low52Week) &&
            const DeepCollectionEquality()
                .equals(other._sparklineData, _sparklineData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      symbol,
      companyName,
      currentPrice,
      change,
      changePercent,
      volume,
      marketCap,
      high52Week,
      low52Week,
      const DeepCollectionEquality().hash(_sparklineData));

  /// Create a copy of StockModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockModelImplCopyWith<_$StockModelImpl> get copyWith =>
      __$$StockModelImplCopyWithImpl<_$StockModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockModelImplToJson(
      this,
    );
  }
}

abstract class _StockModel implements StockModel {
  const factory _StockModel(
      {required final String symbol,
      required final String companyName,
      required final double currentPrice,
      required final double change,
      required final double changePercent,
      required final double volume,
      final double? marketCap,
      final double? high52Week,
      final double? low52Week,
      final List<double>? sparklineData}) = _$StockModelImpl;

  factory _StockModel.fromJson(Map<String, dynamic> json) =
      _$StockModelImpl.fromJson;

  /// The stock ticker symbol (e.g., "RELIANCE", "TCS").
  @override
  String get symbol;

  /// The full name of the company.
  @override
  String get companyName;

  /// The current market price (Last Traded Price).
  @override
  double get currentPrice;

  /// The absolute change in price from the previous close.
  @override
  double get change;

  /// The percentage change from the previous close.
  @override
  double get changePercent;

  /// The total trading volume.
  @override
  double get volume;

  /// The market capitalization of the company (in INR).
  @override
  double? get marketCap;

  /// The 52-week high price.
  @override
  double? get high52Week;

  /// The 52-week low price.
  @override
  double? get low52Week;

  /// Optional historical data points for a sparkline chart.
  @override
  List<double>? get sparklineData;

  /// Create a copy of StockModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockModelImplCopyWith<_$StockModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
