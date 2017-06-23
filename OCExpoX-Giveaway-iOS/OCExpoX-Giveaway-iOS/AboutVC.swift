//
//  AboutVC.swift
//  OCExpoX-Giveaway-iOS
//
//  Created by Selenzow, Eduard on 29.05.17.
//  Copyright © 2017 OPITZ CONSULTING GmbH. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        popView.layer.cornerRadius = 10
        popView.layer.masksToBounds = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
    }
    @IBAction func okButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        self.textView.setContentOffset(.zero, animated: false)
    }

    
    @IBAction func openProjektWeblink(_ sender: UIButton) {
        open(scheme: "https://github.com/opitzconsulting/inspire-IT-iOS-Giveaway")
    }
    
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: nil)
                }
        }
    }
}
