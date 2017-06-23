//
//  BackgroundTaskExtension.swift
//  OCExpoX-Giveaway-iOS
//
//  Created by Selenzow, Eduard on 09.06.17.
//  Copyright © 2017 OPITZ CONSULTING GmbH. All rights reserved.
//

import UIKit

extension ZaehlerViewController {
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
