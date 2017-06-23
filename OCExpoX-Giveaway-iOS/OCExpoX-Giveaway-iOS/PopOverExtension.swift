//
//  File.swift
//  OCExpoX-Giveaway-iOS
//
//  Created by Selenzow, Eduard on 29.05.17.
//  Copyright © 2017 OPITZ CONSULTING GmbH. All rights reserved.
//

import UIKit
import Popover

extension ZaehlerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: self.performSegue(withIdentifier: "showSettings", sender: self)
        case 1: self.performSegue(withIdentifier: "showHilfe", sender: self)
        case 2: self.performSegue(withIdentifier: "showDatenschutz", sender: self)
        case 3: self.performSegue(withIdentifier: "showAbout", sender: self)
        default:    break
        }
        
        self.popover.dismiss()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = self.texts[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func setupPopoverTableView() {
        let startPoint = CGPoint(x: self.view.frame.width - 60, y: 55)
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 175))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        
        self.popover = Popover(options: self.popoverOptions)
        
        self.popover.show(tableView, point: startPoint)
    }
}
