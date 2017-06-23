//
//  HelpVC.swift
//  OCExpoX-Giveaway-iOS
//
//  Created by Selenzow, Eduard on 29.05.17.
//  Copyright © 2017 OPITZ CONSULTING GmbH. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.layer.cornerRadius = 10
        popView.layer.masksToBounds = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    override func viewDidLayoutSubviews() {
        self.textView.setContentOffset(.zero, animated: false)
    }
    
    @IBAction func okButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
