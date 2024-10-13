import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MasukController extends GetxController {
  var isLoading = false.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  final attendanceStatus = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    
    // Call the attendance API
    await postAttendance();
  }

  Future<void> postAttendance() async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('https://yourapi.com/attendance'),  // replace with your API URL
        body: {
          'latitude': latitude.value.toString(),
          'longitude': longitude.value.toString(),
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        attendanceStatus.value = data['status'] ?? 'Absen berhasil';
      } else {
        attendanceStatus.value = 'Failed to post attendance';
      }
    } catch (e) {
      attendanceStatus.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
