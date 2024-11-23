class AddressResponseitem {
  String street1;
  String street2;
  String city;
  String state;
  String country;
  String postalcode;
  String addressString;

  AddressResponseitem({
    required this.street1,
    required this.street2,
    required this.city,
    required this.state,
    required this.country,
    required this.postalcode,
    required this.addressString,
  });

  AddressResponseitem.fromJson(Map<String, dynamic> json)
      : street1 = json['street1'],
        street2 = json['street2'],
        city = json['city'],
        state = json['state'],
        country = json['country'],
        postalcode = json['postalcode'],
        addressString = json['address_string'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street1'] = this.street1;
    data['street2'] = this.street2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postalcode'] = this.postalcode;
    data['address_string'] = this.addressString;
    return data;
  }
}
