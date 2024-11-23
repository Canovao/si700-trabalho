import 'package:si700_trabalho/model/trip/AddressResponseItem.dart';

class SearchResponseItem {
  String locationId;
  String name;
  AddressResponseitem addressObj;

  SearchResponseItem(
      {required this.locationId, required this.name, required this.addressObj});

  SearchResponseItem.fromJson(Map<String, dynamic> json)
      : locationId = json['location_id'],
        name = json['name'],
        addressObj = json['address_obj'] != null
            ? AddressResponseitem.fromJson(json['address_obj'])
            : throw ArgumentError('address_obj cannot be null');

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_id'] = locationId;
    data['name'] = name;
    if (addressObj != null) {
      data['address_obj'] = addressObj.toJson();
    }
    return data;
  }
}
