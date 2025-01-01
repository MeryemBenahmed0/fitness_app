import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome
import 'package:test_app/screens/add_goal_screen.dart';
import 'package:test_app/screens/category_screen.dart';
import 'package:test_app/screens/myworkout_screen.dart';
import 'package:test_app/screens/other_page.dart';
import 'package:test_app/screens/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List of pages to navigate to
  final List<Widget> _pages = [
    const ProfileScreen(),            // Profile page
    const AddGoalScreen(),            // Add Goal page
    const CategoriesPage(),
   MyWorkoutsPage(),       // Categories page
        // My Saved Workouts page
    const OtherScreen(),              // Example other screen
  ];

  // Handle item tap to switch pages
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Body displays selected page

      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0), // Add rounding to the top corners
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          backgroundColor: const Color.fromARGB(255, 237, 238, 244), // Set background color of bottom nav
          selectedItemColor: const Color.fromARGB(255, 24, 30, 35), // Change color of selected tab
          unselectedItemColor: const Color.fromARGB(255, 45, 58, 93), // Change color of unselected tabs
          showUnselectedLabels: false, // Hide labels for unselected tabs
          elevation: 5.0, // Add shadow for depth

          items: [
            BottomNavigationBarItem(
              icon: _buildIcon(FontAwesomeIcons.userAlt, 0), // Full user icon
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(FontAwesomeIcons.plusCircle, 1), // Font Awesome plus-circle icon
              label: 'Add Goal',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(FontAwesomeIcons.list, 2), // Font Awesome list icon for Categories
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(FontAwesomeIcons.bookmark, 3), // Font Awesome bookmark icon for My Saved Workouts
              label: 'My Workouts',
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              icon: _buildIcon(FontAwesomeIcons.ellipsisH, 4), // Font Awesome ellipsis-h icon
              label: 'Other',
            ),
          ],
        ),
      ),
    );
  }

  // Custom method to create icon with animations
  Widget _buildIcon(IconData icon, int index) {
    bool isSelected = _currentIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: isSelected ? 55 : 45, // Adjusted size for hover
      height: isSelected ? 55 : 45, // Adjusted size for hover
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16), // Rounded square hover effect
        color: isSelected
            ? const Color.fromARGB(255, 165, 191, 221) // Light blue background when selected
            : Colors.transparent, // Transparent background when not selected
      ),
      child: Center(
        child: FaIcon( // Use FaIcon widget for Font Awesome icons
          icon,
          color: isSelected ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 45, 58, 93),
          size: isSelected ? 24 : 20, // Adjusted icon size
        ),
      ),
    );
  }
}
