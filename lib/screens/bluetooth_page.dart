import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  final List<BluetoothDevice> deviceList =
      List<BluetoothDevice>.empty(growable: true);
  bool isScanning = true;
  @override
  void initState() {
    super.initState();
    _scanState();
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5))
        .whenComplete(_scanState);
    List<BluetoothDevice> devices = FlutterBluePlus.connectedDevices;
    for (BluetoothDevice device in devices) {
      _addBluetoothDevice(device);
    }
    FlutterBluePlus.scanResults.listen((List<ScanResult> scanResult) {
      for (ScanResult result in scanResult) {
        _addBluetoothDevice(result.device);
      }
    });
  }

  _scanState() {
    print("scan function called");
    setState(() {
      if (FlutterBluePlus.isScanningNow) {
        isScanning = true;
      } else {
        isScanning = false;
      }
    });
  }

  _addBluetoothDevice(BluetoothDevice device) {
    if (!deviceList.contains(device)) {
      setState(() {
        deviceList.add(device);
      });
    }
  }

  _connectionState(BluetoothDevice device) {
    Widget widget = ElevatedButton(
      onPressed: () => _connectDevice(device),
      child: const Text("Connect"),
    );
    device.connectionState.listen((BluetoothConnectionState state) {
      if (state == BluetoothConnectionState.connected) {
        setState(() {
          widget = const Text("Connected");
        });
      } else if (state == BluetoothConnectionState.connecting) {
        setState(() {
          widget = const Text("Connecting");
        });
      } else if (state == BluetoothConnectionState.disconnecting) {
        setState(() {
          widget = const Text("Disconnecting");
        });
      }
    });
    return widget;
  }

  _connectDevice(BluetoothDevice device) async {
    try {
      await device.connect();
    } on FlutterBluePlusException catch (e) {
      print(e.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          "GreenVault",
          minFontSize: 15,
          maxFontSize: 20,
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                "Bluetooth devices",
                style: const TextStyle().copyWith(
                  color: Colors.grey.shade600,
                ),
                minFontSize: 15,
                maxFontSize: 20,
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: deviceList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: AutoSizeText(
                      //title medium
                      deviceList[index].advName == ''
                          ? "Unknown device"
                          : deviceList[index].advName,
                      maxLines: 1,
                      minFontSize: 15,
                      maxFontSize: 20,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: AutoSizeText(
                      deviceList[index].id.toString(),
                      maxLines: 1,
                      minFontSize: 5,
                      maxFontSize: 15,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: _connectionState(deviceList[index]),
                  );
                },
              ),
            ),
            (isScanning)
                ? const CircularProgressIndicator.adaptive()
                : Container(),
          ],
        ),
      ),
    );
  }
}
