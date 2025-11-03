import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'recipes_screen.dart';

class MainAppShell extends StatefulWidget {
  const MainAppShell({super.key});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  int _selectedIndex = 0; 

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    RecipesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => _onItemTapped(0),
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? Colors.black : Colors.black54,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () => _onItemTapped(1),
            icon: Icon(
              Icons.list_alt,
              color: _selectedIndex == 1 ? Colors.black : Colors.black54,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}