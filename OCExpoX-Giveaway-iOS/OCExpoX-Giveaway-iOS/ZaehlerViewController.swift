//
//  ViewController.swift
//  OCExpoX-Giveaway-iOS
//
//  Created by Selenzow, Eduard on 15.05.17.
//  Copyright © 2017 OPITZ CONSULTING GmbH. All rights reserved.
//

import UIKit
import CoreLocation
import Popover

class ZaehlerViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var beaconLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var zeitLabel: UILabel!
    @IBOutlet weak var bezeichnerLabel: UILabel!
    @IBOutlet weak var zaehlerLabel: UILabel!
    
    var locationManager: CLLocationManager!
    var beaconRegion: CLBeaconRegion!
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    var inbackground: Bool = false
    let defaults = UserDefaults.standard
    var zaehler = 0
    var didIncreaseCounter: Bool = true
    var isWaiting: Bool = true
    var timer: TimeInterval = TimeInterval()
    
    let texts = ["Einstellungen", "Hilfe", "Datenschutz", "Über"]
    var popover: Popover!
    var popoverOptions: [PopoverOption] = [.type(.down), .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupLocationManager()
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        setupValuesOfLabels()
        zaehler = defaults.integer(forKey: AppDelegate.defaultZaehlerStand)
        zaehlerLabel.text = String(zaehler)
        didIncreaseCounter = defaults.bool(forKey: AppDelegate.defaultDidIncreaseCounter)
        timer = defaults.double(forKey: AppDelegate.defaultTimer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupValuesOfLabels()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        defaults.set(zaehler, forKey: AppDelegate.defaultZaehlerStand)
        defaults.set(didIncreaseCounter, forKey: AppDelegate.defaultDidIncreaseCounter)
        defaults.set(timer, forKey: AppDelegate.defaultTimer)
        defaults.synchronize()
    }

    @IBAction func resetButtonPressed(_ sender: UIButton) {
        zaehler = 0
        zaehlerLabel.text = String(zaehler)
    }
    
    @IBAction func tappedRightBarButton(_ sender: UIBarButtonItem) {
        setupPopoverTableView()
    }
    
    func setupValuesOfLabels() {
        if defaults.bool(forKey: UserSettingsViewController.defaultsFirstSetup) {
            beaconLabel.text = defaults.string(forKey: UserSettingsViewController.defaultsBeaconID)
            bezeichnerLabel.text = defaults.string(forKey: UserSettingsViewController.defaultsBezeichner)
            self.timer = defaults.double(forKey: AppDelegate.defaultTimer)
            self.updateWaitingTime()
            startScanning()
        }
        else{
            let alert = self.createAlertController()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func createAlertController() -> UIAlertController{
        let alert = UIAlertController(title: "Erstinitialisierung", message: "Bitte gehen Sie in die Einstellungen und legen Sie Startwerte vor der ersten Inbetriebnahme fest.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okButton)
        return alert
    }
    
    //Backgroundtask functionality
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }
    
    func endBackgroundTask() {
        defaults.set(zaehler, forKey: AppDelegate.self.defaultZaehlerStand)
        defaults.synchronize()
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }
    
    func observeState() {
        switch UIApplication.shared.applicationState {
        case .active:
            inbackground = false
        case .background:
            inbackground = true
        default: break
        }
    }
    
    func reinstateBackgroundTask() {
        if !inbackground  && (backgroundTask == UIBackgroundTaskInvalid) {
            registerBackgroundTask()
        }
    }

}

