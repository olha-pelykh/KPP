import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'main_app_shell.dart';

class AllergiesScreen extends StatefulWidget {
  const AllergiesScreen({super.key});

  @override
  State<AllergiesScreen> createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  final Map<String, bool> _allergies = {
    'Dairy': false,
    'Gluten': false,
    'Nuts': false,
    'Soy': false,
    'Shellfish': false,
    'Eggs': false,
    'Fish': false,
    'Other': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Allergies & Intolerances'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Allergies & Intolerances',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Select any allergies or intolerances you have. You can add more later.',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: _allergies.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: _allergies[key],
                    activeColor: Colors.green,
                    onChanged: (bool? value) {
                      setState(() {
                        _allergies[key] = value ?? false;
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
          onPressed: () async {

            final userBox = Hive.box('userBox');
            await userBox.put('isLoggedIn', true); 
            if (mounted) { 
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainAppShell()),
                (Route<dynamic> route) => false,
              );
            }
          }, 
          child: const Text('Continue'), 
        ),
      ),
    );
  }
}