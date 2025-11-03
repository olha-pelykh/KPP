import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/daily_data_model.dart';
import '../models/food_item.dart';
import 'package:hive/hive.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  
  final _dailyLogsBox = Hive.box<DailyDataModel>('dailyLogs');
  
  late DailyDataModel _currentDayData;

  final Map<String, bool> _isMealExpanded = {
    'Breakfast': false,
    'Lunch time': false,
    'Dinner': false,
  };

  final int _targetProtein = 70;
  final int _targetFats = 70;
  final int _targetCarbs = 70;

  @override
  void initState() {
    super.initState();
    _loadDataForDate(_selectedDate);
  }

  String _formatDateKey(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void _loadDataForDate(DateTime date) {
    final dateKey = _formatDateKey(date);
    _currentDayData = _dailyLogsBox.get(
      dateKey,
      defaultValue: DailyDataModel.empty(),
    )!;
  }

  Future<void> _saveData() async {
    final dateKey = _formatDateKey(_selectedDate);
    await _dailyLogsBox.put(dateKey, _currentDayData);
  }

  void _addExampleFood(String mealType) {
    final newFood = FoodItem(
      name: 'Pancakes',
      details: '150g/220 kcal',
      imagePath: 'assets/images/pancakes.png', 
      
      protein: 16,
      fats: 8,
      carbs: 10,
      calories: 224,

      rating: 4.8,
      ratingCount: 139,
      ingredients: {
        'Butter': '50g',
        'Sugar': '60g',
        'Egg': '2',
      },
      tags: ['breakfast', 'sweet'],
    );

    setState(() {
      _currentDayData.meals[mealType]?.add(newFood);
      
      _currentDayData.totalProtein += newFood.protein;
      _currentDayData.totalFats += newFood.fats;
      _currentDayData.totalCarbs += newFood.carbs;

      _saveData();
    });
  }

  Future<void> _logout() async {
    final userBox = Hive.box('userBox');
    await userBox.put('isLoggedIn', false);

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }
  
  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(radius: 24, child: Icon(Icons.person)),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Have a nice day!', style: TextStyle(color: Colors.grey)),
            Text(
              'Olya Pelykh',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined, size: 28),
        ),
        IconButton(
          onPressed: _logout,
          icon: const Icon(Icons.logout, size: 28, color: Colors.red),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildMacros(),
            const SizedBox(height: 24),
            _buildWaterTracker(),
            const SizedBox(height: 24),
            _buildCalendar(),
            const SizedBox(height: 24),
            _buildMealCard('Breakfast', 320, 460),
            const SizedBox(height: 16),
            _buildMealCard('Lunch time', 320, 460),
            const SizedBox(height: 16),
            _buildMealCard('Dinner', 300, 360),
          ],
        ),
      ),
    );
  }

  Widget _buildMacros() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildMacroRow(
            'Protein',
            _currentDayData.totalProtein, 
            _targetProtein,
          ),
          _buildMacroRow(
            'Fats',
            _currentDayData.totalFats, 
            _targetFats,
          ),
          _buildMacroRow(
            'Carbohydrates',
            _currentDayData.totalCarbs, 
            _targetCarbs,
          ),
        ],
      ),
    );
  }

  Widget _buildMacroRow(String title, int current, int target) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            '$current/$target',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterTracker() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                bool isFilled = index < _currentDayData.waterCups;
                return InkWell(
                  onTap: () {
                    setState(() {
                      int newCount;
                      if (index == _currentDayData.waterCups - 1) {
                        newCount = _currentDayData.waterCups - 1;
                      } else {
                        newCount = index + 1;
                      }
                      _currentDayData.waterCups = newCount;
                      _saveData();
                    });
                  },
                  child: Icon(
                    isFilled ? Icons.local_drink : Icons.local_drink_outlined,
                    size: 30,
                    color: isFilled ? Colors.blue : Colors.grey[300],
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              Text(
                '${_currentDayData.waterCups}/8 cups', 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                '(${(0.25 * _currentDayData.waterCups).toStringAsFixed(2)} L)',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.local_drink, size: 50, color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    DateTime startOfWeek =
        _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('MMMM yyyy').format(_selectedDate),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedDate =
                          _selectedDate.subtract(const Duration(days: 7));
                      _loadDataForDate(_selectedDate);
                    });
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedDate = _selectedDate.add(const Duration(days: 7));
                      _loadDataForDate(_selectedDate); 
                    });
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final date = startOfWeek.add(Duration(days: index));
            final isSelected = date.day == _selectedDate.day &&
                date.month == _selectedDate.month;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = date;
                  _loadDataForDate(date);
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.grey[300] : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat('E').format(date).substring(0, 1),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date.day.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildMealCard(String title, int currentKcal, int totalKcal) {
    bool isExpanded = _isMealExpanded[title] ?? false;
    List<FoodItem> items = _currentDayData.meals[title] ?? [];

    return InkWell(
      onTap: () {
        setState(() {
          _isMealExpanded[title] = !isExpanded;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    const Icon(Icons.flash_on, color: Colors.orange, size: 20),
                    Text(
                      '$currentKcal/$totalKcal kcal',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            if (isExpanded) _buildExpandedMealContent(items, title),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedMealContent(List<FoodItem> items, String mealType) {
    return Column(
      children: [
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.fastfood, color: Colors.grey[600]), 
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                      Text(item.details,
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  Checkbox(
                    value: item.isEaten,
                    activeColor: Colors.green,
                    onChanged: (bool? value) {
                      setState(() {
                        item.isEaten = value ?? false;
                        _saveData();
                      });
                    },
                  )
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            _addExampleFood(mealType);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add meal',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.add, color: Colors.black),
            ],
          ),
        ),
      ],
    );
  }
}