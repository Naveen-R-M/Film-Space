import 'package:film_space/Screens/Home/home_tab.dart';
import 'package:film_space/Screens/Home/video_upload.dart';
import 'package:film_space/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      _selectedIndex,
      duration: Duration(milliseconds: 150),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Film Space',
          style: GoogleFonts.dancingScript(
            fontSize: 22,
            color: Colors.white70,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.75,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Video Upload',
            icon: Icon(Icons.upload_outlined),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTapped,
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) => setState(() {
          _selectedIndex = index;
        }),
        children: [
          HomeTab(),
          VideoUploadScreen(),
        ],
      ),
    );
  }
}
