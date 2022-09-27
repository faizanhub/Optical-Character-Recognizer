class Brewery {
  String? id;
  String? name;
  String? breweryType;
  String? street;
  String? address2;
  String? address3;
  String? city;
  String? state;
  String? countyProvince;
  String? postalCode;
  String? country;
  String? longitude;
  String? latitude;
  String? phone;
  String? websiteUrl;
  String? updatedAt;
  String? createdAt;

  Brewery(
      {this.id,
      this.name,
      this.breweryType,
      this.street,
      this.address2,
      this.address3,
      this.city,
      this.state,
      this.countyProvince,
      this.postalCode,
      this.country,
      this.longitude,
      this.latitude,
      this.phone,
      this.websiteUrl,
      this.updatedAt,
      this.createdAt});

  Brewery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    breweryType = json['brewery_type'];
    street = json['street'];
    address2 = json['address_2'];
    address3 = json['address_3'];
    city = json['city'];
    state = json['state'];
    countyProvince = json['county_province'];
    postalCode = json['postal_code'];
    country = json['country'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    phone = json['phone'];
    websiteUrl = json['website_url'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['brewery_type'] = this.breweryType;
    data['street'] = this.street;
    data['address_2'] = this.address2;
    data['address_3'] = this.address3;
    data['city'] = this.city;
    data['state'] = this.state;
    data['county_province'] = this.countyProvince;
    data['postal_code'] = this.postalCode;
    data['country'] = this.country;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['phone'] = this.phone;
    data['website_url'] = this.websiteUrl;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
