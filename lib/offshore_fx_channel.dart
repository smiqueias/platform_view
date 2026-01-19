import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final class OffshoreFxChannel {
  final MethodChannel _channel = const MethodChannel('offshore_fx_channel');

  void startListening(BuildContext context) {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onSuccess':
          final data = call.arguments;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Sucesso Nativo: $data"), backgroundColor: Colors.green,),
          );
          Navigator.pop(context);
          break;

        case 'onError':
          final error = call.arguments['message'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erro Nativo: $error"), backgroundColor: Colors.red,),
          );
          Navigator.pop(context);

          break;

        case 'onPaused':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("onPaused Nativo"), backgroundColor: Colors.black,),
          );
          Navigator.pop(context);

          break;
      }
    });
  }
}