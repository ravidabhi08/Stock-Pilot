// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockModelImpl _$$StockModelImplFromJson(Map<String, dynamic> json) =>
    _$StockModelImpl(
      symbol: json['symbol'] as String,
      companyName: json['companyName'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      marketCap: (json['marketCap'] as num?)?.toDouble() ?? null,
      high52Week: (json['high52Week'] as num?)?.toDouble() ?? null,
      low52Week: (json['low52Week'] as num?)?.toDouble() ?? null,
      sparklineData: (json['sparklineData'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          null,
    );

Map<String, dynamic> _$$StockModelImplToJson(_$StockModelImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'currentPrice': instance.currentPrice,
      'change': instance.change,
      'changePercent': instance.changePercent,
      'volume': instance.volume,
      'marketCap': instance.marketCap,
      'high52Week': instance.high52Week,
      'low52Week': instance.low52Week,
      'sparklineData': instance.sparklineData,
    };
