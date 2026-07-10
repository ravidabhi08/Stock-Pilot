// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StockDetailModel _$StockDetailModelFromJson(Map<String, dynamic> json) {
  return _StockDetailModel.fromJson(json);
}

/// @nodoc
mixin _$StockDetailModel {
  /// The stock ticker symbol.
  String get symbol => throw _privateConstructorUsedError;

  /// The full name of the company.
  String get companyName => throw _privateConstructorUsedError;

  /// The current market price.
  double get currentPrice => throw _privateConstructorUsedError;

  /// The absolute change in price.
  double get change => throw _privateConstructorUsedError;

  /// The percentage change.
  double get changePercent => throw _privateConstructorUsedError;

  /// The total trading volume for the day.
  double get volume => throw _privateConstructorUsedError;

  /// The market capitalization (in INR).
  double get marketCap => throw _privateConstructorUsedError;

  /// The Price-to-Earnings (P/E) ratio.
  double get peRatio => throw _privateConstructorUsedError;

  /// The Price-to-Book (P/B) ratio.
  double get pbRatio => throw _privateConstructorUsedError;

  /// The 52-week high price.
  double get high52Week => throw _privateConstructorUsedError;

  /// The 52-week low price.
  double get low52Week => throw _privateConstructorUsedError;

  /// The highest price traded today.
  double get dayHigh => throw _privateConstructorUsedError;

  /// The lowest price traded today.
  double get dayLow => throw _privateConstructorUsedError;

  /// The opening price today.
  double get openPrice => throw _privateConstructorUsedError;

  /// The previous day's closing price.
  double get prevClose => throw _privateConstructorUsedError;

  /// The sector the company belongs to.
  String get sector => throw _privateConstructorUsedError;

  /// The specific industry.
  String get industry => throw _privateConstructorUsedError;

  /// A brief description of the company.
  String get description => throw _privateConstructorUsedError;

  /// Historical price data for the main chart.
  List<double> get chartData => throw _privateConstructorUsedError;

  /// Serializes this StockDetailModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockDetailModelCopyWith<StockDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockDetailModelCopyWith<$Res> {
  factory $StockDetailModelCopyWith(
          StockDetailModel value, $Res Function(StockDetailModel) then) =
      _$StockDetailModelCopyWithImpl<$Res, StockDetailModel>;
  @useResult
  $Res call(
      {String symbol,
      String companyName,
      double currentPrice,
      double change,
      double changePercent,
      double volume,
      double marketCap,
      double peRatio,
      double pbRatio,
      double high52Week,
      double low52Week,
      double dayHigh,
      double dayLow,
      double openPrice,
      double prevClose,
      String sector,
      String industry,
      String description,
      List<double> chartData});
}

/// @nodoc
class _$StockDetailModelCopyWithImpl<$Res, $Val extends StockDetailModel>
    implements $StockDetailModelCopyWith<$Res> {
  _$StockDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockDetailModel
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
    Object? marketCap = null,
    Object? peRatio = null,
    Object? pbRatio = null,
    Object? high52Week = null,
    Object? low52Week = null,
    Object? dayHigh = null,
    Object? dayLow = null,
    Object? openPrice = null,
    Object? prevClose = null,
    Object? sector = null,
    Object? industry = null,
    Object? description = null,
    Object? chartData = null,
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
      marketCap: null == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double,
      peRatio: null == peRatio
          ? _value.peRatio
          : peRatio // ignore: cast_nullable_to_non_nullable
              as double,
      pbRatio: null == pbRatio
          ? _value.pbRatio
          : pbRatio // ignore: cast_nullable_to_non_nullable
              as double,
      high52Week: null == high52Week
          ? _value.high52Week
          : high52Week // ignore: cast_nullable_to_non_nullable
              as double,
      low52Week: null == low52Week
          ? _value.low52Week
          : low52Week // ignore: cast_nullable_to_non_nullable
              as double,
      dayHigh: null == dayHigh
          ? _value.dayHigh
          : dayHigh // ignore: cast_nullable_to_non_nullable
              as double,
      dayLow: null == dayLow
          ? _value.dayLow
          : dayLow // ignore: cast_nullable_to_non_nullable
              as double,
      openPrice: null == openPrice
          ? _value.openPrice
          : openPrice // ignore: cast_nullable_to_non_nullable
              as double,
      prevClose: null == prevClose
          ? _value.prevClose
          : prevClose // ignore: cast_nullable_to_non_nullable
              as double,
      sector: null == sector
          ? _value.sector
          : sector // ignore: cast_nullable_to_non_nullable
              as String,
      industry: null == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      chartData: null == chartData
          ? _value.chartData
          : chartData // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockDetailModelImplCopyWith<$Res>
    implements $StockDetailModelCopyWith<$Res> {
  factory _$$StockDetailModelImplCopyWith(_$StockDetailModelImpl value,
          $Res Function(_$StockDetailModelImpl) then) =
      __$$StockDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      String companyName,
      double currentPrice,
      double change,
      double changePercent,
      double volume,
      double marketCap,
      double peRatio,
      double pbRatio,
      double high52Week,
      double low52Week,
      double dayHigh,
      double dayLow,
      double openPrice,
      double prevClose,
      String sector,
      String industry,
      String description,
      List<double> chartData});
}

