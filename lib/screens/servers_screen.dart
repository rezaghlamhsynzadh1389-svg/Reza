import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../services/panel_service.dart';
import '../services/vpn_controller.dart';
import 'add_subscription_screen.dart';

class ServersScreen extends StatefulWidget {
  const ServersScreen({super.key});

  @override
  State<ServersScreen> createState() => _ServersScreenState();
}

class _ServersScreenState extends State<ServersScreen> {
  List<VpnServer> _servers = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final url = await PanelService.getSavedSubscriptionUrl();
    if (url == null) {
      setState(() {
        _loading = false;
        _error = 'هنوز لینک اشتراک پنل را وارد نکرده‌اید.';
      });
      return;
    }
    try {
      final servers = await PanelService.fetchServers(url);
      setState(() {
        _servers = servers;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vpn = context.read<VpnController>();

    return Scaffold(
      appBar: AppBar(title: const Text('انتخاب سرور')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(builder: (context) {
            if (_loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (_error != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.inkFaint)),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AddSubscriptionScreen()),
                        );
                        _load();
                      },
                      child: const Text('افزودن لینک اشتراک پنل'),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              itemCount: _servers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 9),
              itemBuilder: (context, i) {
                final s = _servers[i];
                final selected = vpn.currentServer?.rawLink == s.rawLink;
                return GestureDetector(
                  onTap: () {
                    vpn.currentServer = s;
                    Navigator.pop(context);
                  },
                  child: GlassCard(
                    borderColor: selected ? AppColors.neon : null,
                    padding: const EdgeInsets.all(13),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: AppColors.neon.withOpacity(0.15),
                          ),
                          alignment: Alignment.center,
                          child: Text(s.protocol.toUpperCase(),
                              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Text(s.remark,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                        if (selected)
                          const Icon(Icons.check_circle, color: AppColors.neon, size: 18),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
