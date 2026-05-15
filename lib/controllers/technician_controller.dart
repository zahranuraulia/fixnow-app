import 'package:fixnow/models/technician_model.dart';
import 'package:fixnow/services/api_service.dart';

class TechnicianController {
  final ApiService _apiService = ApiService();
  List<TechnicianModel> technicians = [];
  bool isLoading = false;

  Future<void> fetchTechnicians() async {
    isLoading = true;
    try {
      technicians = await _apiService.getTechnicians();
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading = false;
    }
  }
}