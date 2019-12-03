// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) {
  return Auth()
    ..userId = json['userId'] as num
    ..token = json['token'] as String;
}

Map<String, dynamic> _$AuthToJson(Auth instance) =>
    <String, dynamic>{'userId': instance.userId, 'token': instance.token};
