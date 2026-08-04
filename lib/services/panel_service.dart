import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VpnServer {
  final String remark;
  final String rawLink;
  final String protocol;

  VpnServer({
    required this.remark,
    required this.rawLink,
    required this.protocol,
  });
}

class PanelService {
  static const _kSubUrlKey = 'rzvpn_subscription_url';

  static Future<void> saveSubscriptionUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSubUrlKey, url);
  }

  static Future<String?> getSavedSubscriptionUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kSubUrlKey);
  }

  static Future<List<VpnServer>> fetchServers(String subscriptionUrl) async {
    final res = await http.get(Uri.parse(subscriptionUrl), headers: {
      'User-Agent': 'v2rayNG/1.8.0',
    });

    if (res.statusCode != 200) {
      throw Exception('پنل با کد ${res.statusCode} پاسخ داد. لینک اشتراک را بررسی کنید.');
    }

    String body = res.body.trim();

    try {
      body = utf8.decode(base64.decode(base64.normalize(body)));
    } catch (_) {}

    final lines = body.split('\n').where((l) => l.trim().isNotEmpty).toList();
    final servers = <VpnServer>[];

    for (final line in lines) {
      final trimmed = line.trim();
      final protocol = trimmed.split('://').first;
      if (!['vmess', 'vless', 'trojan', 'ss'].contains(protocol)) continue;

      String remark = protocol.toUpperCase();
      try {
        final uri = Uri.parse(trimmed);
        if (uri.fragment.isNotEmpty) {
          remark = Uri.decodeComponent(uri.fragment);
        }
      } catch (_) {}

      servers.add(VpnServer(remark: remark, rawLink: trimmed, protocol: protocol));
    }

    return servers;
  }
}
