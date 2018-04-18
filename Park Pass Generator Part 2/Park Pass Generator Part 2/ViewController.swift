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
    
    // Entrantypes (6 buttons)
    @IBOutlet var entrantTypes: [UIButton]!
    
    
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
        
        //hide all entrant buttons
        for btn in entrantTypes { btn.isHidden = true}
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
    @IBAction func mainEntrantSelect(_ sender: Any){
        
        if let button = sender as? UIButton {

            guestBtn.isSelected = false
            employeeBtn.isSelected = false
            managerBtn.isSelected = false
            vendorBtn.isSelected = false
            
            for btn in entrantTypes { btn.isHidden = true; btn.alpha = 0}
            delayOnMainThread(seconds: 0.25, action: {
                for btn in self.entrantTypes {
                    UIView.animate(withDuration: 0.2) {
                        btn.alpha = 1
                    }
                }
            })
            
            button.isSelected = true
            
            switch button {
            case guestBtn:
                entrantTypes[0].setTitle("Child", for: .normal)
                entrantTypes[0].isHidden = false
                entrantTypes[1].setTitle("Adult", for: .normal)
                entrantTypes[1].isHidden = false
                entrantTypes[2].setTitle("Senior", for: .normal)
                entrantTypes[2].isHidden = false
                entrantTypes[3].setTitle("VIP", for: .normal)
                entrantTypes[3].isHidden = false
                entrantTypes[4].setTitle("Season Pass", for: .normal)
                entrantTypes[4].isHidden = false
                entrantTypes[5].setTitle("Senior", for: .normal)
                entrantTypes[5].isHidden = false
            case employeeBtn:
                entrantTypes[0].isHidden = false
                entrantTypes[0].setTitle("Ride Services", for: .normal)
                entrantTypes[1].isHidden = false
                entrantTypes[1].setTitle("Maintenance", for: .normal)
                entrantTypes[2].isHidden = false
                entrantTypes[2].setTitle("Food Services", for: .normal)
                entrantTypes[3].isHidden = false
                entrantTypes[3].setTitle("Contract Employee", for: .normal)
                entrantTypes[4].isHidden = true
                entrantTypes[5].isHidden = true
            case managerBtn:
                entrantTypes[0].isHidden = false
                entrantTypes[0].setTitle("Manager", for: .normal)
                entrantTypes[1].isHidden = true
                entrantTypes[2].isHidden = true
                entrantTypes[3].isHidden = true
                entrantTypes[4].isHidden = true
                entrantTypes[5].isHidden = true
            case vendorBtn:
                entrantTypes[0].isHidden = false
                entrantTypes[0].setTitle("Vendor", for: .normal)
                entrantTypes[1].isHidden = true
                entrantTypes[2].isHidden = true
                entrantTypes[3].isHidden = true
                entrantTypes[4].isHidden = true
                entrantTypes[5].isHidden = true
            default:
                print("Something is wrong!")
            }
        }
    }
    
    @IBAction func entrantSelect(_ sender: Any) {
        
        if let button = sender as? UIButton {
            //deselect all
            for btn in entrantTypes { btn.isSelected = false }
            button.isSelected = true
        }
    }
    
    
    /// Adds delay
    func delayOnMainThread(seconds: Double, action:(() -> ())!) {
        
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64( seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            action()
        })
        
        let queue = DispatchQueue(label: "com.test.myqueue")
        queue.async {}
    }
}








