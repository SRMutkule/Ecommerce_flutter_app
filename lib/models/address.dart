class Address {
  final String id;
  final String name;
  final String phone;
  final String addressLine;
  final String city;
  final String state;
  final String pincode;
  final String type;

  const Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.addressLine,
    required this.city,
    required this.state,
    required this.pincode,
    this.type = 'Home',
  });

  String get fullAddress =>
      '$addressLine, $city, $state - $pincode';
}