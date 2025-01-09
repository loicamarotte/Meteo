// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Cloud.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cloud _$CloudFromJson(Map<String, dynamic> json) => Cloud(
      cloudiness: (json['all'] as num).toInt(),
    );

Map<String, dynamic> _$CloudToJson(Cloud instance) => <String, dynamic>{
      'all': instance.cloudiness,
    };
