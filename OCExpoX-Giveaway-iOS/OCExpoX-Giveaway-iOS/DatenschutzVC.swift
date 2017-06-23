//
//  DatenschutzVC.swift
//  OCExpoX-Giveaway-iOS
//
//  Created by Selenzow, Eduard on 29.05.17.
//  Copyright © 2017 OPITZ CONSULTING GmbH. All rights reserved.
//

import UIKit

class DatenschutzVC: UIViewController {
    
    @IBOutlet weak var popView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.layer.cornerRadius = 10
        popView.layer.masksToBounds = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
        @IBAction func okButtonPressed(_ sender: UIButton) {
            self.dismiss(animated: true, completion: nil)
    }
}
