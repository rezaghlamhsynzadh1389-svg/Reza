import 'package:flutter/foundation.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import '../services/panel_service.dart';

enum VpnState { disconnected, connecting, connected, disconnecting }

class VpnController extends ChangeNotifier {
  late final FlutterV2ray _v2ray;

  VpnState state = VpnState.disconnected;
  VpnServer? currentServer;
  String duration = '00:00:00';
  String uploadSpeed = '0 KB/s';
  String downloadSpeed = '0 KB/s';

  VpnController() {
    _v2ray = FlutterV2ray(
      onStatusChanged: (status) {
        duration = status.duration;
        uploadSpeed = status.uploadSpeed.toString();
        downloadSpeed = status.downloadSpeed.toString();
        if (status.state == 'CONNECTED') {
          state = VpnState.connected;
        } else if (status.state == 'CONNECTING') {
          state = VpnState.connecting;
        } else {
          state = VpnState.disconnected;
        }
        notifyListeners();
      },
    );
  }

  Future<void> initialize() async {
    await _v2ray.initializeV2Ray(
      notificationIconResourceType: 'mipmap',
      notificationIconResourceName: 'ic_launcher',
    );
  }

  Future<int> pingServer(VpnServer server) async {
    try {
      final parsed = FlutterV2ray.parseFromURL(server.rawLink);
      return await _v2ray.getServerDelay(config: parsed.getFullConfiguration());
    } catch (_) {
      return -1;
    }
  }

  Future<void> connect(VpnServer server) async {
    state = VpnState.connecting;
    notifyListeners();

    final hasPermission = await _v2ray.requestPermission();
    if (!hasPermission) {
      state = VpnState.disconnected;
      notifyListeners();
      throw Exception('اجازه‌ی ساخت اتصال VPN داده نشد.');
    }

    final parsed = FlutterV2ray.parseFromURL(server.rawLink);

    await _v2ray.startV2Ray(
      remark: server.remark,
      config: parsed.getFullConfiguration(),
      proxyOnly: false,
      notificationDisconnectButtonName: 'قطع اتصال',
    );

    currentServer = server;
    state = VpnState.connected;
    notifyListeners();
  }

  Future<void> disconnect() async {
    state = VpnState.disconnecting;
    notifyListeners();
    await _v2ray.stopV2Ray();
    state = VpnState.disconnected;
    currentServer = null;
    notifyListeners();
  }
}
