import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'services/vpn_controller.dart';


void main() {

  runApp(

    ChangeNotifierProvider(

      create: (_) => VpnController(),

      child: const RZVPNApp(),

    ),

  );

}



class RZVPNApp extends StatelessWidget {

  const RZVPNApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: "RZVPN Pro",

      theme: ThemeData(

        brightness: Brightness.dark,

      ),

      home: const HomeScreen(),

    );

  }

}
