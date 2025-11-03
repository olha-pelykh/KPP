import 'package:flutter/material.dart';
import 'about_you_screen.dart'; 

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  String? _selectedGoal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Goal'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What\'s your main goal?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'We\'ll tailor your experience based on your primary health objective.',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            const SizedBox(height: 32),
            _buildGoalButton('Lose Weight'),
            _buildGoalButton('Build Muscle'),
            _buildGoalButton('Improve Overall Health'),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          onPressed: _selectedGoal == null ? null : () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutYouScreen()),
            );
          },
          child: const Text('Continue'),
        ),
      ),
    );
  }

  Widget _buildGoalButton(String title) {
    final bool isSelected = _selectedGoal == title;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _selectedGoal = title;
          });
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? Colors.green : Colors.white,
          side: BorderSide(
            color: isSelected ? Colors.green : Colors.grey[400]!,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}