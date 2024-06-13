import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/user/artikel_view.dart';
import 'package:flutter_application_1/views/user/homepage_view.dart';
import 'package:flutter_application_1/views/user/profil_view.dart';

class NavbarUser extends StatefulWidget {
  const NavbarUser({Key? key}) : super(key: key);

  @override
  State<NavbarUser> createState() => _NavbarUser();
}

class _NavbarUser extends State<NavbarUser> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    const HomepageuserView(),
    const ArtikelView(),
    const ProfilView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'Artikel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil'
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey, // Tambahkan warna untuk item yang tidak terpilih
        onTap: _onItemTapped,
      ),
    );
  }
}