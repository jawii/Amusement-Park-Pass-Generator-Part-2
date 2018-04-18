//
//  ViewController.swift
//  Park Pass Generator Part 2
//
//  Created by Jaakko Kenttä on 18/04/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // Main entrant buttons
    @IBOutlet weak var guestBtn: UIButton!
    @IBOutlet weak var employeeBtn: UIButton!
    @IBOutlet weak var managerBtn: UIButton!
    @IBOutlet weak var vendorBtn: UIButton!
    
    // Sub entrant buttons
    @IBOutlet weak var entrantType1: UIButton!
    @IBOutlet weak var entrantType2: UIButton!
    @IBOutlet weak var entrantType3: UIButton!
    @IBOutlet weak var entrantType4: UIButton!
    @IBOutlet weak var entrantType5: UIButton!
    @IBOutlet weak var entrantType6: UIButton!
    
    
    // Info text fields
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var ssnTextField: UITextField!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var stateNameTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// Generate Pass Button
    @IBAction func generatePass(_ sender: Any) {
    }
    
    /// Populate data button
    @IBAction func populateData(_ sender: Any) {
    }
    
    /// Guest pass generator button
    @IBAction func entrantSelect(_ sender: Any){
        
        if let button = sender as? UIButton {
            switch button {
            case guestBtn:
                entrantType1.isHidden = false
                entrantType1.setTitle("Child", for: .normal)
                entrantType2.isHidden = false
                entrantType2.setTitle("Adult", for: .normal)
                entrantType3.isHidden = false
                entrantType3.setTitle("Senior", for: .normal)
                entrantType4.isHidden = false
                entrantType4.setTitle("VIP", for: .normal)
                entrantType5.isHidden = false
                entrantType5.setTitle("Season Pass", for: .normal)
                entrantType6.isHidden = false
                entrantType6.setTitle("Senior", for: .normal)
                
            case employeeBtn:
                entrantType1.isHidden = false
                entrantType1.setTitle("Ride Services", for: .normal)
                entrantType2.isHidden = false
                entrantType2.setTitle("Maintenance", for: .normal)
                entrantType3.isHidden = false
                entrantType3.setTitle("Food Services", for: .normal)
                entrantType4.isHidden = false
                entrantType4.setTitle("Contract Employee", for: .normal)
                entrantType5.isHidden = true
                entrantType6.isHidden = true
            case managerBtn:
                entrantType1.isHidden = false
                entrantType1.setTitle("Manager", for: .normal)
                entrantType2.isHidden = true
                entrantType3.isHidden = true
                entrantType4.isHidden = true
                entrantType5.isHidden = true
                entrantType6.isHidden = true
            case vendorBtn:
                entrantType1.setTitle("Vendor", for: .normal)
                entrantType2.isHidden = true
                entrantType3.isHidden = true
                entrantType4.isHidden = true
                entrantType5.isHidden = true
                entrantType6.isHidden = true
            default:
                print("Something is wrong!")
            }
        }
    }


}








