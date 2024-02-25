import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';

class WebCam extends StatefulWidget {
  const WebCam({super.key});

  @override
  State<WebCam> createState() => _WebCamState();
}

class _WebCamState extends State<WebCam> {
  UsbPort? _port;
  StreamSubscription? _streamSubscription;
  Uint8List? _currentFrame;

  @override
  void initState() {
    super.initState();
    _initUsbCommunication();
  }

  Future<void> _initUsbCommunication() async {
    List<UsbDevice> devices = await UsbSerial.listDevices();
    if (devices.isNotEmpty) {
      UsbDevice webcamDevice = devices.firstWhere(
        (device) => device.productName!.contains('YourWebcamIdentifier'),
        orElse: () => throw Exception('Webcam not found'),
      );
      _port = await webcamDevice.create();
      await _port!.open();
      _streamSubscription = _port!.inputStream!.listen((data) {
        setState(() {
          _currentFrame = data;
        });
      });
    } else {
      throw Exception('No USB devices found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USB Webcam'),
      ),
      body: Center(
        child: _currentFrame != null
            ? Image.memory(
                _currentFrame!,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _port?.close();
    super.dispose();
  }
}
