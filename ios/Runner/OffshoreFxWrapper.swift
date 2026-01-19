//
//  OffshoreFxWrapper.swift
//  Runner
//
//  Created by Saulo Nascimento on 17/01/26.
//

import Flutter
import UIKit
import OffshoreFx

class OffshoreFxWrapper: NSObject, FlutterPlatformView, OffshoreFxCallback {
    private var _view: OffshoreFxView
    private let _channel: FlutterMethodChannel
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        _view = OffshoreFxView(frame: frame)
        _channel = FlutterMethodChannel(name: "offshore_fx_channel", binaryMessenger: messenger)
        
        super.init()
        
        _view.callback = self
        
        
        if let params = args as? [String: Any] {
            if let model = OffshoreFxModel.fromMap(params) {
                _view.initWithData(model)
            }
        }
    }
    
    func view() -> UIView { return _view }
    
    // MARK: - OffshoreFxCallback
    func onSuccess(data: [String: Any]) {
        _channel.invokeMethod("onSuccess", arguments: data)
    }
    
    func onError(errorMessage: String) {
        _channel.invokeMethod("onError", arguments: ["message": errorMessage])
    }
    
    func onPaused() {
        _channel.invokeMethod("onPaused", arguments: nil)
    }
}

class OffshoreFxFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    init(messenger: FlutterBinaryMessenger) { self.messenger = messenger }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return OffshoreFxWrapper(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
