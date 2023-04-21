import 'package:axon/Book.dart';
import 'package:axon/Events.dart';
import 'package:axon/News.dart';
import 'package:axon/Reports.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  int selectedIndex;
  MyNavigationBar(this.selectedIndex);

  @override
  _MyNavigationBarState createState() =>
      _MyNavigationBarState(this.selectedIndex);
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  int selectedIndex;

  _MyNavigationBarState(this.selectedIndex);
  final List<Widget> user = [
    News(),
    Book(),
    Events(),
    Reports(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.newspaper,
              size: 30,
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book_outlined,
              size: 30,
            ),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_note_sharp,
              size: 30,
            ),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.image_search_rounded,
              size: 30,
            ),
            label: 'Reports',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        selectedItemColor: const Color(0xFFFD5722),
        unselectedItemColor: Colors.grey.shade600,
      ),
    );
  }
}
