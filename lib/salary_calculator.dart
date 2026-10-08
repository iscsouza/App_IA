class SalaryCalculationResult {
  final double monthlySalary;
  final int totalWorkdays;
  final double salaryPerWorkday;
  final double salaryPerHour;
  final double accumulatedSalary;
  final double monthProgress; // 0.0 to 1.0
  final DateTime monthStart;
  final DateTime monthEnd;

  SalaryCalculationResult({
    required this.monthlySalary,
    required this.totalWorkdays,
    required this.salaryPerWorkday,
    required this.salaryPerHour,
    required this.accumulatedSalary,
    required this.monthProgress,
    required this.monthStart,
    required this.monthEnd,
  });
}

class SalaryCalculator {
  static const int workHoursPerDay = 8;
  static const int workdayStartHour = 9; // 09:00 AM
  static const int workdayEndHour = 17;  // 05:00 PM

  static bool isWorkday(DateTime date) {
    return date.weekday >= DateTime.monday && date.weekday <= DateTime.friday;
  }

  static int getTotalWorkdays(int year, int month) {
    final daysInMonth = DateTime(year, month + 1, 0).day;
    int count = 0;
    for (int day = 1; day <= daysInMonth; day++) {
      if (isWorkday(DateTime(year, month, day))) {
        count++;
      }
    }
    return count > 0 ? count : 1; // avoid division by zero
  }

  static SalaryCalculationResult calculate({
    required double monthlySalary,
    required DateTime now,
  }) {
    final year = now.year;
    final month = now.month;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final monthStart = DateTime(year, month, 1);
    final monthEnd = DateTime(year, month, daysInMonth);

    final totalWorkdays = getTotalWorkdays(year, month);
    final salaryPerWorkday = monthlySalary / totalWorkdays;
    final salaryPerHour = salaryPerWorkday / workHoursPerDay;

    double completedWorkdays = 0.0;

    for (int day = 1; day <= daysInMonth; day++) {
      final currentDayDate = DateTime(year, month, day);

      if (day < now.day) {
        if (isWorkday(currentDayDate)) {
          completedWorkdays += 1.0;
        }
      } else if (day == now.day) {
        if (isWorkday(currentDayDate)) {
          final startOfWork = DateTime(year, month, day, workdayStartHour, 0, 0);
          final endOfWork = DateTime(year, month, day, workdayEndHour, 0, 0);

          if (now.isBefore(startOfWork)) {
            completedWorkdays += 0.0;
          } else if (now.isAfter(endOfWork)) {
            completedWorkdays += 1.0;
          } else {
            final secondsWorked = now.difference(startOfWork).inSeconds;
            final maxSeconds = endOfWork.difference(startOfWork).inSeconds;
            completedWorkdays += (secondsWorked / maxSeconds).clamp(0.0, 1.0);
          }
        }
      }
    }

    final accumulatedSalary = completedWorkdays * salaryPerWorkday;
    final monthProgress = (completedWorkdays / totalWorkdays).clamp(0.0, 1.0);

    return SalaryCalculationResult(
      monthlySalary: monthlySalary,
      totalWorkdays: totalWorkdays,
      salaryPerWorkday: salaryPerWorkday,
      salaryPerHour: salaryPerHour,
      accumulatedSalary: accumulatedSalary,
      monthProgress: monthProgress,
      monthStart: monthStart,
      monthEnd: monthEnd,
    );
  }
}