/// @nodoc
class __$$StockDetailModelImplCopyWithImpl<$Res>
    extends _$StockDetailModelCopyWithImpl<$Res, _$StockDetailModelImpl>
    implements _$$StockDetailModelImplCopyWith<$Res> {
  __$$StockDetailModelImplCopyWithImpl(_$StockDetailModelImpl _value,
      $Res Function(_$StockDetailModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StockDetailModel
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
    Object? marketCap = null,
    Object? peRatio = null,
    Object? pbRatio = null,
    Object? high52Week = null,
    Object? low52Week = null,
    Object? dayHigh = null,
    Object? dayLow = null,
    Object? openPrice = null,
    Object? prevClose = null,
    Object? sector = null,
    Object? industry = null,
    Object? description = null,
    Object? chartData = null,
  }) {
    return _then(_$StockDetailModelImpl(
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
      marketCap: null == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double,
      peRatio: null == peRatio
          ? _value.peRatio
          : peRatio // ignore: cast_nullable_to_non_nullable
              as double,
      pbRatio: null == pbRatio
          ? _value.pbRatio
          : pbRatio // ignore: cast_nullable_to_non_nullable
              as double,
      high52Week: null == high52Week
          ? _value.high52Week
          : high52Week // ignore: cast_nullable_to_non_nullable
              as double,
      low52Week: null == low52Week
          ? _value.low52Week
          : low52Week // ignore: cast_nullable_to_non_nullable
              as double,
      dayHigh: null == dayHigh
          ? _value.dayHigh
          : dayHigh // ignore: cast_nullable_to_non_nullable
              as double,
      dayLow: null == dayLow
          ? _value.dayLow
          : dayLow // ignore: cast_nullable_to_non_nullable
              as double,
      openPrice: null == openPrice
          ? _value.openPrice
          : openPrice // ignore: cast_nullable_to_non_nullable
              as double,
      prevClose: null == prevClose
          ? _value.prevClose
          : prevClose // ignore: cast_nullable_to_non_nullable
              as double,
      sector: null == sector
          ? _value.sector
          : sector // ignore: cast_nullable_to_non_nullable
              as String,
      industry: null == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      chartData: null == chartData
          ? _value._chartData
          : chartData // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockDetailModelImpl implements _StockDetailModel {
  const _$StockDetailModelImpl(
      {required this.symbol,
      required this.companyName,
      required this.currentPrice,
      required this.change,
      required this.changePercent,
      required this.volume,
      required this.marketCap,
      required this.peRatio,
      required this.pbRatio,
      required this.high52Week,
      required this.low52Week,
      required this.dayHigh,
      required this.dayLow,
      required this.openPrice,
      required this.prevClose,
      required this.sector,
      required this.industry,
      required this.description,
      required final List<double> chartData})
      : _chartData = chartData;

  factory _$StockDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockDetailModelImplFromJson(json);

  /// The stock ticker symbol.
  @override
  final String symbol;

  /// The full name of the company.
  @override
  final String companyName;

  /// The current market price.
  @override
  final double currentPrice;

  /// The absolute change in price.
  @override
  final double change;

  /// The percentage change.
  @override
  final double changePercent;

  /// The total trading volume for the day.
  @override
  final double volume;

  /// The market capitalization (in INR).
  @override
  final double marketCap;

  /// The Price-to-Earnings (P/E) ratio.
  @override
  final double peRatio;

  /// The Price-to-Book (P/B) ratio.
  @override
  final double pbRatio;

  /// The 52-week high price.
  @override
  final double high52Week;

  /// The 52-week low price.
  @override
  final double low52Week;

  /// The highest price traded today.
  @override
  final double dayHigh;

  /// The lowest price traded today.
  @override
  final double dayLow;

  /// The opening price today.
  @override
  final double openPrice;

  /// The previous day's closing price.
  @override
  final double prevClose;

  /// The sector the company belongs to.
  @override
  final String sector;

  /// The specific industry.
  @override
  final String industry;

  /// A brief description of the company.
  @override
  final String description;

  /// Historical price data for the main chart.
  final List<double> _chartData;

  /// Historical price data for the main chart.
  @override
  List<double> get chartData {
    if (_chartData is EqualUnmodifiableListView) return _chartData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chartData);
  }

  @override
  String toString() {
    return 'StockDetailModel(symbol: $symbol, companyName: $companyName, currentPrice: $currentPrice, change: $change, changePercent: $changePercent, volume: $volume, marketCap: $marketCap, peRatio: $peRatio, pbRatio: $pbRatio, high52Week: $high52Week, low52Week: $low52Week, dayHigh: $dayHigh, dayLow: $dayLow, openPrice: $openPrice, prevClose: $prevClose, sector: $sector, industry: $industry, description: $description, chartData: $chartData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockDetailModelImpl &&
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
            (identical(other.peRatio, peRatio) || other.peRatio == peRatio) &&
            (identical(other.pbRatio, pbRatio) || other.pbRatio == pbRatio) &&
            (identical(other.high52Week, high52Week) ||
                other.high52Week == high52Week) &&
            (identical(other.low52Week, low52Week) ||
                other.low52Week == low52Week) &&
            (identical(other.dayHigh, dayHigh) || other.dayHigh == dayHigh) &&
            (identical(other.dayLow, dayLow) || other.dayLow == dayLow) &&
            (identical(other.openPrice, openPrice) ||
                other.openPrice == openPrice) &&
            (identical(other.prevClose, prevClose) ||
                other.prevClose == prevClose) &&
            (identical(other.sector, sector) || other.sector == sector) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._chartData, _chartData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        symbol,
        companyName,
        currentPrice,
        change,
        changePercent,
        volume,
        marketCap,
        peRatio,
        pbRatio,
        high52Week,
        low52Week,
        dayHigh,
        dayLow,
        openPrice,
        prevClose,
        sector,
        industry,
        description,
        const DeepCollectionEquality().hash(_chartData)
      ]);

  /// Create a copy of StockDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockDetailModelImplCopyWith<_$StockDetailModelImpl> get copyWith =>
      __$$StockDetailModelImplCopyWithImpl<_$StockDetailModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockDetailModelImplToJson(
      this,
    );
  }
}

