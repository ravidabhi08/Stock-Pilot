// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockDetailModelImpl _$$StockDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StockDetailModelImpl(
      symbol: json['symbol'] as String,
      companyName: json['companyName'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      marketCap: (json['marketCap'] as num).toDouble(),
      peRatio: (json['peRatio'] as num).toDouble(),
      pbRatio: (json['pbRatio'] as num).toDouble(),
      high52Week: (json['high52Week'] as num).toDouble(),
      low52Week: (json['low52Week'] as num).toDouble(),
      dayHigh: (json['dayHigh'] as num).toDouble(),
      dayLow: (json['dayLow'] as num).toDouble(),
      openPrice: (json['openPrice'] as num).toDouble(),
      prevClose: (json['prevClose'] as num).toDouble(),
      sector: json['sector'] as String,
      industry: json['industry'] as String,
      description: json['description'] as String,
      chartData: (json['chartData'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$$StockDetailModelImplToJson(
        _$StockDetailModelImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'currentPrice': instance.currentPrice,
      'change': instance.change,
      'changePercent': instance.changePercent,
      'volume': instance.volume,
      'marketCap': instance.marketCap,
      'peRatio': instance.peRatio,
      'pbRatio': instance.pbRatio,
      'high52Week': instance.high52Week,
      'low52Week': instance.low52Week,
      'dayHigh': instance.dayHigh,
      'dayLow': instance.dayLow,
      'openPrice': instance.openPrice,
      'prevClose': instance.prevClose,
      'sector': instance.sector,
      'industry': instance.industry,
      'description': instance.description,
      'chartData': instance.chartData,
    };
