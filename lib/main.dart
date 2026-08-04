import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'services/vpn_controller.dart';
import 'screens/home_screen.dart';
import 'screens/servers_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const RZVpnApp());
}

class RZVpnApp extends StatelessWidget {
  const RZVpnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VpnController()..initialize(),
      child: MaterialApp(
        title: 'RZVPN',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        locale: const Locale('fa', 'IR'),
        builder: (context, child) => Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        ),
        home: const RootShell(),
      ),
    );
  }
}

class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  final _screens = const [
    HomeScreen(),
    ServersScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: AppColors.bg2,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'خانه'),
          NavigationDestination(icon: Icon(Icons.public), label: 'سرورها'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'تنظیمات'),
        ],
      ),
    );
  }
}
