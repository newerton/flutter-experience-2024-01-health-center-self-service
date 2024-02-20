import 'package:json_annotation/json_annotation.dart';

part 'patient_address_modal.g.dart';

@JsonSerializable()
class PatientAddressModal {
  PatientAddressModal({
    required this.cep,
    required this.streetAddress,
    required this.number,
    required this.complement,
    required this.state,
    required this.city,
    required this.district,
  });

  final String cep;
  @JsonKey(name: 'street_address')
  final String streetAddress;
  final String number;
  @JsonKey(name: 'address_complement')
  final String complement;
  final String state;
  final String city;
  final String district;

  factory PatientAddressModal.fromJson(Map<String, dynamic> json) =>
      _$PatientAddressModalFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAddressModalToJson(this);

  PatientAddressModal copyWith({
    String? cep,
    String? streetAddress,
    String? number,
    String? complement,
    String? state,
    String? city,
    String? district,
  }) {
    return PatientAddressModal(
      cep: cep ?? this.cep,
      streetAddress: streetAddress ?? this.streetAddress,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      state: state ?? this.state,
      city: city ?? this.city,
      district: district ?? this.district,
    );
  }
}
