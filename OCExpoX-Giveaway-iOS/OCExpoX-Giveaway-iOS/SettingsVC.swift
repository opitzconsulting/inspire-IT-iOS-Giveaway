//
//  SettingsVC.swift
//  OCExpoX-Giveaway-iOS
//
//  Created by Selenzow, Eduard on 29.05.17.
//  Copyright © 2017 OPITZ CONSULTING GmbH. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {
    @IBOutlet weak var scanSettingSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanSettingSwitch.setOn(UserDefaults.standard.bool(forKey: AppDelegate.defaultsBackgroundScanKey), animated: false)
    }

    @IBAction func toogleBackgroundScanning(_ sender: UISwitch) {
        if(scanSettingSwitch.isOn != UserDefaults.standard.bool(forKey: AppDelegate.defaultsBackgroundScanKey)){
            UserDefaults.standard.set(scanSettingSwitch.isOn, forKey: AppDelegate.defaultsBackgroundScanKey)
        }
    }
    
}
