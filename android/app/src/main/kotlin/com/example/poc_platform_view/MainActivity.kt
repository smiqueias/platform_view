package com.example.poc_platform_view

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("offshore_fx_view", OffshoreFxFactory(
                messenger = flutterEngine.dartExecutor.binaryMessenger
            ))
    }

}
