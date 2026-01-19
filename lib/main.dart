import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poc_platform_view/offshore_fx_channel.dart';

import 'offshore_fx_model.dart';

void main() {
  runApp(const OffshorePocScreen(),);
}

final class OffshorePocScreen extends StatefulWidget {
  const OffshorePocScreen({super.key});

  @override
  State<OffshorePocScreen> createState() => _OffshorePocScreenState();
}

class _OffshorePocScreenState extends State<OffshorePocScreen> {

  late final OffshoreFxChannel _offshoreFxChannel;
  late final OffshoreFxModel _offshoreFxModel;

  @override
  void initState() {
    super.initState();
    _offshoreFxChannel = .new();
    _offshoreFxModel = .new(accountNumber: 'PBX123',);

  }


  void _openOffshoreFlow(BuildContext context) {
    _offshoreFxChannel.startListening(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: 500,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // A View Nativa
              Expanded(
                child: _NativeView(
                  isAndroid: Platform.isAndroid,
                  offshoreFxModel: _offshoreFxModel,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offshore FX DEMO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Offshore FX",)),
        body: Center(
          child: Builder(
            builder: (innerContext) => ElevatedButton(
              onPressed: () => _openOffshoreFlow(innerContext),
              child: const Text("Abrir Offshore FX"),
            ),
          ),
        ),
      ),
    );
  }
}


final class _NativeView extends StatelessWidget {

  final bool isAndroid;
  final OffshoreFxModel offshoreFxModel;

  final String _viewType;

  const _NativeView({
    required this.isAndroid,
    required this.offshoreFxModel
  }) : _viewType = 'offshore_fx_view' ;

  @override
  Widget build(BuildContext context) {
    return isAndroid ? AndroidView(
      viewType: _viewType,
      creationParams: offshoreFxModel.toJson(),
      creationParamsCodec: const StandardMessageCodec(),
    ) : UiKitView(
      viewType: _viewType,
      creationParams: offshoreFxModel.toJson(),
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
