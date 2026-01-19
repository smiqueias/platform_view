import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        
        if let registrar = self.registrar(forPlugin: "OffshoreFx") {
            let factory = OffshoreFxFactory(messenger: registrar.messenger())
            
            registrar.register(
                factory,
                withId: "offshore_fx_view"
            )
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
