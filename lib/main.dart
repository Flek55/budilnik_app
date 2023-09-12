import 'package:budilnik_fedora/start.dart';
import 'package:budilnik_fedora/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await FlutterBluePlus.turnOn();
  await FlutterBluePlus.adapterState
      .map((s) {
    print(s);
    return s;
  })
      .where((s) => s == BluetoothAdapterState.on)
      .first;
  runApp(MaterialApp(
    theme: theme(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const Start(),
    },
  ));
}

bluet() async {
  Set<DeviceIdentifier> seen = {};
  var subscription = FlutterBluePlus.scanResults.listen(
        (results) {
      for (ScanResult r in results) {
        if (seen.contains(r.device.remoteId) == false) {
          print('${r.device.remoteId}: "${r.device.localName}" found! rssi: ${r
              .rssi}');
          seen.add(r.device.remoteId);
        }
      }
    },
  );
  await FlutterBluePlus.startScan();

  //device.connectionState.listen((BluetoothConnectionState state) async {
  //  if (state == BluetoothConnectionState.disconnected) {
  //  }
  //});

  //await device.connect();
}