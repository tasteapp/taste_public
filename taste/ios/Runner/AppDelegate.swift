import UIKit
import Flutter
import GoogleMaps
import AVFoundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let cameraOptionsChannel = FlutterBasicMessageChannel(
            name: "tasteapp.flutter.dev/camera_options",
            binaryMessenger: controller.binaryMessenger,
            codec: FlutterStringCodec.sharedInstance())
        cameraOptionsChannel.setMessageHandler({
            (message: Any?, reply: FlutterReply) -> Void in
            self.handleMessage(reply: reply, message: message as! String)
        })
        GMSServices.provideAPIKey("AIzaSyCrA-_WlGUSyfAGgpBoCQmpmBEbIRWbDBE")
    var flutter_native_splash = 1
    UIApplication.shared.isStatusBarHidden = false

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func handleMessage(reply: FlutterReply, message: String) {
        let(functionType, functionMessage) = self.parseMessage(message: message)
        switch functionType {
        case "AutoFocus":
            self.performAutoFocus(reply: reply, message: functionMessage)
        case "ZoomCamera":
            self.performZoom(reply: reply, message: functionMessage)
        default:
            reply(FlutterError(code: "UNAVAILABLE",
                               message: "Could not interpret function type from message",
                               details: nil))
        }
    }
    
    private func parseMessage(message: String) -> (functionType: String, functionMessage: String) {
        if let splitterIndex = message.firstIndex(of: ":") {
            let startFunctionMessageIndex = message.index(splitterIndex, offsetBy: 1)
            let functionType = String(message[..<splitterIndex])
            let functionMessage = String(message[startFunctionMessageIndex...])
            return (functionType, functionMessage)
        }
        return ("","")
    }
    
    private func performZoom(reply: FlutterReply, message: String) {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) {
            func boundZoom(_ factor: CGFloat) -> CGFloat {
                var minAvailableZoom: CGFloat = 1.0
                var maxAvailableZoom: CGFloat = 4.0
                if #available(iOS 11.0, *) {
                    minAvailableZoom = device.minAvailableVideoZoomFactor
                    maxAvailableZoom = device.maxAvailableVideoZoomFactor
                }
                return min(max(factor, minAvailableZoom), maxAvailableZoom)
            }
            
            do {
                try device.lockForConfiguration()
                let zoomFactor = CGFloat(Double(message) ?? 1.0)
                device.videoZoomFactor = boundZoom(zoomFactor)
                device.unlockForConfiguration()
                reply("Success")
            } catch {}
        } else {
            reply(FlutterError(code: "UNAVAILABLE",
                               message: "Could not zoom",
                               details: nil))
        }
    }
    
    private func performAutoFocus(reply: FlutterReply, message: String) {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) {
            if (device.isFocusModeSupported(AVCaptureDevice.FocusMode.autoFocus)) {
                do {
                    try device.lockForConfiguration()
                    let pointOfInterest = CGPointFromString(message)
                    device.focusPointOfInterest = pointOfInterest
                    device.focusMode = AVCaptureDevice.FocusMode.continuousAutoFocus
                    device.exposurePointOfInterest = pointOfInterest
                    device.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                    device.unlockForConfiguration()
                    reply("Success")
                } catch {}
            }
        } else {
            reply(FlutterError(code: "UNAVAILABLE",
                               message: "Could not set auto focus point",
                               details: nil))
        }
    }
}