import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../services/vpn_controller.dart';
import 'servers_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vpn = context.watch<VpnController>();
    final connected = vpn.state == VpnState.connected;
    final connecting = vpn.state == VpnState.connecting;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            Column(
              children: [
                const Icon(Icons.shield_outlined, color: AppColors.neon2, size: 30),
                const SizedBox(height: 6),
                const Text('RZVPN',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                const Text('VPN سریع، امن و پایدار',
                    style: TextStyle(fontSize: 11, color: AppColors.inkFaint)),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: (connected ? AppColors.green : AppColors.red).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: (connected ? AppColors.green : AppColors.red).withOpacity(0.35)),
              ),
              child: Row(
