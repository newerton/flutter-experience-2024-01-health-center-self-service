// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_address_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientAddressModal _$PatientAddressModalFromJson(Map<String, dynamic> json) =>
    PatientAddressModal(
      cep: json['cep'] as String,
      streetAddress: json['street_address'] as String,
      number: json['number'] as String,
      complement: json['address_complement'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
    );

Map<String, dynamic> _$PatientAddressModalToJson(
        PatientAddressModal instance) =>
    <String, dynamic>{
      'cep': instance.cep,
      'street_address': instance.streetAddress,
      'number': instance.number,
      'address_complement': instance.complement,
      'state': instance.state,
      'city': instance.city,
      'district': instance.district,
    };
