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
  @override
  void initState() {
    super.initState();
    _isScanning();
    List<BluetoothDevice> devices = FlutterBluePlus.connectedDevices;
    _getConnectedDevices(FlutterBluePlus.systemDevices);
    for (BluetoothDevice device in devices) {
      _addBluetoothDevice(device);
    }
    FlutterBluePlus.scanResults.listen((List<ScanResult> scanResult) {
      for (ScanResult result in scanResult) {
        _addBluetoothDevice(result.device);
      }
    });
  }

  _getConnectedDevices(Future<List<BluetoothDevice>> devices) async {
    List list = await devices;
    for (var val in list) {
      _addBluetoothDevice(val);
    }
  }

  _isScanning() async {
    print(await FlutterBluePlus.adapterName);
    await FlutterBluePlus.turnOn(timeout: 5);
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 15))
        .whenComplete(() async {
      await Future.delayed(const Duration(seconds: 15));
      setState(() {});
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
      onPressed: () async {
        try {
          await device.connect().whenComplete(() {
            setState(() {});
          });
          print("Connection successful");
        } on FlutterBluePlusException catch (error) {
          print(error.description);
        }
      },
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
      setState(() {});
    } on FlutterBluePlusException catch (e) {
      print(e.description);
    }
  }

  @override
  void dispose() {
    super.dispose();
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
        actions: <Widget>[
          (FlutterBluePlus.isScanningNow)
              ? TextButton(
                  onPressed: () {
                    FlutterBluePlus.stopScan();
                    setState(() {});
                  },
                  child: Text(
                    "Stop",
                    style: const TextStyle().copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              : TextButton(
                  onPressed: _isScanning,
                  child: Text(
                    "Scan",
                    style: const TextStyle().copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          _isScanning();
          return Future.delayed(const Duration(milliseconds: 500));
        },
        child: Container(
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
                        deviceList[index].remoteId.toString(),
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
            ],
          ),
        ),
      ),
    );
  }
}
