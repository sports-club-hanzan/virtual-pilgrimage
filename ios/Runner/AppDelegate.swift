import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // GoogleMap用の設定
    let googleApiKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_MAP_API_KEY") as! String
    GMSServices.provideAPIKey(googleApiKey)
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
