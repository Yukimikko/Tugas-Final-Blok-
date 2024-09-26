import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for SystemChrome usage
import 'package:tokoonline/constans.dart'; // Ensure Palette is defined here
import 'package:tokoonline/users/akunpage.dart';
import 'package:tokoonline/users/beranda.dart';
import 'package:tokoonline/users/favoritepage.dart';
import 'package:tokoonline/users/keranjangpage.dart';
import 'package:tokoonline/users/transaksipage.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}


class _LandingPageState extends State<LandingPage> {
  int _bottomNavCurrentIndex = 0;

  final List<Widget> _container = [
    Beranda(),
    FavoritePage(),
    KeranjangPage(),
    TransaksiPage(),
    AkunPage(),
  ];

  @override
  void initState() {
    super.initState();
    
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Palette.bg1,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[_bottomNavCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Palette.bg1,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index >= 0 && index < _container.length) {
            setState(() {
              _bottomNavCurrentIndex = index;
            });
          }
        },
        currentIndex: _bottomNavCurrentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Palette.bg1, // Active icon color
            ),
            icon: Icon(
              Icons.home,
              color: Colors.grey, // Inactive icon color
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            activeIcon: new Icon(
              Icons.favorite,
              color: Palette.bg1,
            ),
            icon: Icon(
              Icons.favorite_border,
              color: Palette.bg1,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.shopping_cart,
              color: Palette.bg1,
            ),
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.grey,
            ),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.swap_horiz_sharp,
              color: Palette.bg1,
            ),
            icon: Icon(
              Icons.swap_horiz_sharp,
              color: Colors.grey,
            ),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            activeIcon: new Icon(
              Icons.person,
              color: Palette.bg1,
            ),
            icon: Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
