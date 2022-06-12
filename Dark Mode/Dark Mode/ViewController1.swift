//
//  ViewController.swift
//  Dark Mode
//
//  Created by Jet on 15/08/2021.
//

import UIKit

// For iOS 15, windows has been deprecated
extension UIWindow {
    static var key: UIWindow? {
        return UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
    }
}

class ViewController1: UIViewController {

    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var modalButton: UIButton!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main Screen"
        
        modalButton.configuration = .filled()
        
        if let window = UIWindow.key {
            if let darkStatus = defaults.string(forKey: "dark_mode"){
                darkModeLabel.text = darkStatus
                
                if(darkStatus == "Light"){
                    window.overrideUserInterfaceStyle = .light
                }else if (darkStatus == "Dark"){
                    window.overrideUserInterfaceStyle = .dark
                }else if (darkStatus == "System"){
                    window.overrideUserInterfaceStyle = .unspecified
                }
            } else {
                darkModeLabel.text = "System"
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

}

