import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

/// Shared LatLng tween for smooth map marker animations.
/// تحريك سلس لإحداثيات الخريطة
class LatLngTween extends Tween<LatLng> {
  LatLngTween({required LatLng begin, required LatLng end})
      : super(begin: begin, end: end);

  @override
  LatLng lerp(double t) {
    return LatLng(
      begin!.latitude + (end!.latitude - begin!.latitude) * t,
      begin!.longitude + (end!.longitude - begin!.longitude) * t,
    );
  }
}
