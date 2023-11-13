import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/dashboard/profile/profile_screen.dart';
import 'package:tech_media/view/dashboard/users/user_list_screen.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreen() {
    return [
      Text("Home"),
      Text("Add"),
      Text("Chat"),
      UserListScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navbarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home,
        ),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveColorPrimary: AppColors.grayColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveColorPrimary: AppColors.grayColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.add,
          color: AppColors.grayColor,
        ),
        inactiveIcon: const Icon(
          Icons.add,
          color: AppColors.grayColor,
        ),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveColorPrimary: AppColors.whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveColorPrimary: AppColors.grayColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        inactiveIcon: const Icon(Icons.person_outline),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveColorPrimary: AppColors.grayColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      items: _navbarItem(),
      screens: _buildScreen(),
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      navBarStyle: NavBarStyle.style15,
      backgroundColor: AppColors.otpHintColor,
    );
  }
}

/*

 return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;

              auth.signOut().then((value) {
                SessionController().userId = '';
                Navigator.of(context).pushNamed(RouteName.loginView);
              });
            },
            icon: const Icon(Icons.login_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(SessionController().userId!),
        ],
      ),
    );
  
 */
