//
//  UserSettingsViewController.swift
//  OCExpoX-Giveaway-iOS
//
//  Created by Selenzow, Eduard on 06.06.17.
//  Copyright © 2017 OPITZ CONSULTING GmbH. All rights reserved.
//

import UIKit

class UserSettingsViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var popViewIdentificationLabel: UILabel!
    @IBOutlet weak var popViewTextField: UITextField!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var popOverOkButton: UIButton!
    
    private let defaults = UserDefaults.standard
    private var keyBoardHeight = 0
    
    public static let defaultsBezeichner = "Bezeichner"
    public static let defaultsBeaconID = "BeaconID"
    public static let defaultsZeit = "Zeit"
    public static let defaultsDistanz = "Distanz"
    public static let defaultsFirstSetup = "FirstSetup"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.layer.cornerRadius = 10
        popView.layer.masksToBounds = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        popOverOkButton.isEnabled = false
        setTextFieldText()
        setKeyboardType()
        hideKeyboardWhenTappedAround()
        
        popViewTextField.delegate = self
        popViewTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    @IBAction func okButtonPressed(_ sender: UIButton) {
        saveContentOfTextField()
        defaults.set(true, forKey: UserSettingsViewController.defaultsFirstSetup)
        dismissView()
    }
    
    @IBAction func tappedOutOfPopover(_ sender: UIButton) {
        dismissView()
    }
    
    func saveContentOfTextField () {
        switch popViewIdentificationLabel.text! {
        case "Bezeichnung":
            defaults.set(popViewTextField.text!, forKey: UserSettingsViewController.defaultsBezeichner)
        case "BeaconID":
            defaults.set(popViewTextField.text!, forKey: UserSettingsViewController.defaultsBeaconID)
        case "Zeit":
            defaults.set(popViewTextField.text!, forKey: UserSettingsViewController.defaultsZeit)
        case "Distanz":
            defaults.set(popViewTextField.text!, forKey: UserSettingsViewController.defaultsDistanz)
        default:
            break
        }
    }
    
    func setTextFieldText() {
        switch popViewIdentificationLabel.text! {
        case "Bezeichnung":
            popViewTextField.text = defaults.string(forKey: UserSettingsViewController.defaultsBezeichner)
        case "BeaconID":
            popViewTextField.text = defaults.string(forKey: UserSettingsViewController.defaultsBeaconID)
        case "Zeit":
            popViewTextField.text = defaults.string(forKey: UserSettingsViewController.defaultsZeit)
        case "Distanz":
            popViewTextField.text = defaults.string(forKey: UserSettingsViewController.defaultsDistanz)
        default:
            break
        }

    }
    
    func textFieldDidChange(_ textField: UITextField){
        popOverOkButton.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UserSettingsViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    func setKeyboardType() {
        if popViewIdentificationLabel.text == "Bezeichnung"{
            self.popViewTextField.keyboardType = UIKeyboardType.alphabet
        }else{
            self.popViewTextField.keyboardType = UIKeyboardType.numberPad
        }
    }
}
