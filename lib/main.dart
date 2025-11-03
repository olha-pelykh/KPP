import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/daily_data_model.dart';
import 'models/food_item.dart';

import 'screens/login_screen.dart';
import 'screens/main_app_shell.dart'; 

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    
    Hive.registerAdapter(DailyDataModelAdapter()); //серіалізатор/десеріалізатор //Коли я попрошу тебе зберегти об'єкт DailyDataModel, ось інструкція (DailyDataModelAdapter), як перетворити його на байти для збереження на диску
    Hive.registerAdapter(FoodItemAdapter());
    
    await Hive.openBox<DailyDataModel>('dailyLogs');
    await Hive.openBox('userBox'); 

    runApp(const MyApp());

  } catch (e, stacktrace) {
    debugPrint('!!!!!!!!!!!!!! ERROR IN MAIN !!!!!!!!!!!!!!');
    debugPrint(e.toString());
    debugPrint(stacktrace.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: AuthWrapper(), 
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late final Box _userBox;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _userBox = Hive.box('userBox');
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    setState(() {
      _isLoggedIn = _userBox.get('isLoggedIn', defaultValue: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return const MainAppShell();
    } else {
      return const LoginScreen();
    }
  }
}