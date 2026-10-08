import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'salary_screen.dart';
import 'salary_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SalaryTrackerApp());
}

class SalaryTrackerApp extends StatelessWidget {
  const SalaryTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SalaryViewModel(),
      child: MaterialApp(
        title: 'Pro Salário',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const SalaryScreen(),
      ),
    );
  }
}
