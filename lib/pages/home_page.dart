import 'package:flutter/material.dart';
import 'package:boescapetodo/pages/today.dart';
import 'package:boescapetodo/pages/todo.dart';
import 'package:boescapetodo/pages/calendar_page.dart'; // <-- Add this line

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    TodayPage(),
    TodoPage(),
    CalendarPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow[700],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm, color: Colors.white, size: 20),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time, color: Colors.white),
            label: 'To-Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.white), // <-- Add this line
            label: 'Calendar', // <-- Add this line
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}











