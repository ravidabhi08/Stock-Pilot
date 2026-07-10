// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HoldingModelImpl _$$HoldingModelImplFromJson(Map<String, dynamic> json) =>
    _$HoldingModelImpl(
      symbol: json['symbol'] as String,
      companyName: json['companyName'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      avgBuyPrice: (json['avgBuyPrice'] as num).toDouble(),
      currentPrice: (json['currentPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$HoldingModelImplToJson(_$HoldingModelImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'quantity': instance.quantity,
      'avgBuyPrice': instance.avgBuyPrice,
      'currentPrice': instance.currentPrice,
    };
