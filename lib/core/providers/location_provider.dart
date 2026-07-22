import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationProvider extends ChangeNotifier {
  LatLng _currentLocation = const LatLng(24.7136, 46.6753); // Riyadh default
  LatLng? _pickupLocation;
  LatLng? _dropoffLocation;
  String _pickupAddress = '';
  String _dropoffAddress = '';
  bool _locationPermissionGranted = false;
  double _heading = 0.0;

  LatLng get currentLocation => _currentLocation;
  LatLng? get pickupLocation => _pickupLocation;
  LatLng? get dropoffLocation => _dropoffLocation;
  String get pickupAddress => _pickupAddress;
  String get dropoffAddress => _dropoffAddress;
  bool get locationPermissionGranted => _locationPermissionGranted;
  double get heading => _heading;

  void updateCurrentLocation(LatLng location) {
    _currentLocation = location;
    notifyListeners();
  }

  void setPickup(LatLng location, String address) {
    _pickupLocation = location;
    _pickupAddress = address;
    notifyListeners();
  }

  void setDropoff(LatLng location, String address) {
    _dropoffLocation = location;
    _dropoffAddress = address;
    notifyListeners();
  }

  void setPermissionGranted(bool value) {
    _locationPermissionGranted = value;
    notifyListeners();
  }

  void updateHeading(double heading) {
    _heading = heading;
    notifyListeners();
  }

  void clearTrip() {
    _pickupLocation = null;
    _dropoffLocation = null;
    _pickupAddress = '';
    _dropoffAddress = '';
    notifyListeners();
  }
}
