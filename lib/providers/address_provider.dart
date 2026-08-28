import 'package:flutter/foundation.dart';

import '../models/address.dart';

class AddressProvider extends ChangeNotifier {
  final List<Address> _addresses = [
    const Address(
      id: '1',
      name: 'Shubham Mutkule',
      phone: '+91 93567 77375',
      addressLine: 'Near Maruti Mandir',
      city: 'Pune',
      state: 'Maharashtra',
      pincode: '412106',
      type: 'Home',
    ),
  ];

  String? _selectedAddressId;

  List<Address> get addresses => List.unmodifiable(_addresses);

  Address? get selectedAddress {
    if (_addresses.isEmpty) return null;

    if (_selectedAddressId == null) {
      return _addresses.first;
    }

    try {
      return _addresses.firstWhere(
            (address) => address.id == _selectedAddressId,
      );
    } catch (_) {
      return _addresses.first;
    }
  }

  void selectAddress(String id) {
    _selectedAddressId = id;
    notifyListeners();
  }

  void addAddress(Address address) {
    _addresses.add(address);
    _selectedAddressId = address.id;
    notifyListeners();
  }

  void removeAddress(String id) {
    _addresses.removeWhere(
          (address) => address.id == id,
    );

    if (_selectedAddressId == id) {
      _selectedAddressId =
      _addresses.isNotEmpty ? _addresses.first.id : null;
    }

    notifyListeners();
  }

  void updateAddress(Address updatedAddress) {
    final index = _addresses.indexWhere(
          (address) => address.id == updatedAddress.id,
    );

    if (index != -1) {
      _addresses[index] = updatedAddress;
      notifyListeners();
    }
  }
}