// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_index_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarketIndexModelImpl _$$MarketIndexModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MarketIndexModelImpl(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      value: (json['value'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
      sparklineData: (json['sparklineData'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          null,
    );

Map<String, dynamic> _$$MarketIndexModelImplToJson(
        _$MarketIndexModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'value': instance.value,
      'change': instance.change,
      'changePercent': instance.changePercent,
      'sparklineData': instance.sparklineData,
    };