abstract class _StockDetailModel implements StockDetailModel {
  const factory _StockDetailModel(
      {required final String symbol,
      required final String companyName,
      required final double currentPrice,
      required final double change,
      required final double changePercent,
      required final double volume,
      required final double marketCap,
      required final double peRatio,
      required final double pbRatio,
      required final double high52Week,
      required final double low52Week,
      required final double dayHigh,
      required final double dayLow,
      required final double openPrice,
      required final double prevClose,
      required final String sector,
      required final String industry,
      required final String description,
      required final List<double> chartData}) = _$StockDetailModelImpl;

  factory _StockDetailModel.fromJson(Map<String, dynamic> json) =
      _$StockDetailModelImpl.fromJson;

  /// The stock ticker symbol.
  @override
  String get symbol;

  /// The full name of the company.
  @override
  String get companyName;

  /// The current market price.
  @override
  double get currentPrice;

  /// The absolute change in price.
  @override
  double get change;

  /// The percentage change.
  @override
  double get changePercent;

  /// The total trading volume for the day.
  @override
  double get volume;

  /// The market capitalization (in INR).
  @override
  double get marketCap;

  /// The Price-to-Earnings (P/E) ratio.
  @override
  double get peRatio;

  /// The Price-to-Book (P/B) ratio.
  @override
  double get pbRatio;

  /// The 52-week high price.
  @override
  double get high52Week;

  /// The 52-week low price.
  @override
  double get low52Week;

  /// The highest price traded today.
  @override
  double get dayHigh;

  /// The lowest price traded today.
  @override
  double get dayLow;

  /// The opening price today.
  @override
  double get openPrice;

  /// The previous day's closing price.
  @override
  double get prevClose;

  /// The sector the company belongs to.
  @override
  String get sector;

  /// The specific industry.
  @override
  String get industry;

  /// A brief description of the company.
  @override
  String get description;

  /// Historical price data for the main chart.
  @override
  List<double> get chartData;

  /// Create a copy of StockDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockDetailModelImplCopyWith<_$StockDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
