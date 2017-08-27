//
//  LocationManagerExtension.swift
//  OCExpoX-Giveaway-iOS
//
//  Created by Selenzow, Eduard on 29.05.17.
//  Copyright © 2017 OPITZ CONSULTING GmbH. All rights reserved.
//

import UIKit
import CoreLocation

extension ZaehlerViewController: CLLocationManagerDelegate {
    
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func setupBeaconRegion() {
        let uuid = UUID(uuidString: "699EBC80-E1F3-11E3-9A0F-0CF3EE3BC012")
        beaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: 00004, minor: CLBeaconMinorValue(defaults.string(forKey: UserSettingsViewController.defaultsBeaconID)!)!, identifier: "Giveaway Beacon")
        beaconRegion.notifyOnEntry = true
        beaconRegion.notifyOnExit = false
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.authorizedAlways){
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable(){
                    startScanning()
                }
            }
        }
        else if (status == CLAuthorizationStatus.denied){
            let alert = self.enableAuthorizationAlert()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func startScanning(){
        if defaults.bool(forKey: UserSettingsViewController.defaultsFirstSetup){
            setupBeaconRegion()
            locationManager.startMonitoring(for: beaconRegion)
            locationManager.startRangingBeacons(in: beaconRegion)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            self.statusLabel.text = "Beacon gefunden"
            updateDistance(beacons[0].proximity, beacons: beacons[0])
            if defaults.double(forKey: UserSettingsViewController.defaultsDistanz) != 0.0{
                if (((round((beacons[0].accuracy) * 100)) / 100 <= (defaults.double(forKey: UserSettingsViewController.defaultsDistanz))) && (defaults.double(forKey: UserSettingsViewController.defaultsDistanz)) > 0){
                    if !isWaiting{
                        updateZaehler()
                    }
                    else{self.timer = defaults.double(forKey: UserSettingsViewController.defaultsZeit)}
                }
                else{
                    updateWaitingTime()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if defaults.bool(forKey: AppDelegate.defaultsBackgroundScanKey) {self.registerBackgroundTask()}
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if defaults.bool(forKey: AppDelegate.defaultsBackgroundScanKey) {self.endBackgroundTask()}
    }
    
    func updateDistance(_ distance: CLProximity){
        UIView.animate(withDuration: 1.0) {
            if(distance == .unknown){
                self.didIncreaseCounter = true
                self.statusLabel.text = "nicht gefunden"
                self.distanceLabel.text = "-1m"
            }
            else {
                
            }
        }
    }
    
    func updateDistance(_ distance: CLProximity, beacons: CLBeacon?){
        UIView.animate(withDuration: 1.0) {
            switch distance {
            case .unknown:
                self.updateDistance(.unknown)
            case .far:
                self.distanceLabel.text = String(describing: (round((beacons?.accuracy)! * 100) / 100)) + "m"
            case .near:
                self.distanceLabel.text = String(describing: (round((beacons?.accuracy)! * 100) / 100)) + "m"
            case .immediate:
                self.distanceLabel.text = String(describing: (round((beacons?.accuracy)! * 100) / 100)) + "m"
            }
        }
    }
    
    func updateWaitingTime() {
        UIView.animate(withDuration: 1.0) {
            if self.timer == 0.0 {
                self.zeitLabel.text = "0s"
                self.didIncreaseCounter = false
                self.isWaiting = false
            }else {
                self.isWaiting = true
                self.timer = self.timer.subtracting(1.0)
                self.zeitLabel.text = String(describing: Int(round(self.timer))) + "s"
            }
        }
    }
    
    func updateZaehler(){
        if self.timer == 0.0{
            if(!didIncreaseCounter){
                self.zaehler = zaehler + 1
                self.zaehlerLabel.text = String(self.zaehler)
                self.didIncreaseCounter = true
                self.isWaiting = true
                timer = TimeInterval(defaults.double(forKey: UserSettingsViewController.defaultsZeit))
                self.zeitLabel.text = "\(timer)s"
            }
        }
        
    }
    
    func enableAuthorizationAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Keine Berechtigung", message: "Bitte stellen Sie in den Einstellungen die Benachrichtigungen wieder ein", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Abbrechen", style: .cancel, handler: nil)
        let toSettings = UIAlertAction(title: "Zu den Einstellungen", style: .default, handler: { (action) in
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: { (completed) in
                
            })
        })
        alert.addAction(cancel)
        alert.addAction(toSettings)
        return alert
    }
}
