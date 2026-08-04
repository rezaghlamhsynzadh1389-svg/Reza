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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: connected ? AppColors.green : AppColors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    connecting
                        ? 'در حال اتصال…'
                        : connected
                            ? 'متصل شد'
                            : 'قطع شده',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: connected ? AppColors.green : AppColors.red,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                if (connected) {
                  await vpn.disconnect();
                } else if (vpn.currentServer != null) {
                  await vpn.connect(vpn.currentServer!);
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ServersScreen()));
                }
              },
              child: SizedBox(
                width: 210,
                height: 210,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 210,
                      height: 210,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.neon.withOpacity(0.25)),
                      ),
                    ),
                    Container(
                      width: 172,
                      height: 172,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.neon.withOpacity(0.35)),
                      ),
                    ),
                    Container(
                      width: 138,
                      height: 138,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF2A1747),
                            AppColors.bg,
                          ],
                        ),
                        border: Border.all(color: AppColors.neon2.withOpacity(0.4)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neon.withOpacity(0.35),
                            blurRadius: 40,
                            spreadRadius: -4,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.power_settings_new,
                              color: AppColors.neon2, size: 32),
                          const SizedBox(height: 6),
                          Text(
                            connecting
                                ? 'CONNECTING'
                                : connected
                                    ? 'CONNECTED'
                                    : 'CONNECT',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const ServersScreen())),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [AppColors.neon, AppColors.cyan]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      vpn.currentServer?.remark ?? 'انتخاب سرور',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_left, size: 16, color: AppColors.inkFaint),
                  ],
                ),
              ),
            ),
            const Spacer(),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 9,
              crossAxisSpacing: 9,
              childAspectRatio: 2.6,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _StatCard(label: 'کاربر', value: 'Reza_M'),
                _StatCard(label: 'حجم باقی‌مانده', value: '12.4 GB'),
                _StatCard(label: 'تاریخ انقضا', value: '1404/07/02'),
                _StatCard(label: 'سرور', value: 'DE-02'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontSize: 9, color: AppColors.inkFaint)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.neon2)),
        ],
      ),
    );
  }
}
