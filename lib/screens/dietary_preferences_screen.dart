import 'package:flutter/material.dart';
import 'allergies_screen.dart';

class DietaryPreferencesScreen extends StatefulWidget {
  const DietaryPreferencesScreen({super.key});

  @override
  State<DietaryPreferencesScreen> createState() =>
      _DietaryPreferencesScreenState();
}

class _DietaryPreferencesScreenState extends State<DietaryPreferencesScreen> {
  final Map<String, bool> _preferences = {
    'Vegetarian': false,
    'Vegan': false,
    'Keto': false,
    'Paleo': false,
    'Gluten-Free': false,
    'Dairy-Free': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dietary Preferences'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dietary Preferences',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Select all that apply to your dietary preferences. This helps us tailor your wellness plan.',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: _preferences.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: _preferences[key],
                    activeColor: Colors.green,
                    onChanged: (bool? value) {
                      setState(() {
                        _preferences[key] = value ?? false;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllergiesScreen()),
            );
          },
          child: const Text('Continue'),
        ),
      ),
    );
  }
}