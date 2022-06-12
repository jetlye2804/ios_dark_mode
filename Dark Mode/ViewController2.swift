//
//  ViewController2.swift
//  Dark Mode
//
//  Created by Jet on 15/08/2021.
//


import UIKit

class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var darkModeTable: UITableView!
    
    let mode = ["Light", "Dark", "System"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        darkModeTable.dataSource = self
        darkModeTable.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Table View Data Source method
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
     }
    
     // Table View Data Source method
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mode.count
     }

     // Table View Data Source method
     func tableView(_ tableView: UITableView,
     cellForRowAt indexPath: IndexPath)
     -> UITableViewCell {

        var cell: UITableViewCell!

         //take a cell from the queue of reusable cells
         cell = tableView.dequeueReusableCell(
         withIdentifier: "tableCell")

         //if there are no reusable cells
         if cell == nil {
             // create a new cell
             cell = UITableViewCell(
             style: UITableViewCell.CellStyle.default,
             reuseIdentifier: "tableCell")
         }

        // set the textLabel for the cell
         cell!.textLabel!.text = mode[indexPath.row]
        
        // initialize the checkmark based on Light/Dark/System
        if(defaults.string(forKey: "dark_mode") == "Light"){
            if (mode[indexPath.row] == "Light"){
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }
        }
         else if(defaults.string(forKey: "dark_mode") == "Dark"){
            if (mode[indexPath.row] == "Dark"){
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }
        }
         else if(defaults.string(forKey: "dark_mode") == "System"){
            if (mode[indexPath.row] == "System"){
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }
        }

         // return the Table View Cell
         return cell!
     }

    // Table View Delegate method
    func tableView(_ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath) {
        
        //clear previous stored checked indexPath
        for row in 0..<tableView.numberOfRows(inSection: indexPath.section) {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: indexPath.section)) {
                cell.accessoryType = row == indexPath.row ? .checkmark : .none
            }
        }
        
        let backVC = presentingViewController as! UINavigationController
        let mainVC = backVC.topViewController as! ViewController1

        if(mode[indexPath.row] == "Light")
        {
            if let window = UIWindow.key{
                UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    window.overrideUserInterfaceStyle = .light
                }, completion: nil)
            }
            defaults.set("Light", forKey: "dark_mode")
        }
        else if(mode[indexPath.row] == "Dark")
        {
            if let window = UIWindow.key{
                UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    window.overrideUserInterfaceStyle = .dark
                }, completion: nil)
            }
            defaults.set("Dark", forKey: "dark_mode")
        }
        else if(mode[indexPath.row] == "System")
        {
            if let window = UIWindow.key{
                UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    window.overrideUserInterfaceStyle = .unspecified
                }, completion: nil)
            }
            defaults.set("System", forKey: "dark_mode")
        }
        if let darkStatus = defaults.string(forKey: "dark_mode"){
            mainVC.darkModeLabel.text = darkStatus
        }
        setNeedsStatusBarAppearanceUpdate()
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

