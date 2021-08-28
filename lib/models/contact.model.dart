class ContactModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? addressLine1;
  String? addressLine2;
  String? latLng;

  ContactModel({
    this.id = 0,
    this.name = "",
    this.email = "",
    this.phone = "",
    this.image = "assets/images/profile-picture.png",
    this.addressLine1 = "",
    this.addressLine2 = "",
    this.latLng = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'latLng': latLng,
    };
  }
}
