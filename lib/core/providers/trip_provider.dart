import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

enum TripState {
  idle,
  searchingDriver,
  driverAccepted,
  driverArriving,
  driverWaiting,
  tripStarted,
  tripInProgress,
  tripFinished,
  cancelled,
}

class DriverModel {
  final String id;
  final String name;
  final String photo;
  final double rating;
  final int totalTrips;
  final String vehicleName;
  final String vehiclePlate;
  final String vehicleColor;
  final String phoneNumber;
  LatLng location;
  double heading;

  DriverModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.rating,
    required this.totalTrips,
    required this.vehicleName,
    required this.vehiclePlate,
    required this.vehicleColor,
    required this.phoneNumber,
    required this.location,
    this.heading = 0,
  });

  static DriverModel get mock => DriverModel(
        id: 'd1',
        name: 'Ahmed Al-Rashidi',
        photo: 'https://i.pravatar.cc/150?img=12',
        rating: 4.9,
        totalTrips: 1247,
        vehicleName: 'Toyota Camry 2023',
        vehiclePlate: 'ABC 1234',
        vehicleColor: 'White',
        phoneNumber: '+966501234567',
        location: const LatLng(24.7200, 46.6800),
      );
}

class TripProvider extends ChangeNotifier {
  TripState _state = TripState.idle;
  DriverModel? _driver;
  String _selectedVehicleType = 'economy';
  String _selectedPaymentMethod = 'cash';
  double _estimatedFare = 0;
  int _etaMinutes = 0;
  double _tripDistance = 0;
  double _tripDuration = 0;
  String? _promoCode;
  double _promoDiscount = 0;

  TripState get state => _state;
  DriverModel? get driver => _driver;
  String get selectedVehicleType => _selectedVehicleType;
  String get selectedPaymentMethod => _selectedPaymentMethod;
  double get estimatedFare => _estimatedFare;
  int get etaMinutes => _etaMinutes;
  double get tripDistance => _tripDistance;
  double get tripDuration => _tripDuration;
  String? get promoCode => _promoCode;
  double get promoDiscount => _promoDiscount;
  double get finalFare => _estimatedFare - _promoDiscount;

  void setState(TripState state) {
    _state = state;
    notifyListeners();
  }

  void setDriver(DriverModel driver) {
    _driver = driver;
    notifyListeners();
  }

  void selectVehicle(String vehicleType) {
    _selectedVehicleType = vehicleType;
    notifyListeners();
  }

  void selectPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  void setEstimate({
    required double fare,
    required int eta,
    required double distance,
  }) {
    _estimatedFare = fare;
    _etaMinutes = eta;
    _tripDistance = distance;
    notifyListeners();
  }

  void applyPromo(String code, double discount) {
    _promoCode = code;
    _promoDiscount = discount;
    notifyListeners();
  }

  void updateDriverLocation(LatLng location, double heading) {
    if (_driver != null) {
      _driver!.location = location;
      _driver!.heading = heading;
      notifyListeners();
    }
  }

  void startTrip() {
    _driver = DriverModel.mock;
    _state = TripState.driverAccepted;
    _etaMinutes = 4;
    notifyListeners();
  }

  void reset() {
    _state = TripState.idle;
    _driver = null;
    _estimatedFare = 0;
    _etaMinutes = 0;
    _tripDistance = 0;
    _tripDuration = 0;
    _promoCode = null;
    _promoDiscount = 0;
    notifyListeners();
  }
}
