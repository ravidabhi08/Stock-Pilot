// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holding_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HoldingModel _$HoldingModelFromJson(Map<String, dynamic> json) {
  return _HoldingModel.fromJson(json);
}

/// @nodoc
mixin _$HoldingModel {
  /// The stock ticker symbol (e.g., "RELIANCE", "TCS").
  String get symbol => throw _privateConstructorUsedError;

  /// The full name of the company.
  String get companyName => throw _privateConstructorUsedError;

  /// The number of shares held.
  double get quantity => throw _privateConstructorUsedError;

  /// The average purchase price per share.
  double get avgBuyPrice => throw _privateConstructorUsedError;

  /// The current market price per share.
  double get currentPrice => throw _privateConstructorUsedError;

  /// Serializes this HoldingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HoldingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldingModelCopyWith<HoldingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldingModelCopyWith<$Res> {
  factory $HoldingModelCopyWith(
          HoldingModel value, $Res Function(HoldingModel) then) =
      _$HoldingModelCopyWithImpl<$Res, HoldingModel>;
  @useResult
  $Res call(
      {String symbol,
      String companyName,
      double quantity,
      double avgBuyPrice,
      double currentPrice});
}

/// @nodoc
class _$HoldingModelCopyWithImpl<$Res, $Val extends HoldingModel>
    implements $HoldingModelCopyWith<$Res> {
  _$HoldingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoldingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? companyName = null,
    Object? quantity = null,
    Object? avgBuyPrice = null,
    Object? currentPrice = null,
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
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      avgBuyPrice: null == avgBuyPrice
          ? _value.avgBuyPrice
          : avgBuyPrice // ignore: cast_nullable_to_non_nullable
              as double,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HoldingModelImplCopyWith<$Res>
    implements $HoldingModelCopyWith<$Res> {
  factory _$$HoldingModelImplCopyWith(
          _$HoldingModelImpl value, $Res Function(_$HoldingModelImpl) then) =
      __$$HoldingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      String companyName,
      double quantity,
      double avgBuyPrice,
      double currentPrice});
}

/// @nodoc
class __$$HoldingModelImplCopyWithImpl<$Res>
    extends _$HoldingModelCopyWithImpl<$Res, _$HoldingModelImpl>
    implements _$$HoldingModelImplCopyWith<$Res> {
  __$$HoldingModelImplCopyWithImpl(
      _$HoldingModelImpl _value, $Res Function(_$HoldingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of HoldingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? companyName = null,
    Object? quantity = null,
    Object? avgBuyPrice = null,
    Object? currentPrice = null,
  }) {
    return _then(_$HoldingModelImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      avgBuyPrice: null == avgBuyPrice
          ? _value.avgBuyPrice
          : avgBuyPrice // ignore: cast_nullable_to_non_nullable
              as double,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HoldingModelImpl implements _HoldingModel {
  const _$HoldingModelImpl(
      {required this.symbol,
      required this.companyName,
      required this.quantity,
      required this.avgBuyPrice,
      required this.currentPrice});

  factory _$HoldingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoldingModelImplFromJson(json);

  /// The stock ticker symbol (e.g., "RELIANCE", "TCS").
  @override
  final String symbol;

  /// The full name of the company.
  @override
  final String companyName;

  /// The number of shares held.
  @override
  final double quantity;

  /// The average purchase price per share.
  @override
  final double avgBuyPrice;

  /// The current market price per share.
  @override
  final double currentPrice;

  @override
  String toString() {
    return 'HoldingModel(symbol: $symbol, companyName: $companyName, quantity: $quantity, avgBuyPrice: $avgBuyPrice, currentPrice: $currentPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldingModelImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.avgBuyPrice, avgBuyPrice) ||
                other.avgBuyPrice == avgBuyPrice) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, symbol, companyName, quantity, avgBuyPrice, currentPrice);

  /// Create a copy of HoldingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldingModelImplCopyWith<_$HoldingModelImpl> get copyWith =>
      __$$HoldingModelImplCopyWithImpl<_$HoldingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldingModelImplToJson(
      this,
    );
  }
}

abstract class _HoldingModel implements HoldingModel {
  const factory _HoldingModel(
      {required final String symbol,
      required final String companyName,
      required final double quantity,
      required final double avgBuyPrice,
      required final double currentPrice}) = _$HoldingModelImpl;

  factory _HoldingModel.fromJson(Map<String, dynamic> json) =
      _$HoldingModelImpl.fromJson;

  /// The stock ticker symbol (e.g., "RELIANCE", "TCS").
  @override
  String get symbol;

  /// The full name of the company.
  @override
  String get companyName;

  /// The number of shares held.
  @override
  double get quantity;

  /// The average purchase price per share.
  @override
  double get avgBuyPrice;

  /// The current market price per share.
  @override
  double get currentPrice;

  /// Create a copy of HoldingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldingModelImplCopyWith<_$HoldingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
