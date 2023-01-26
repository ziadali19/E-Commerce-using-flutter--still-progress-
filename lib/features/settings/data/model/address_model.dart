class AddressModel {
  final String? country;
  final String? state;
  final String? city;
  final String? addressDetails;

  AddressModel(
      {required this.country,
      required this.state,
      required this.city,
      required this.addressDetails});

  factory AddressModel.fromJson(json) {
    return AddressModel(
        country: json['country'],
        state: json['state'],
        city: json['city'],
        addressDetails: json['address']);
  }

  toJson() {
    return {
      'country': country,
      'state': state,
      'city': city,
      'address': addressDetails
    };
  }
}
