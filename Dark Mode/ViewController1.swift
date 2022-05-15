//
//  ViewController.swift
//  Dark Mode
//
//  Created by Jet on 15/08/2021.
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet weak var darkModeLabel: UILabel!
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        if let darkStatus = defaults.string(forKey: "dark_mode"){
            darkModeLabel.text = darkStatus
            
            if(darkStatus == "Light"){
                overrideUserInterfaceStyle = .light
            }else if (darkStatus == "Dark"){
                overrideUserInterfaceStyle = .dark
            }else if (darkStatus == "System"){
                overrideUserInterfaceStyle = .unspecified
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

}

