import 'dart:async';
import 'package:flutter/foundation.dart';
import 'salary_calculator.dart';
import 'salary_repository.dart';

class SalaryViewModel extends ChangeNotifier {
  final SalaryRepository _repository = SalaryRepository();

  double _monthlySalary = SalaryRepository.defaultSalary;
  SalaryCalculationResult? _calculationResult;
  Timer? _timer;
  bool _isLoading = true;

  double get monthlySalary => _monthlySalary;
  SalaryCalculationResult? get calculationResult => _calculationResult;
  bool get isLoading => _isLoading;

  SalaryViewModel() {
    _init();
  }

  Future<void> _init() async {
    _monthlySalary = await _repository.getSalary();
    _isLoading = false;
    _recalculate();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _recalculate();
    });
  }

  void _recalculate() {
    _calculationResult = SalaryCalculator.calculate(
      monthlySalary: _monthlySalary,
      now: DateTime.now(),
    );
    notifyListeners();
  }

  Future<void> updateSalary(double newSalary) async {
    if (newSalary < 0) return;
    _monthlySalary = newSalary;
    await _repository.saveSalary(newSalary);
    _recalculate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
