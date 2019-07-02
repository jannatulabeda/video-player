//
//  Helper.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit

class Helper: NSObject {
    static let shared: Helper = Helper()
    
    // Custom log function
    func log(object: Any?) {
        if let _object = object {
            #if DEBUG
            print(_object)
            #endif
        }
    }
    
    // Show alert
    func showAlert(title: String? = "", message: String? = "") {
        let okText = "ok"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okayButton)
        if let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let _window = appDelegate.window, let _rootViewController = _window.rootViewController {
                _rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // Orientation lock function
    func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    // Method to adjust lock and rotate to the desired orientation
    func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        Helper.shared.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}
