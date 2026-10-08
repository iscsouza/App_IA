import 'package:shared_preferences/shared_preferences.dart';

class SalaryRepository {
  static const String _keySalary = 'monthly_salary';
  static const double defaultSalary = 1621.00;

  Future<double> getSalary() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keySalary) ?? defaultSalary;
  }

  Future<void> saveSalary(double salary) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keySalary, salary);
  }
}
