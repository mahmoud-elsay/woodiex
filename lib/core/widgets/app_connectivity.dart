import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:woodiex/core/screens/no_net_working_screen.dart';

class AppConnectivity extends StatelessWidget {
  final Widget child;

  const AppConnectivity({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivityResults,
        Widget child,
      ) {
        final bool connected = connectivityResults.isNotEmpty &&
            !connectivityResults.contains(ConnectivityResult.none);
        return connected ? child : const NoNetWorkScreen();
      },
      child: child,
    );
  }
}
