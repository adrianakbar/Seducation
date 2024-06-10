import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/admin/listaduan_view.dart';
import 'package:flutter_application_1/views/admin/listartikel_view.dart';
import 'package:flutter_application_1/views/admin/listmentor_view.dart';
import 'package:flutter_application_1/views/admin/tambahmentor_view.dart';
import 'package:flutter_application_1/views/user/aduan_view.dart';


class NavbarAdmin extends StatefulWidget {
  const NavbarAdmin({Key? key}) : super(key: key);

  @override
  State<NavbarAdmin> createState() => _NavbarAdmin();
}

class _NavbarAdmin extends State<NavbarAdmin> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ListaduanView(),
    ListartikelView(),
    ListmentorView(),
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
            icon: Icon(Icons.article_rounded),
            label: 'Aduan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Artikel',
          ),
    BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mentor',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey, // Tambahkan warna untuk item yang tidak terpilih
        onTap: _onItemTapped,
      ),
    );
  }
}